import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';
import 'package:project/widgets/immagine_salvata.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
    required this.database,
    required this.mensa,
    required this.utenteId,
    this.giornoRitiroIniziale,
    this.orarioRitiroIniziale,
  });

  final AppDatabase database;
  final MenseData mensa;
  final int utenteId;

  /// Giorno e orario di ritiro già scelti (es. da "Ordina ancora").
  final DateTime? giornoRitiroIniziale;
  final TimeOfDay? orarioRitiroIniziale;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  static const List<String> _categorie = [
    'PRIMI',
    'SECONDI',
    'CONTORNI',
    'DOLCI',
    'BEVANDE',
    'BAR',
  ];

  late final Future<List<_PastoOrdine>> _menu;
  final Map<int, int> _quantitaSelezionate = {};
  final Map<int, _PastoOrdine> _carrello = {};

  List<OrariAperturaData> _orariApertura = [];
  DateTime? _giornoRitiro;
  TimeOfDay? _orarioRitiro;
  final TextEditingController _notaController = TextEditingController();

  static const List<String> _giorniSettimana = [
    'Lunedì',
    'Martedì',
    'Mercoledì',
    'Giovedì',
    'Venerdì',
    'Sabato',
    'Domenica',
  ];

  static const LinearGradient _gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF4E4C4C), Color(0xFF913535)],
  );

  @override
  void initState() {
    super.initState();
    _giornoRitiro = widget.giornoRitiroIniziale;
    _orarioRitiro = widget.orarioRitiroIniziale;
    _menu = _caricaMenu();
    _caricaOrariApertura();
  }

  @override
  void dispose() {
    _notaController.dispose();
    super.dispose();
  }

  Future<void> _caricaOrariApertura() async {
    final orari = await widget.database.getOrariMensa(widget.mensa.id);
    if (!mounted) return;
    setState(() => _orariApertura = orari);
  }

  Future<List<_PastoOrdine>> _caricaMenu() async {
    final pasti = await widget.database.getMenuDiOggi(widget.mensa.id);
    final preferenzeUtente = await widget.database.getPreferenzeUtenteIds(
      widget.utenteId,
    );
    final allergieUtente = await widget.database.getAllergieUtenteIds(
      widget.utenteId,
    );
    // Disponibilità massima impostata dalla mensa per ogni piatto
    // (null = senza limite, solo righe vecchie).
    final disponibilita = await widget.database.getQuantitaMenuDiOggi(
      widget.mensa.id,
    );

    return Future.wait(
      pasti.map((pasto) async {
        final preferenze = await widget.database.getPreferenzePastoIds(
          pasto.id,
        );
        final allergie = await widget.database.getAllergiePastoIds(pasto.id);

        return _PastoOrdine(
          pasto: pasto,
          incompatibilePreferenza:
              preferenzeUtente.isNotEmpty &&
              !preferenzeUtente.any(preferenze.contains),
          bloccatoAllergia: allergieUtente.any(allergie.contains),
          disponibilita: disponibilita[pasto.id],
        );
      }),
    );
  }

  void _impostaQuantita(_PastoOrdine pasto, int quantita) {
    // Il contatore non supera mai la disponibilità massima del piatto.
    final disponibilita = pasto.disponibilita;
    final valore = (disponibilita != null && quantita > disponibilita)
        ? disponibilita
        : quantita;

    setState(() {
      if (valore <= 0) {
        _quantitaSelezionate.remove(pasto.pasto.id);
        _carrello.remove(pasto.pasto.id);
      } else {
        _quantitaSelezionate[pasto.pasto.id] = valore;
        _carrello[pasto.pasto.id] = _PastoOrdine(
          pasto: pasto.pasto,
          incompatibilePreferenza: pasto.incompatibilePreferenza,
          bloccatoAllergia: pasto.bloccatoAllergia,
          quantita: valore,
          disponibilita: pasto.disponibilita,
        );
      }
    });
  }

  double get _totaleCarrello => _carrello.values.fold(
    0,
    (totale, elemento) => totale + elemento.pasto.prezzo * elemento.quantita,
  );

  void _svuotaCarrello() {
    setState(() {
      _carrello.clear();
      _quantitaSelezionate.clear();
    });
  }

  Future<void> _inviaOrdine() async {
    if (_carrello.isEmpty) return;

    if (!_ritiroValido) {
      _mostraMessaggio(
        _giornoRitiro == null || _orarioRitiro == null
            ? 'Seleziona il giorno e l\'orario del ritiro.'
            : 'L\'orario di ritiro non è valido: controlla gli orari '
                  'di apertura della sede e l\'anticipo di un\'ora.',
      );
      return;
    }

    final confermato = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Conferma ordine'),
        content: Text(
          'Ritiro: $_testoGiorno alle $_testoOrario\n'
          'Ordine: $_piattiTotali piatti per '
          '${_totaleCarrello.toStringAsFixed(2)} €'
          '${_notaTesto.isEmpty ? '?' : '.\nNota per la mensa: $_notaTesto'}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF913535),
              foregroundColor: Colors.white,
            ),
            child: const Text('Invia'),
          ),
        ],
      ),
    );

    if (confermato != true || !mounted) return;

    try {
      await widget.database.salvaOrdine(
        utenteId: widget.utenteId,
        mensaId: widget.mensa.id,
        giornoRitiro: _giornoRitiro!,
        orarioRitiro: _testoOrario,
        nota: _notaTesto,
        totale: _totaleCarrello,
        piattiTotali: _piattiTotali,
        piatti: _carrello.values
            .map((elemento) => (elemento.pasto, elemento.quantita))
            .toList(),
      );
    } catch (e) {
      if (!mounted) return;
      _mostraMessaggio('Errore durante il salvataggio dell\'ordine: $e');
      return;
    }

    setState(() {
      _carrello.clear();
      _quantitaSelezionate.clear();
      _notaController.clear();
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ordine inviato con successo.')),
    );
  }

  // =========================================================
  // GIORNO E ORARIO DI RITIRO
  // =========================================================

  DateTime get _oggi {
    final ora = DateTime.now();
    return DateTime(ora.year, ora.month, ora.day);
  }

  String get _testoGiorno {
    final giorno = _giornoRitiro;
    if (giorno == null) return 'Scegli giorno';
    return '${giorno.day.toString().padLeft(2, '0')}/'
        '${giorno.month.toString().padLeft(2, '0')}/'
        '${giorno.year}';
  }

  String get _testoOrario {
    final orario = _orarioRitiro;
    if (orario == null) return 'Scegli orario';
    return '${orario.hour.toString().padLeft(2, '0')}:'
        '${orario.minute.toString().padLeft(2, '0')}';
  }

  bool get _ritiroOggiSelezionato =>
      _giornoRitiro != null && !_giornoRitiro!.isAfter(_oggi);

  /// Finestre di apertura della sede nel giorno indicato: coppie
  /// (apertura, chiusura) espresse in minuti da mezzanotte.
  List<(int, int)> _finestreApertura(DateTime giorno) {
    final nomeGiorno = _giorniSettimana[giorno.weekday - 1];
    return _orariApertura
        .where((orario) => orario.giorno == nomeGiorno)
        .map((orario) => (orario.aperturaMinuti, orario.chiusuraMinuti))
        .toList()
      ..sort((a, b) => a.$1.compareTo(b.$1));
  }

  String _testoMinuti(int minuti) =>
      '${(minuti ~/ 60).toString().padLeft(2, '0')}:'
      '${(minuti % 60).toString().padLeft(2, '0')}';

  TimeOfDay _orarioDaMinuti(int minuti) =>
      TimeOfDay(hour: minuti ~/ 60, minute: minuti % 60);

  String get _testoApertura {
    final giorno = _giornoRitiro;
    if (giorno == null) return '';

    final finestre = _finestreApertura(giorno);
    if (finestre.isEmpty) {
      return 'La sede non è aperta in questo giorno.';
    }

    final segmenti = [
      for (final (apertura, chiusura) in finestre)
        '${_testoMinuti(apertura)} - ${_testoMinuti(chiusura)}',
    ];
    return 'Apertura sede: ${segmenti.join('  ·  ')}';
  }

  /// Orario iniziale proposto dal picker: il primo slot di apertura ancora
  /// utilizzabile (per oggi con almeno un'ora di anticipo), allineato
  /// ai 10 minuti. Ritorna null se non ce ne sono.
  TimeOfDay? _orarioInizialeSuggerito(List<(int, int)> finestre) {
    var soglia = 0;
    if (_ritiroOggiSelezionato) {
      final ora = DateTime.now();
      soglia = ora.hour * 60 + ora.minute + 60;
    }

    for (final (apertura, chiusura) in finestre) {
      final inizio = apertura > soglia ? apertura : soglia;
      final inizioArrotondato = (inizio + 9) ~/ 10 * 10;
      if (inizioArrotondato < chiusura) {
        return _orarioDaMinuti(inizioArrotondato);
      }
    }
    return null;
  }

  /// Un orario è accettabile se:
  /// - cade in un multiplo di 10 minuti;
  /// - rientra nell'orario di apertura della sede nel giorno scelto;
  /// - se il giorno è oggi, è inoltre oltre un'ora da adesso.
  bool _orarioAccettabile(TimeOfDay orario) {
    final giorno = _giornoRitiro;
    if (giorno == null) return false;
    if (orario.minute % 10 != 0) return false;

    final minuti = orario.hour * 60 + orario.minute;
    final dentroApertura = _finestreApertura(giorno)
        .any((finestra) => minuti >= finestra.$1 && minuti < finestra.$2);
    if (!dentroApertura) return false;

    if (giorno.isAfter(_oggi)) return true;

    final istanteRitiro = DateTime(
      giorno.year,
      giorno.month,
      giorno.day,
      orario.hour,
      orario.minute,
    );
    final limite = DateTime.now().add(const Duration(hours: 1));
    return istanteRitiro.isAfter(limite);
  }

  bool get _ritiroValido =>
      _giornoRitiro != null &&
      _orarioRitiro != null &&
      _orarioAccettabile(_orarioRitiro!);

  void _mostraMessaggio(String messaggio) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(messaggio)));
  }

  Future<void> _scegliGiorno() async {
    final giornoSelezionato = await showDatePicker(
      context: context,
      initialDate: _giornoRitiro ?? _oggi,
      firstDate: _oggi,
      lastDate: _oggi.add(const Duration(days: 30)),
      helpText: 'GIORNO DI RITIRO',
    );

    if (giornoSelezionato == null || !mounted) return;

    final orarioPrecedente = _orarioRitiro;
    setState(() {
      _giornoRitiro = DateTime(
        giornoSelezionato.year,
        giornoSelezionato.month,
        giornoSelezionato.day,
      );
      // Se l'orario scelto in precedenza non è valido per il nuovo giorno,
      // va azzerato per essere riscegliuto.
      if (orarioPrecedente != null && !_orarioAccettabile(orarioPrecedente)) {
        _orarioRitiro = null;
      }
    });

    if (orarioPrecedente != null && _orarioRitiro == null) {
      _mostraMessaggio(
        'L\'orario selezionato non è valido per il giorno scelto: '
        'scegli un nuovo orario.',
      );
    }
  }

  /// Motivo per cui un orario scelto non può essere accettato, oppure null
  /// se è valido. Usato sia all'apertura del picker sia prima dell'invio.
  String? _motivoRifiuto(TimeOfDay orario, List<(int, int)> finestre) {
    final minuti = orario.hour * 60 + orario.minute;
    final dentroApertura = finestre.any(
      (finestra) => minuti >= finestra.$1 && minuti < finestra.$2,
    );
    if (!dentroApertura) {
      return 'L\'orario scelto è fuori dall\'orario di apertura della sede.';
    }
    if (!_orarioAccettabile(orario)) {
      return 'Per oggi puoi scegliere solo orari oltre un\'ora da adesso.';
    }
    return null;
  }

  Future<void> _scegliOrario() async {
    final giorno = _giornoRitiro;
    if (giorno == null) return;

    final finestre = _finestreApertura(giorno);
    if (finestre.isEmpty) {
      _mostraMessaggio('La sede non è aperta nel giorno selezionato.');
      return;
    }

    while (mounted) {
      final suggerito = _orarioRitiro ?? _orarioInizialeSuggerito(finestre);
      if (suggerito == null) {
        _mostraMessaggio(
          'Per oggi non restano orari con almeno un\'ora di anticipo.',
        );
        return;
      }

      final orarioSelezionato = await showTimePicker(
        context: context,
        initialTime: suggerito,
        helpText: 'ORARIO DI RITIRO',
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (orarioSelezionato == null || !mounted) return;

      if (orarioSelezionato.minute % 10 != 0) {
        _mostraMessaggio(
          'Gli orari di ritiro scadono ogni 10 minuti: '
          'scegli un multiplo di 10.',
        );
        continue;
      }

      final motivo = _motivoRifiuto(orarioSelezionato, finestre);
      if (motivo != null) {
        _mostraMessaggio(motivo);
        continue;
      }

      setState(() => _orarioRitiro = orarioSelezionato);
      return;
    }
  }

  int get _piattiTotali => _carrello.values.fold(
    0,
    (totale, elemento) => totale + elemento.quantita,
  );

  Widget _indicatore(_PastoOrdine pasto) {
    // Le categorie BEVANDE e BAR non mostrano i puntini di allergie/preferenze.
    if (pasto.pasto.categoria == 'BEVANDE' ||
        pasto.pasto.categoria == 'BAR') {
      // Spazio mantenuto per non disallineare le righe del menu.
      return const SizedBox(width: 12, height: 12);
    }
    if (pasto.bloccatoAllergia) {
      return const Icon(Icons.circle, color: Colors.red, size: 12);
    }
    if (pasto.incompatibilePreferenza) {
      return const Icon(Icons.circle, color: Colors.amber, size: 12);
    }
    return const Icon(Icons.circle, color: Colors.green, size: 12);
  }

  Widget _selettoreQuantita(_PastoOrdine pasto) {
    final quantita = _quantitaSelezionate[pasto.pasto.id] ?? 0;
    final disponibilita = pasto.disponibilita;
    // Pulsante '+' bloccato quando si raggiunge la disponibilità massima.
    final alLimite = disponibilita != null && quantita >= disponibilita;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: quantita == 0
                ? null
                : () => _impostaQuantita(pasto, quantita - 1),
            icon: const Icon(Icons.remove, size: 17),
            constraints: const BoxConstraints.tightFor(width: 30, height: 30),
            padding: EdgeInsets.zero,
          ),
          SizedBox(
            width: 24,
            child: Text('$quantita', textAlign: TextAlign.center),
          ),
          IconButton(
            onPressed: alLimite
                ? null
                : () => _impostaQuantita(pasto, quantita + 1),
            icon: const Icon(Icons.add, size: 17),
            constraints: const BoxConstraints.tightFor(width: 30, height: 30),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _menuColumn(List<_PastoOrdine> menu) {
    final categoriePresenti = _categorie
        .where(
          (categoria) =>
              menu.any((pasto) => pasto.pasto.categoria == categoria),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var indice = 0; indice < categoriePresenti.length; indice++) ...[
          if (indice > 0) const Divider(height: 24),
          Text(
            categoriePresenti[indice],
            style: GoogleFonts.raleway(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          for (final pasto in menu.where(
            (pasto) => pasto.pasto.categoria == categoriePresenti[indice],
          ))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  _indicatore(pasto),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pasto.pasto.nome),
                        // Disponibilità massima impostata dalla mensa.
                        if (pasto.disponibilita != null)
                          Text(
                            'Disponibile: ${pasto.disponibilita}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      onPressed: () => _mostraInfoPasto(pasto.pasto),
                      tooltip: 'Info piatto',
                      icon: const Icon(Icons.help_outline, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _selettoreQuantita(pasto),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 62,
                    child: Text(
                      '${pasto.pasto.prezzo.toStringAsFixed(2)} €',
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  /// Stessa scheda informativa del piatto mostrata in MensaUpage
  /// aprendo il menu ("Mostra menu") e premendo l'icona "?".
  Future<void> _mostraInfoPasto(PastiData pasto) async {
    final allergeni = await widget.database.getAllergiePasto(pasto.id);
    final preferenze = await widget.database.getPreferenzePasto(pasto.id);

    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(pasto.nome),
        content: SizedBox(
          width: 440,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImmagineSalvata(
                  bytes: pasto.immagine,
                  width: double.infinity,
                  height: 150,
                  cerchio: false,
                  icona: Icons.image_not_supported_outlined,
                ),
                const SizedBox(height: 16),
                Text(
                  'Descrizione',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pasto.descrizione.trim().isEmpty
                      ? 'Nessuna descrizione disponibile.'
                      : pasto.descrizione,
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Allergeni',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      allergeni.isEmpty
                          ? 'Nessun allergene selezionato.'
                          : allergeni
                                .map((allergene) => '• ${allergene.nome}')
                                .toList()
                                .join('\n'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Tipo di pasto',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  preferenze.isEmpty
                      ? 'Nessuna preferenza selezionata.'
                      : preferenze
                            .map((preferenza) => preferenza.nome)
                            .join(', '),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );
  }

  /// Nota per la mensa, pulita dagli spazi ai margini.
  String get _notaTesto => _notaController.text.trim();

  Widget _riquadroRitiro() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Ritiro',
            style: GoogleFonts.raleway(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Scegli il giorno e l\'orario del ritiro.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _scegliGiorno,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF913535),
                    side: const BorderSide(color: Color(0xFF913535)),
                  ),
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: Text(_testoGiorno),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _giornoRitiro == null ? null : _scegliOrario,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF913535),
                    side: const BorderSide(color: Color(0xFF913535)),
                  ),
                  icon: const Icon(Icons.schedule, size: 16),
                  label: Text(_testoOrario),
                ),
              ),
            ],
          ),
          if (_giornoRitiro != null) ...[
            const SizedBox(height: 8),
            Text(
              _testoApertura,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
          if (_ritiroOggiSelezionato) ...[
            const SizedBox(height: 4),
            Text(
              'Per la data di oggi sono ammessi solo orari oltre un\'ora da adesso.',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ],
      ),
    );
  }

  Widget _riquadroNota() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Nota per la mensa',
            style: GoogleFonts.raleway(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          const SizedBox(height: 10),
          TextField(
            controller: _notaController,
            minLines: 2,
            maxLines: 4,
            maxLength: 300,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Inserisci una nota per la mensa (opzionale)',
              hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600.withOpacity(0.5),
              ),
              counterStyle: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _carrelloColumn() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Carrello',
              style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (_carrello.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('Il carrello è vuoto.'),
              )
            else ...[
              for (final elemento in _carrello.values)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${elemento.quantita} × ${elemento.pasto.nome}',
                        ),
                      ),
                      Text(
                        '${(elemento.pasto.prezzo * elemento.quantita).toStringAsFixed(2)} €',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Totale piatti: $_piattiTotali'),
                  Text(
                    'Subtotale: ${_totaleCarrello.toStringAsFixed(2)} €',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: _svuotaCarrello,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF913535),
                  side: const BorderSide(color: Color(0xFF913535)),
                ),
                child: const Text('Svuota carrello'),
              ),
              _riquadroRitiro(),
              _riquadroNota(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _inviaOrdine,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF913535),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Invia ordine'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4E4C4C),
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/assets/images/logo_app.png',
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 10),
            Text(
              'MensApp',
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: _gradient),
        child: FutureBuilder<List<_PastoOrdine>>(
          future: _menu,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Impossibile caricare il menu.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final menu = snapshot.data ?? [];
            if (menu.isEmpty) {
              return const Center(
                child: Text(
                  'Il menu di oggi non è disponibile.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final menuPanel = Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _menuColumn(menu),
                        ),
                      );

                      if (constraints.maxWidth < 760) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            menuPanel,
                            const SizedBox(height: 16),
                            _carrelloColumn(),
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: menuPanel),
                          const SizedBox(width: 16),
                          Expanded(child: _carrelloColumn()),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PastoOrdine {
  const _PastoOrdine({
    required this.pasto,
    required this.incompatibilePreferenza,
    required this.bloccatoAllergia,
    this.quantita = 0,
    this.disponibilita,
  });

  final PastiData pasto;
  final bool incompatibilePreferenza;
  final bool bloccatoAllergia;
  final int quantita;

  /// Disponibilità massima impostata dalla mensa per questo piatto
  /// nel menù di oggi (null = senza limite, solo righe vecchie).
  final int? disponibilita;
}
