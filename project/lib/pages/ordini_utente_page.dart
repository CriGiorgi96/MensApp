import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';

class OrdiniUtentePage extends StatefulWidget {
  const OrdiniUtentePage({
    super.key,
    required this.database,
    required this.utenteId,
  });

  final AppDatabase database;
  final int utenteId;

  @override
  State<OrdiniUtentePage> createState() => _OrdiniUtentePageState();
}

class _OrdiniUtentePageState extends State<OrdiniUtentePage> {
  static const LinearGradient _gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF4E4C4C), Color(0xFF913535)],
  );

  late Future<List<OrdineCompleto>> _ordini;

  @override
  void initState() {
    super.initState();
    _ordini = widget.database.getOrdiniUtente(widget.utenteId);
  }

  String _testoData(DateTime data) =>
      '${data.day.toString().padLeft(2, '0')}/'
      '${data.month.toString().padLeft(2, '0')}/'
      '${data.year}';

  String _testoDataInvio(DateTime dataInvio) =>
      '${_testoData(dataInvio)} ore '
      '${dataInvio.hour.toString().padLeft(2, '0')}:'
      '${dataInvio.minute.toString().padLeft(2, '0')}';

  /// Verifica che due date si riferiscano alla stessa giornata.
  bool _stessoGiorno(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Ricarica l'elenco (dopo l'eliminazione di un ordine).
  void _ricaricaOrdini() {
    if (!mounted) return;
    setState(() {
      _ordini = widget.database.getOrdiniUtente(widget.utenteId);
    });
  }

  /// Data e ora esatte del ritiro dell'ordine.
  DateTime _momentoRitiro(OrdiniData ordine) {
    final parti = ordine.orarioRitiro.split(':');
    final ora = int.tryParse(parti[0]) ?? 0;
    final minuto = parti.length > 1 ? (int.tryParse(parti[1]) ?? 0) : 0;

    final ritiro = ordine.giornoRitiro;
    return DateTime(ritiro.year, ritiro.month, ritiro.day, ora, minuto);
  }

  bool _puoEliminare(OrdiniData ordine) {
    if (ordine.stato == 'Ritirato') {
      return false;
    }

    final limite = _momentoRitiro(ordine).subtract(const Duration(hours: 1));

    return !DateTime.now().isAfter(limite);
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
        child: FutureBuilder<List<OrdineCompleto>>(
          future: _ordini,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Impossibile caricare gli ordini.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final tuttiGliOrdini = snapshot.data ?? [];
            if (tuttiGliOrdini.isEmpty) {
              return const Center(
                child: Text(
                  'Non hai ancora inviato ordini.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            final oggi = DateTime.now();
            final inizioOggi = DateTime(oggi.year, oggi.month, oggi.day);

            final attivi = <OrdineCompleto>[];
            final ritiratiOggi = <OrdineCompleto>[];

            for (final elemento in tuttiGliOrdini) {
              final ordine = elemento.ordine;

              // Ritiri passati: non visualizzati.
              if (ordine.giornoRitiro.isBefore(inizioOggi)) {
                continue;
              }

              // Ritirati oggi: restano in pagina ma in fondo, in grigio.
              if (_stessoGiorno(ordine.giornoRitiro, inizioOggi) &&
                  ordine.stato == 'Ritirato') {
                ritiratiOggi.add(elemento);
                continue;
              }

              attivi.add(elemento);
            }

            // Ordinamento dal più recente al meno recente:
            // prima per giorno di ritiro (crescente, da oggi in avanti),
            // poi per orario di ritiro, infine per id.
            int confronta(OrdineCompleto a, OrdineCompleto b) {
              final perGiorno = a.ordine.giornoRitiro.compareTo(
                b.ordine.giornoRitiro,
              );
              if (perGiorno != 0) return perGiorno;

              final perOrario = a.ordine.orarioRitiro.compareTo(
                b.ordine.orarioRitiro,
              );
              if (perOrario != 0) return perOrario;

              return a.ordine.id.compareTo(b.ordine.id);
            }

            attivi.sort(confronta);
            ritiratiOggi.sort(confronta);

            if (attivi.isEmpty && ritiratiOggi.isEmpty) {
              return const Center(
                child: Text(
                  'Non hai ordini in programma.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final elemento in attivi) ...[
                        _voceConElimina(elemento),
                        const SizedBox(height: 8),
                      ],

                      if (ritiratiOggi.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Ordini ritirati',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        for (final elemento in ritiratiOggi) ...[
                          _voceConElimina(elemento, ritirato: true),
                          const SizedBox(height: 8),
                        ],
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

  Widget _voceConElimina(OrdineCompleto elemento, {bool ritirato = false}) {
    final permesso = !ritirato && _puoEliminare(elemento.ordine);

    final pulsanteElimina = Tooltip(
      message: permesso
          ? 'Elimina ordine'
          : 'Eliminabile solo fino a un\'ora prima del ritiro',
      child: SizedBox(
        width: 44,
        height: 44,
        child: ElevatedButton(
          onPressed: permesso ? () => _confermaEliminazione(elemento) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade500,
            disabledForegroundColor: Colors.white70,
            padding: EdgeInsets.zero,
            elevation: permesso ? 2 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Icon(Icons.close, size: 24),
        ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool suDueRighe = constraints.maxWidth < 550;

        if (suDueRighe) {
          return _rigaOrdine(
            elemento,
            ritirato: ritirato,
            suDueRighe: true,
            pulsanteElimina: pulsanteElimina,
          );
        }

        return Row(
          children: [
            Expanded(child: _rigaOrdine(elemento, ritirato: ritirato)),

            const SizedBox(width: 8),

            pulsanteElimina,
          ],
        );
      },
    );
  }

  // =========================================================
  // CONFERMA ELIMINAZIONE ORDINE
  // =========================================================

  Future<void> _confermaEliminazione(OrdineCompleto elemento) async {
    final ordine = elemento.ordine;

    // Ulteriore controllo di sicurezza: la regola dell'ora
    // vale anche se la schermata non è stata aggiornata.
    if (!_puoEliminare(ordine)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ordine eliminabile solo fino a un\'ora prima del ritiro.',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final confermato = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminare l\'ordine?'),
        content: Text('Sei sicuro di voler eliminare l\'ordine?\n'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );

    if (confermato != true || !mounted) {
      return;
    }

    try {
      // L'ordine non sparisce dal database: passa allo stato
      // 'Eliminato' e nella gestione mensa risulta bloccato.
      await widget.database.aggiornaStatoOrdine(ordine.id, 'Eliminato');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore durante l\'eliminazione: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ordine eliminato.'),
        backgroundColor: Colors.green,
      ),
    );

    _ricaricaOrdini();
  }

  // =========================================================
  // RIGA ORDINE: orario + data ritiro, mensa, stato, dettaglio
  //
  // Con [ritirato] = true la riga viene mostrata in grigio e
  // bloccata (nessuna azione disponibile).
  // =========================================================

  Widget _rigaOrdine(
    OrdineCompleto elemento, {
    bool ritirato = false,
    bool suDueRighe = false,
    Widget? pulsanteElimina,
  }) {
    final ordine = elemento.ordine;
    final nomeMensa = elemento.mensa?.nomeMensa ?? 'Mensa';

    // Stili della riga: normale oppure grigia e bloccata.
    final coloreSfondo = ritirato ? Colors.grey.shade300 : Colors.grey.shade100;
    final bordo = ritirato ? Colors.grey.shade400 : Colors.grey.shade300;
    final coloreTesto = ritirato ? Colors.grey.shade600 : Colors.black87;
    final coloreData = ritirato ? Colors.grey.shade500 : Colors.grey.shade700;

    // ===============================================
    // STATO (CHIP) - usato sia su una che su due righe
    // ===============================================
    final chipStato = Chip(
      label: Text(
        ordine.stato,
        style: const TextStyle(fontSize: 11, color: Colors.white),
      ),
      backgroundColor: ritirato
          ? Colors.blueGrey
          : ordine.stato == 'Ricevuto'
          ? Colors.green
          : ordine.stato == 'Rifiutato'
          ? Colors.red
          : Colors.orange,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final pulsanteOrdine = ElevatedButton.icon(
      onPressed: ritirato ? null : () => _mostraDettaglioOrdine(elemento),
      icon: Icon(ritirato ? Icons.lock : Icons.visibility, size: 18),
      label: const Text('Ordine'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF913535),
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey.shade500,
        disabledForegroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        visualDensity: VisualDensity.compact,
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: coloreSfondo,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: bordo),
      ),

      // Su schermi stretti l'ordine va su due righe:
      // - sopra: orario, data e nome della mensa;
      // - sotto: stato e pulsanti.
      child: suDueRighe
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // =============================================
                // PRIMA RIGA: ORARIO, DATA E NOME MENSA
                // =============================================
                Row(
                  children: [
                    Text(
                      ordine.orarioRitiro,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: coloreTesto,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Flexible(
                      child: Text(
                        _testoData(ordine.giornoRitiro),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: coloreData),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        nomeMensa,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15, color: coloreTesto),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // =============================================
                // SECONDA RIGA: STATO E PULSANTI
                // =============================================
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [chipStato, pulsanteOrdine, ?pulsanteElimina],
                ),
              ],
            )
          : Row(
              children: [
                // ORARIO DI RITIRO + DATA (la data è di fianco all'orario)
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ordine.orarioRitiro,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: coloreTesto,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          _testoData(ordine.giornoRitiro),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: coloreData),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // NOME MENSA
                Expanded(
                  child: Text(
                    nomeMensa,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: coloreTesto),
                  ),
                ),

                const SizedBox(width: 8),

                // STATO
                chipStato,

                const SizedBox(width: 8),

                // PULSANTE VISUALIZZA ORDINE
                pulsanteOrdine,
              ],
            ),
    );
  }
  // =========================================================
  // FINESTRA DETTAGLIO ORDINE CON NOTE
  // =========================================================

  Future<void> _mostraDettaglioOrdine(OrdineCompleto elemento) async {
    final ordine = elemento.ordine;
    final nomeMensa = elemento.mensa?.nomeMensa ?? 'Mensa';

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Ordine n. ${ordine.id}'),
        content: SizedBox(
          width: 440,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mensa: $nomeMensa',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
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
}
