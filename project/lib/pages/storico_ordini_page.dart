import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';

class StoricoOrdiniPage extends StatefulWidget {
  const StoricoOrdiniPage({
    super.key,
    required this.database,
    required this.utenteId,
  });

  final AppDatabase database;
  final int utenteId;

  @override
  State<StoricoOrdiniPage> createState() => _StoricoOrdiniPageState();
}

class _StoricoOrdiniPageState extends State<StoricoOrdiniPage> {
  static const LinearGradient _gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF4E4C4C), Color(0xFF913535)],
  );

  late Future<List<OrdineCompleto>> _ordini;

  @override
  void initState() {
    super.initState();
    _ordini = widget.database.getStoricoOrdiniUtente(widget.utenteId);
  }

  String _testoData(DateTime data) =>
      '${data.day.toString().padLeft(2, '0')}/'
      '${data.month.toString().padLeft(2, '0')}/'
      '${data.year}';

  String _testoDataInvio(DateTime dataInvio) =>
      '${_testoData(dataInvio)} ore '
      '${dataInvio.hour.toString().padLeft(2, '0')}:'
      '${dataInvio.minute.toString().padLeft(2, '0')}';

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
        child: FutureBuilder<List<OrdineCompleto>>(
          future: _ordini,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Impossibile caricare lo storico ordini.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final ordini = snapshot.data ?? [];
            if (ordini.isEmpty) {
              return const Center(
                child: Text(
                  'Nessun ordine nello storico.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            // ===============================================
            // ELENCO COMPLETO: tutti gli ordini, anche quelli
            // vecchi, dal più recente al meno recente.
            // ===============================================
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final elemento in ordini) ...[
                        _rigaOrdine(elemento),
                        const SizedBox(height: 8),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // RIGA STORICO: data, orario, nome mensa e dettaglio
  //
  // Prima la data, poi l'orario, poi il nome della mensa.
  // Nessuno stato e nessun pulsante "X": lo storico è in
  // sola lettura.
  // =========================================================

  Widget _rigaOrdine(OrdineCompleto elemento) {
    final ordine = elemento.ordine;
    final nomeMensa = elemento.mensa?.nomeMensa ?? 'Mensa';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // =============================================
          // SCHERMO STRETTO: DUE RIGHE NELLO STESSO CONTAINER
          // - sopra: data, orario e nome della mensa;
          // - sotto: i due pulsanti.
          // =============================================
          if (constraints.maxWidth < 560) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // DATA + ORARIO + NOME MENSA
                Row(
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _testoData(ordine.giornoRitiro),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              ordine.orarioRitiro,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        nomeMensa,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // I DUE PULSANTI
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _mostraDettaglioOrdine(elemento),
                      icon: const Icon(Icons.visibility, size: 18),
                      label: const Text('Ordine'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF913535),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () => _mostraDialogoOrdinaAncora(elemento),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF913535),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const Text('Ordina ancora'),
                    ),
                  ],
                ),
              ],
            );
          }

          // =============================================
          // SCHERMO LARGO: TUTTO SU UNA SOLA RIGA
          // =============================================
          return Row(
            children: [
              // ===============================================
              // PRIMA LA DATA, POI L'ORARIO
              // ===============================================
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _testoData(ordine.giornoRitiro),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        ordine.orarioRitiro,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  nomeMensa,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),

              const SizedBox(width: 8),

              ElevatedButton.icon(
                onPressed: () => _mostraDettaglioOrdine(elemento),
                icon: const Icon(Icons.visibility, size: 18),
                label: const Text('Ordine'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF913535),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  visualDensity: VisualDensity.compact,
                ),
              ),

              const SizedBox(width: 4),

              TextButton(
                onPressed: () => _mostraDialogoOrdinaAncora(elemento),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF913535),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  visualDensity: VisualDensity.compact,
                ),
                child: const Text('Ordina ancora'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _mostraDettaglioOrdine(OrdineCompleto elemento) async {
    final ordine = elemento.ordine;
    final nomeMensa = elemento.mensa?.nomeMensa ?? 'Mensa';

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          nomeMensa,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        content: SizedBox(
          width: 440,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  'Ritiro: ${_testoData(ordine.giornoRitiro)} '
                  'alle ${ordine.orarioRitiro}',
                ),
                const SizedBox(height: 6),
                Text(
                  'Ordine inviato il ${_testoDataInvio(ordine.dataInvio)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const Divider(height: 24),
                Text(
                  'Piatti ordinati',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                for (final piatto in elemento.piatti)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${piatto.quantita} × ${piatto.nomePasto}',
                          ),
                        ),
                        Text(
                          '${(piatto.prezzo * piatto.quantita).toStringAsFixed(2)} €',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Piatti totali: ${ordine.piattiTotali}'),
                    Text(
                      'Totale: ${ordine.totale.toStringAsFixed(2)} €',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Note',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ordine.nota.trim().isEmpty ? 'Nessuna nota.' : ordine.nota,
                    style: const TextStyle(fontSize: 14),
                  ),
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

  // =========================================================
  // REGOLE DATA E ORARIO DI RITIRO
  //
  // Stesse regole della pagina di ordine (OrderPage): giorno
  // da oggi a 30 giorni avanti, orario multiplo di 10 minuti
  // dentro l'apertura della sede e, se il giorno è oggi, con
  // almeno un'ora di anticipo.
  // =========================================================

  static const List<String> _giorniSettimana = [
    'Lunedì',
    'Martedì',
    'Mercoledì',
    'Giovedì',
    'Venerdì',
    'Sabato',
    'Domenica',
  ];

  DateTime get _oggi {
    final ora = DateTime.now();
    return DateTime(ora.year, ora.month, ora.day);
  }

  String _testoOrario(TimeOfDay? orario) {
    if (orario == null) return 'Scegli orario';
    return '${orario.hour.toString().padLeft(2, '0')}:'
        '${orario.minute.toString().padLeft(2, '0')}';
  }

  void _mostraMessaggio(String messaggio) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(messaggio)));
  }

  /// Finestre di apertura della sede nel giorno indicato: coppie
  /// (apertura, chiusura) espresse in minuti da mezzanotte.
  List<(int, int)> _finestreApertura(
    List<OrariAperturaData> orari,
    DateTime giorno,
  ) {
    final nomeGiorno = _giorniSettimana[giorno.weekday - 1];
    return orari
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

  /// Orario iniziale proposto dal picker: il primo slot di apertura
  /// ancora utilizzabile (per oggi con almeno un'ora di anticipo),
  /// allineato ai 10 minuti. Ritorna null se non ce ne sono.
  TimeOfDay? _orarioInizialeSuggerito(
    List<OrariAperturaData> orari,
    DateTime giorno,
  ) {
    var soglia = 0;
    if (!giorno.isAfter(_oggi)) {
      final ora = DateTime.now();
      soglia = ora.hour * 60 + ora.minute + 60;
    }

    for (final (apertura, chiusura) in _finestreApertura(orari, giorno)) {
      final inizio = apertura > soglia ? apertura : soglia;
      final inizioArrotondato = (inizio + 9) ~/ 10 * 10;
      if (inizioArrotondato < chiusura) {
        return _orarioDaMinuti(inizioArrotondato);
      }
    }
    return null;
  }

  bool _orarioAccettabile({
    required List<OrariAperturaData> orari,
    required DateTime giorno,
    required TimeOfDay orario,
  }) {
    if (orario.minute % 10 != 0) return false;

    final minuti = orario.hour * 60 + orario.minute;
    final dentroApertura = _finestreApertura(
      orari,
      giorno,
    ).any((finestra) => minuti >= finestra.$1 && minuti < finestra.$2);
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

  /// Motivo per cui un orario scelto non può essere accettato,
  /// oppure null se è valido.
  String? _motivoRifiuto({
    required List<OrariAperturaData> orari,
    required DateTime giorno,
    required TimeOfDay orario,
  }) {
    final minuti = orario.hour * 60 + orario.minute;
    final dentroApertura = _finestreApertura(
      orari,
      giorno,
    ).any((finestra) => minuti >= finestra.$1 && minuti < finestra.$2);
    if (!dentroApertura) {
      return 'L\'orario scelto è fuori dall\'orario di apertura della sede.';
    }
    if (!_orarioAccettabile(orari: orari, giorno: giorno, orario: orario)) {
      return 'Per oggi puoi scegliere solo orari oltre un\'ora da adesso.';
    }
    return null;
  }

  Future<void> _mostraDialogoOrdinaAncora(OrdineCompleto elemento) async {
    final mensa = elemento.mensa;
    if (mensa == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Mensa non disponibile.')));
      return;
    }

    final orariApertura = await widget.database.getOrariMensa(mensa.id);
    if (!mounted) return;

    // =========================================================
    // RIEPILOGO DELL'ORDINE DA RIPETERE: piatti e note.
    // La nota è modificabile, così si può aggiustare prima
    // di reinviare l'ordine alla mensa.
    // =========================================================
    final ordine = elemento.ordine;
    final piatti = elemento.piatti;
    final totale = piatti.fold<double>(
      0,
      (somma, piatto) => somma + piatto.prezzo * piatto.quantita,
    );
    final piattiTotali = piatti.fold<int>(
      0,
      (somma, piatto) => somma + piatto.quantita,
    );
    final notaController = TextEditingController(text: ordine.nota);

    DateTime? giorno;
    TimeOfDay? orario;

    final risultato = await showDialog<(DateTime, TimeOfDay)>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final giornoSel = giorno;
          final finestre = giornoSel == null
              ? <(int, int)>[]
              : _finestreApertura(orariApertura, giornoSel);

          String testoApertura;
          if (giornoSel == null) {
            testoApertura =
                'Scegli il giorno per vedere gli orari di apertura.';
          } else if (finestre.isEmpty) {
            testoApertura = 'La sede non è aperta in questo giorno.';
          } else {
            final segmenti = [
              for (final (apertura, chiusura) in finestre)
                '${_testoMinuti(apertura)} - ${_testoMinuti(chiusura)}',
            ];
            testoApertura = 'Apertura sede: ${segmenti.join('  ·  ')}';
          }

          return AlertDialog(
            title: const Text('Ordina ancora'),
            content: SizedBox(
              width: 440,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mensa.nomeMensa,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 14),

                    // ===========================================
                    // PRIMA L'ORDINE (con note modificabili),
                    // POI LA SCELTA DI GIORNO E ORARIO
                    // ===========================================
                    Text(
                      'Il tuo ultimo ordine',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final piatto in piatti)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${piatto.quantita} × ${piatto.nomePasto}',
                                    ),
                                  ),
                                  Text(
                                    '${(piatto.prezzo * piatto.quantita).toStringAsFixed(2)} €',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const Divider(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Piatti totali: $piattiTotali'),
                              Text(
                                'Totale: ${totale.toStringAsFixed(2)} €',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Note',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: notaController,
                      minLines: 1,
                      maxLines: 3,
                      maxLength: 300,
                      decoration: const InputDecoration(
                        hintText: 'Note per la mensa (facoltative)',
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const Divider(height: 24),

                    // ===========================================
                    // GIORNO
                    // ===========================================
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Color(0xFF913535),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {
                              final selezionato = await showDatePicker(
                                context: context,
                                initialDate: giornoSel ?? _oggi,
                                firstDate: _oggi,
                                lastDate: _oggi.add(const Duration(days: 30)),
                                helpText: 'GIORNO DI RITIRO',
                              );
                              if (selezionato == null || !mounted) return;

                              final orarioPrecedente = orario;
                              setDialogState(() {
                                final nuovoGiorno = DateTime(
                                  selezionato.year,
                                  selezionato.month,
                                  selezionato.day,
                                );
                                giorno = nuovoGiorno;
                                // Se l'orario scelto prima non è valido per il
                                // nuovo giorno, va azzerato per essere riscelto.
                                if (orarioPrecedente != null &&
                                    !_orarioAccettabile(
                                      orari: orariApertura,
                                      giorno: nuovoGiorno,
                                      orario: orarioPrecedente,
                                    )) {
                                  orario = null;
                                }
                              });

                              if (orarioPrecedente != null && orario == null) {
                                _mostraMessaggio(
                                  'L\'orario selezionato non è valido per il '
                                  'giorno scelto: scegli un nuovo orario.',
                                );
                              }
                            },
                            child: Text(
                              giornoSel == null
                                  ? 'Scegli giorno'
                                  : _testoData(giornoSel),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 18,
                          color: Color(0xFF913535),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: giornoSel == null
                                ? null
                                : () async {
                                    final g = giorno;
                                    if (g == null) return;

                                    final finestreGiorno = _finestreApertura(
                                      orariApertura,
                                      g,
                                    );
                                    if (finestreGiorno.isEmpty) {
                                      _mostraMessaggio(
                                        'La sede non è aperta nel giorno '
                                        'selezionato.',
                                      );
                                      return;
                                    }

                                    while (mounted) {
                                      final suggerito =
                                          orario ??
                                          _orarioInizialeSuggerito(
                                            orariApertura,
                                            g,
                                          );
                                      if (suggerito == null) {
                                        _mostraMessaggio(
                                          'Per oggi non restano orari con almeno '
                                          'un\'ora di anticipo.',
                                        );
                                        return;
                                      }

                                      final scelto = await showTimePicker(
                                        context: context,
                                        initialTime: suggerito,
                                        helpText: 'ORARIO DI RITIRO',
                                        builder: (context, child) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                  alwaysUse24HourFormat: true,
                                                ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (scelto == null) return;

                                      if (scelto.minute % 10 != 0) {
                                        _mostraMessaggio(
                                          'Gli orari di ritiro scadono ogni 10 '
                                          'minuti: scegli un multiplo di 10.',
                                        );
                                        continue;
                                      }

                                      final motivo = _motivoRifiuto(
                                        orari: orariApertura,
                                        giorno: g,
                                        orario: scelto,
                                      );
                                      if (motivo != null) {
                                        _mostraMessaggio(motivo);
                                        continue;
                                      }

                                      setDialogState(() => orario = scelto);
                                      return;
                                    }
                                  },
                            child: Text(_testoOrario(orario)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      testoApertura,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Annulla'),
              ),
              ElevatedButton(
                onPressed: () {
                  final g = giorno;
                  final o = orario;
                  if (g == null || o == null) {
                    _mostraMessaggio(
                      'Seleziona il giorno e l\'orario del ritiro.',
                    );
                    return;
                  }
                  if (!_orarioAccettabile(
                    orari: orariApertura,
                    giorno: g,
                    orario: o,
                  )) {
                    _mostraMessaggio(
                      'L\'orario di ritiro non è valido: controlla gli orari '
                      'di apertura della sede e l\'anticipo di un\'ora.',
                    );
                    return;
                  }
                  Navigator.pop(dialogContext, (g, o));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF913535),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Continua'),
              ),
            ],
          );
        },
      ),
    );

    final notaTesto = notaController.text.trim();
    notaController.dispose();

    if (risultato == null || !mounted) return;

    // Premendo "Continua" l'ordine (piatti + note aggiornate) viene
    // inviato direttamente alla mensa con il giorno e l'orario scelti.
    await _inviaOrdineRipetuto(
      mensaId: mensa.id,
      piatti: elemento.piatti,
      giornoRitiro: risultato.$1,
      orarioRitiro: risultato.$2,
      nota: notaTesto,
    );
  }

  Future<void> _inviaOrdineRipetuto({
    required int mensaId,
    required List<OrdinePiattiData> piatti,
    required DateTime giornoRitiro,
    required TimeOfDay orarioRitiro,
    required String nota,
  }) async {
    try {
      await widget.database.salvaOrdineRipetuto(
        utenteId: widget.utenteId,
        mensaId: mensaId,
        giornoRitiro: giornoRitiro,
        orarioRitiro: _testoOrario(orarioRitiro),
        nota: nota,
        piatti: piatti,
      );
    } catch (e) {
      if (!mounted) return;
      _mostraMessaggio("Errore durante l'invio dell'ordine: $e");
      return;
    }

    if (!mounted) return;

    // Lo storico viene ricaricato così il nuovo ordine appare subito.
    setState(() {
      _ordini = widget.database.getStoricoOrdiniUtente(widget.utenteId);
    });

    _mostraMessaggio('Ordine inviato alla mensa.');
  }
}
