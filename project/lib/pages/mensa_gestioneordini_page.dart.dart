import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';

class GestioneOrdiniMensa extends StatefulWidget {
  const GestioneOrdiniMensa({
    super.key,
    required this.database,
    required this.mensaId,
  });

  final AppDatabase database;
  final int mensaId;

  @override
  State<GestioneOrdiniMensa> createState() => _GestioneOrdiniMensaState();
}

class _GestioneOrdiniMensaState extends State<GestioneOrdiniMensa> {
  static const LinearGradient gradientSfondo = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  static const List<String> _giorniSettimana = [
    'Lunedì',
    'Martedì',
    'Mercoledì',
    'Giovedì',
    'Venerdì',
    'Sabato',
    'Domenica',
  ];

  late Future<List<OrdineCompleto>> _ordini;

  // Stato di apertura della tendina "Ordini ritirati" di oggi.
  bool _ritiratiOggiAperti = false;

  @override
  void initState() {
    super.initState();
    _ordini = widget.database.getOrdiniMensa(widget.mensaId);
  }

  /// Ricarica l'elenco (dopo accettazione/rifiuto).
  void _ricaricaOrdini() {
    if (!mounted) return;
    setState(() {
      _ordini = widget.database.getOrdiniMensa(widget.mensaId);
    });
  }

  String _testoGiorno(DateTime giorno) =>
      '${_giorniSettimana[giorno.weekday - 1]} '
      '${giorno.day.toString().padLeft(2, '0')}/'
      '${giorno.month.toString().padLeft(2, '0')}/'
      '${giorno.year}';

  /// Verifica che due date si riferiscano alla stessa giornata.
  bool _stessoGiorno(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _nomeCliente(OrdineCompleto elemento) {
    final utente = elemento.utente;
    if (utente == null) return 'Cliente';
    return '${utente.nome} ${utente.cognome}';
  }

  Future<void> _aggiornaEsito(OrdineCompleto elemento, String stato) async {
    try {
      await widget.database.aggiornaStatoOrdine(elemento.ordine.id, stato);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore aggiornamento ordine: $e')),
      );
      return;
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(_messaggioStato(stato))));
    _ricaricaOrdini();
  }

  /// Messaggio mostrato dopo il cambio di stato.
  String _messaggioStato(String stato) {
    switch (stato) {
      case 'Ricevuto':
        return 'Ordine ricevuto.';
      case 'Rifiutato':
        return 'Ordine rifiutato.';
      case 'In preparazione':
        return 'Ordine in preparazione.';
      case 'Pronto':
        return 'Ordine pronto.';
      case 'Ritirato':
        return 'Ordine segnato come ritirato.';
      default:
        return 'Stato ordine aggiornato.';
    }
  }

  /// Colore del chip in base allo stato.
  Color _coloreStato(String stato) {
    switch (stato) {
      case 'Ricevuto':
        return Colors.green;
      case 'Rifiutato':
        return Colors.red;
      case 'In preparazione':
        return Colors.blue;
      case 'Pronto':
        return Colors.purple;
      case 'Ritirato':
        return Colors.blueGrey;
      default:
        return Colors.orange;
    }
  }

  /// Stati per cui in riga compaiono il menu stato e "Segna come Ritirato".
  bool _statoGestibile(String stato) =>
      stato == 'Ricevuto' || stato == 'In preparazione' || stato == 'Pronto';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: gradientSfondo),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          title: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              Image.asset(
                'lib/assets/images/logo_app.png',
                height: 28,
                width: 28,
              ),

              const SizedBox(width: 10),

              Text(
                'MensApp',
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          centerTitle: true,
        ),

        // =========================================================
        // BODY
        // =========================================================
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),

            child: Container(
              width: double.infinity,
              height: double.infinity,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(25),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              // =====================================================
              // ELENCO ORDINI RAGGRUPPATI PER GIORNO DI RITIRO
              // =====================================================
              child: FutureBuilder<List<OrdineCompleto>>(
                future: _ordini,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Impossibile caricare gli ordini.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  // =====================================================
                  // SOLO OGGI E ORDINI FUTURI
                  //
                  // Gli ordini con giorno di ritiro passato non vengono
                  // mostrati. La query è già in ordine crescente per
                  // giorno (e, al suo interno, per orario di ritiro),
                  // quindi oggi viene visualizzato per primo e,
                  // scorrendo verso il basso, i giorni futuri.
                  //
                  // Gli ordini di oggi già segnati come ritirati non
                  // vengono mostrati nell'elenco principale: passano
                  // nella tendina "Ordini ritirati" in fondo alla
                  // sezione di oggi.
                  // =====================================================
                  final oggi = DateTime.now();
                  final inizioOggi = DateTime(oggi.year, oggi.month, oggi.day);

                  final ordini = <OrdineCompleto>[];
                  final ritiratiOggi = <OrdineCompleto>[];

                  for (final elemento in snapshot.data ?? []) {
                    final giorno = elemento.ordine.giornoRitiro;

                    // Giorni passati: non visualizzati.
                    if (giorno.isBefore(inizioOggi)) {
                      continue;
                    }

                    // Ritirati di oggi: solo nella tendina in fondo.
                    if (_stessoGiorno(giorno, inizioOggi) &&
                        elemento.ordine.stato == 'Ritirato') {
                      ritiratiOggi.add(elemento);
                      continue;
                    }

                    ordini.add(elemento);
                  }

                  if (ordini.isEmpty && ritiratiOggi.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Nessun ordine in programma.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }

                  // Giorni di ritiro nell'ordine già impostato dalla query
                  // (crescente): si raggruppa preservando quell'ordine.
                  final giorni = <DateTime>[];
                  final perGiorno = <String, List<OrdineCompleto>>{};

                  for (final elemento in ordini) {
                    final chiave = _testoGiorno(elemento.ordine.giornoRitiro);
                    if (!perGiorno.containsKey(chiave)) {
                      giorni.add(elemento.ordine.giornoRitiro);
                      perGiorno[chiave] = [];
                    }
                    perGiorno[chiave]!.add(elemento);
                  }

                  // =====================================================
                  // SEZIONE DI OGGI
                  //
                  // Intestazione + ordini ancora da gestire e, in fondo,
                  // la tendina con quelli già ritirati oggi.
                  // =====================================================
                  final sezioni = <Widget>[];
                  final ordiniOggi = perGiorno[_testoGiorno(inizioOggi)] ?? [];

                  if (ordiniOggi.isNotEmpty || ritiratiOggi.isNotEmpty) {
                    sezioni.add(_intestazioneGiorno(inizioOggi));
                    sezioni.add(const SizedBox(height: 8));

                    for (final elemento in ordiniOggi) {
                      sezioni.add(_rigaOrdine(elemento));
                    }

                    // ===================================================
                    // TENDINA "ORDINI RITIRATI" (in fondo a oggi)
                    // ===================================================
                    if (ritiratiOggi.isNotEmpty) {
                      sezioni.add(const SizedBox(height: 8));
                      sezioni.add(_tendinaOrdiniRitirati(ritiratiOggi));
                    }

                    sezioni.add(const SizedBox(height: 16));

                    // La sezione di oggi è già stata aggiunta.
                    giorni.removeWhere(
                      (giorno) => _stessoGiorno(giorno, inizioOggi),
                    );
                  }

                  // =====================================================
                  // GIORNI FUTURI (scorrendo verso il basso)
                  // =====================================================
                  for (final giorno in giorni) {
                    sezioni.add(_intestazioneGiorno(giorno));
                    sezioni.add(const SizedBox(height: 8));

                    for (final elemento in perGiorno[_testoGiorno(giorno)]!) {
                      sezioni.add(_rigaOrdine(elemento));
                    }

                    sezioni.add(const SizedBox(height: 16));
                  }

                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: sezioni,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // INTESTAZIONE GIORNO DI RITIRO
  // =========================================================

  Widget _intestazioneGiorno(DateTime giorno) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 145, 53, 53),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        _testoGiorno(giorno),
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // =========================================================
  // TENDINA "ORDINI RITIRATI" (in fondo alla giornata di oggi)
  // =========================================================

  /// Barra cliccabile "Ordini ritirati": aprendola mostra
  /// l'elenco degli ordini di oggi già segnati come ritirati,
  /// dal primo all'ultimo (l'ordine della query, per orario di ritiro).
  Widget _tendinaOrdiniRitirati(List<OrdineCompleto> ritirati) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // =======================================================
        // BARRA CLICCABILE
        // =======================================================
        Material(
          color: Colors.blueGrey.shade700,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                _ritiratiOggiAperti = !_ritiratiOggiAperti;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Ordini ritirati',
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${ritirati.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _ritiratiOggiAperti
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),

        // =======================================================
        // CONTENUTO PIEGHEVOLE
        // =======================================================
        if (_ritiratiOggiAperti) ...[
          const SizedBox(height: 8),
          for (final elemento in ritirati) _rigaOrdine(elemento),
        ],
      ],
    );
  }

  // =========================================================
  // RIGA ORDINE: orario ritiro, cliente, pulsante dettaglio
  // =========================================================

  Widget _rigaOrdine(OrdineCompleto elemento) {
    final ordine = elemento.ordine;
    final gestibile = _statoGestibile(ordine.stato);

    // ===============================================
    // PULSANTE "VISUALIZZA ORDINE" (usato in entrambi i layout)
    // ===============================================
    final Widget bottoneVisualizza = ElevatedButton(
      onPressed: () => _mostraDettaglioOrdine(elemento),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 203, 17, 4),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        visualDensity: VisualDensity.compact,
      ),
      child: const Text('Visualizza ordine'),
    );

    // ===============================================
    // PULSANTE "SEGNA COME RITIRATO" (usato in entrambi i layout)
    // ===============================================
    final Widget? bottoneRitiro = gestibile
        ? OutlinedButton(
            onPressed: () => _confermaRitiro(elemento),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blueGrey,
              side: const BorderSide(color: Colors.blueGrey),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              visualDensity: VisualDensity.compact,
            ),
            child: const Text(
              'Segna come Ritirato',
              style: TextStyle(fontSize: 13),
            ),
          )
        : null;

    // ===============================================
    // RIGA ALTO (comune ai due layout): ORARIO,
    // NOME CLIENTE E "VISUALIZZA ORDINE"
    // ===============================================
    final Widget rigaInfo = Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            ordine.orarioRitiro,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  _nomeCliente(elemento),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(width: 8),
              bottoneVisualizza,
            ],
          ),
        ),
      ],
    );

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
          // - sopra: orario, nome cliente e "Visualizza ordine";
          // - sotto: "Accetta"/"Rifiuta" oppure stato e
          //   "Segna come Ritirato".
          // =============================================
          if (constraints.maxWidth < 560) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                rigaInfo,

                const SizedBox(height: 10),

                // RIGA SOTTO: AZIONI
                if (ordine.stato == 'Eliminato')
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "L'utente ha eliminato l'ordine",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => _confermaCancellazione(elemento),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text(
                          'cancella',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                else if (ordine.stato == 'In attesa')
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _aggiornaEsito(elemento, 'Ricevuto'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text('Accetta'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () => _confermaRifiuto(elemento),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text('Rifiuta'),
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_pulsanteStato(elemento), ?bottoneRitiro],
                  ),
              ],
            );
          }

          // =============================================
          // SCHERMO LARGO: TUTTO SU UNA SOLA RIGA
          // =============================================
          return Row(
            children: [
              // ORARIO DI RITIRO
              SizedBox(
                width: 60,
                child: Text(
                  ordine.orarioRitiro,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // NOME CLIENTE + PULSANTE VISUALIZZA ORDINE
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        _nomeCliente(elemento),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    const SizedBox(width: 8),
                    bottoneVisualizza,
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // COLONNA CENTRALE: ACCETTA/RIFIUTA, STATO,
              // OPPURE MESSAGGIO DI ELIMINAZIONE DALL'UTENTE
              if (ordine.stato == 'Eliminato')
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          "L'utente ha eliminato l'ordine",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => _confermaCancellazione(elemento),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text(
                          'cancella',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              else if (ordine.stato == 'In attesa')
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () => _aggiornaEsito(elemento, 'Ricevuto'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const Text('Accetta'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () => _confermaRifiuto(elemento),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const Text('Rifiuta'),
                    ),
                  ],
                )
              else
                _pulsanteStato(elemento),

              const SizedBox(width: 8),

              // ZONA DESTRA: SEGNA COME RITIRATO (TOTALMENTE A DESTRA)
              // Per gli ordini eliminati dall'utente la zona non serve:
              // il solo comando è il "cancella" affiancato al messaggio.
              if (ordine.stato != 'Eliminato')
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [?bottoneRitiro],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // =========================================================
  // PULSANTE STATO CON FRECCIA E MENU A TENDINA
  // =========================================================

  /// Nella colonna centrale mostra lo stato corrente dell'ordine;
  /// se lo stato è ancora modificabile, la freccia apre il menù
  /// per scegliere 'In preparazione' o 'Pronto'.
  Widget _pulsanteStato(OrdineCompleto elemento) {
    final ordine = elemento.ordine;
    final modificabile = _statoGestibile(ordine.stato);

    if (!modificabile) {
      // Stato finale (es. Ritirato): mostre solo etichetta, senza freccia.
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: _coloreStato(ordine.stato),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          ordine.stato,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return PopupMenuButton<String>(
      tooltip: 'Imposta stato',
      onSelected: (nuovoStato) => _aggiornaEsito(elemento, nuovoStato),
      itemBuilder: (dialogContext) => const [
        PopupMenuItem(value: 'In preparazione', child: Text('In preparazione')),
        PopupMenuItem(value: 'Pronto', child: Text('Pronto')),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: _coloreStato(ordine.stato),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ordine.stato,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white, size: 22),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // CONFERME PRIMA DI AZIONI IRREVERSIBILI
  // =========================================================

  Future<void> _confermaAzione({
    required String titolo,
    required String messaggio,
    required String testoConferma,
    required Color colore,
    required VoidCallback onConferma,
  }) async {
    final confermato = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(titolo),
        content: Text(messaggio),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: colore,
              foregroundColor: Colors.white,
            ),
            child: Text(testoConferma),
          ),
        ],
      ),
    );

    if (confermato == true && mounted) {
      onConferma();
    }
  }

  /// Chiede conferma prima di segnare l'ordine come ritirato.
  void _confermaRitiro(OrdineCompleto elemento) {
    _confermaAzione(
      titolo: 'Segnare come ritirato?',
      messaggio:
          "Confermi che l'ordine "
          'è stato ritirato dal cliente? Non potrà più essere modificato.',
      testoConferma: 'Segna come Ritirato',
      colore: Colors.blueGrey,
      onConferma: () => _aggiornaEsito(elemento, 'Ritirato'),
    );
  }

  /// Chiede conferma prima di annullare (rifiutare) un ordine.
  void _confermaRifiuto(OrdineCompleto elemento) {
    _confermaAzione(
      titolo: "Annullare l'ordine?",
      messaggio:
          "L'ordine n. ${elemento.ordine.id} verrà annullato "
          'e il cliente vedrà lo stato "Rifiutato". Vuoi procedere?',
      testoConferma: "Sì, annulla ordine",
      colore: Colors.red,
      onConferma: () => _aggiornaEsito(elemento, 'Rifiutato'),
    );
  }

  // =========================================================
  // CANCELLAZIONE DEFINITIVA DI UN ORDINE ELIMINATO DALL'UTENTE
  // =========================================================

  /// Chiede conferma prima di cancellare definitivamente
  /// un ordine che l'utente ha eliminato dalla sua lista.
  void _confermaCancellazione(OrdineCompleto elemento) {
    _confermaAzione(
      titolo: 'Cancellare l\'ordine?',
      messaggio:
          "L'ordine verrà cancellato "
          'definitivamente dal sistema. Vuoi procedere?',
      testoConferma: 'Cancella',
      colore: Colors.red,
      onConferma: () => _cancellaOrdine(elemento),
    );
  }

  /// Elimina l'ordine (e i suoi piatti) dal database
  /// e ricarica l'elenco.
  Future<void> _cancellaOrdine(OrdineCompleto elemento) async {
    try {
      await widget.database.eliminaOrdine(elemento.ordine.id);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante la cancellazione: $e')),
      );
      return;
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ordine cancellato definitivamente.')),
    );
    _ricaricaOrdini();
  }

  // =========================================================
  // FINESTRA DETTAGLIO ORDINE CON NOTE E ESITO
  // =========================================================

  Future<void> _mostraDettaglioOrdine(OrdineCompleto elemento) async {
    final ordine = elemento.ordine;

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
                  'Cliente: ${_nomeCliente(elemento)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  'Ritiro: ${_testoGiorno(ordine.giornoRitiro)} '
                  'alle ${ordine.orarioRitiro}',
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
