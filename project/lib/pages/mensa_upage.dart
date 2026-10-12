import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';
import 'package:project/pages/order.dart';
import 'package:project/widgets/immagine_salvata.dart';

class MensaUpage extends StatefulWidget {
  const MensaUpage({
    super.key,
    required this.mensa,
    required this.database,
    required this.utenteId,
    required this.isFavorite,
    required this.canToggleFavorite,
    required this.onToggleFavorite,
  });

  final MenseData mensa;
  final AppDatabase database;
  final int utenteId;
  final bool isFavorite;
  final bool canToggleFavorite;
  final Future<bool> Function() onToggleFavorite;

  @override
  State<MensaUpage> createState() => _MensaUpageState();
}

class _MensaUpageState extends State<MensaUpage> {
  static const List<String> _categorieMenu = [
    'PRIMI',
    'SECONDI',
    'CONTORNI',
    'DOLCI',
    'BEVANDE',
    'BAR',
  ];

  late bool _isFavorite;
  bool _isUpdatingFavorite = false;
  bool _menuEspanso = false;
  Future<List<_PastoMenuCliente>>? _menuOggi;

  /// Orari di apertura della mensa, mostrati (allineati a destra)
  /// all'interno della card in alto.
  late final Future<List<OrariAperturaData>> _orariApertura;

  static const List<String> _giorniSettimana = [
    'Lunedì',
    'Martedì',
    'Mercoledì',
    'Giovedì',
    'Venerdì',
    'Sabato',
    'Domenica',
  ];

  static const LinearGradient gradientSfondo = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _orariApertura = widget.database.getOrariMensa(widget.mensa.id);
  }

  Future<void> _toggleFavorite() async {
    if (_isUpdatingFavorite) return;

    setState(() {
      _isUpdatingFavorite = true;
    });

    final statoAggiornato = await widget.onToggleFavorite();
    if (!mounted) return;

    setState(() {
      _isFavorite = statoAggiornato;
      _isUpdatingFavorite = false;
    });
  }

  void _visualizzaMenu() {
    setState(() {
      if (!_menuEspanso) {
        _menuOggi ??= _caricaMenuCliente();
      }
      _menuEspanso = !_menuEspanso;
    });
  }

  Future<List<_PastoMenuCliente>> _caricaMenuCliente() async {
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
        final preferenzePasto = await widget.database.getPreferenzePastoIds(
          pasto.id,
        );
        final allergiePasto = await widget.database.getAllergiePastoIds(
          pasto.id,
        );
        final incompatibilePreferenza =
            preferenzeUtente.isNotEmpty &&
            !preferenzeUtente.any(preferenzePasto.contains);
        final bloccatoAllergia = allergieUtente.any(allergiePasto.contains);
        return _PastoMenuCliente(
          pasto: pasto,
          incompatibilePreferenza: incompatibilePreferenza,
          bloccatoAllergia: bloccatoAllergia,
          disponibilita: disponibilita[pasto.id],
        );
      }),
    );
  }

  /// I puntini di allergie/preferenze non sono previsti
  /// per le categorie BEVANDE e BAR.
  bool _mostraIndicatore(String categoria) =>
      categoria != 'BEVANDE' && categoria != 'BAR';

  Widget _buildMenuDelGiorno() {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<_PastoMenuCliente>>(
            future: _menuOggi,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return const Text('Impossibile caricare il menù di oggi.');
              }

              final pasti = snapshot.data ?? [];
              if (pasti.isEmpty) {
                return const Text('Il menù di oggi non è disponibile.');
              }

              final categoriePresenti = _categorieMenu
                  .where(
                    (categoria) => pasti.any(
                      (pasto) => pasto.pasto.categoria == categoria,
                    ),
                  )
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (
                    var indice = 0;
                    indice < categoriePresenti.length;
                    indice++
                  ) ...[
                    if (indice > 0) const Divider(height: 24),
                    Text(
                      categoriePresenti[indice],
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    for (final pasto in pasti.where(
                      (pasto) =>
                          pasto.pasto.categoria == categoriePresenti[indice],
                    ))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            if (_mostraIndicatore(pasto.pasto.categoria) &&
                                pasto.bloccatoAllergia)
                              const Padding(
                                padding: EdgeInsets.only(right: 6),
                                child: Tooltip(
                                  message: 'Il piatto contiene un ingrediente al quale sei allergico',
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 12,
                                  ),
                                ),
                              ),
                            if (_mostraIndicatore(pasto.pasto.categoria) &&
                                pasto.incompatibilePreferenza)
                              const Padding(
                                padding: EdgeInsets.only(right: 6),
                                child: Tooltip(
                                  message: 'Il piatto non è compatibile con le tue preferenze',
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.amber,
                                    size: 12,
                                  ),
                                ),
                              ),
                            if (_mostraIndicatore(pasto.pasto.categoria) &&
                                !pasto.bloccatoAllergia &&
                                !pasto.incompatibilePreferenza)
                              const Padding(
                                padding: EdgeInsets.only(right: 6),
                                child: Tooltip(
                                  message: 'Piatto compatibile con le tue preferenze, e non contiene ingredienti ai quali sei allergico',
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 12,
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(pasto.pasto.nome),
                                  // Disponibilità impostata dalla mensa.
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

                            const SizedBox(width: 12),
                            SizedBox(
                              width: 32,
                              child: IconButton(
                                onPressed: () => _mostraInfoPasto(pasto.pasto),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints.tightFor(
                                  width: 32,
                                  height: 32,
                                ),
                                tooltip: 'Info piatto',
                                icon: const Icon(
                                  Icons.help_outline,
                                  size: 19,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${pasto.pasto.prezzo.toStringAsFixed(2)} €',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _ordinaQui() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => OrderPage(
          database: widget.database,
          mensa: widget.mensa,
          utenteId: widget.utenteId,
        ),
      ),
    );
  }

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

  /// Formatta i minuti dall'inizio della giornata come 'HH:mm'.
  String _formatoOra(int minuti) =>
      '${(minuti ~/ 60).toString().padLeft(2, '0')}:'
      '${(minuti % 60).toString().padLeft(2, '0')}';

  // =========================================================
  // ORARI DI APERTURA (nella card, allineati a destra)
  // =========================================================

  /// Elenco degli orari di apertura della mensa, per giorno.
  /// Tutto il testo è allineato a destra.
  Widget _bloccoOrari() {
    return FutureBuilder<List<OrariAperturaData>>(
      future: _orariApertura,
      builder: (context, snapshot) {
        // ===============================================
        // CARICAMENTO
        // ===============================================
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Caricamento orari…',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          );
        }

        // ===============================================
        // ERRORE O NESSUN DATO
        // ===============================================
        if (snapshot.hasError || !snapshot.hasData) {
          return const Text(
            'Orari non disponibili',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          );
        }

        // ===============================================
        // RAGGRUPPAMENTO PER GIORNO (ordine settimanale)
        // ===============================================
        final perGiorno = <String, List<OrariAperturaData>>{
          for (final giorno in _giorniSettimana) giorno: [],
        };

        for (final orario in snapshot.data!) {
          perGiorno[orario.giorno]?.add(orario);
        }

        final giorniSenzaOrari = perGiorno.values.every(
          (turni) => turni.isEmpty,
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // =============================================
            // TITOLO
            // =============================================
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.schedule, size: 16, color: Color(0xFF913535)),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'Orari di apertura',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // =============================================
            // GIORNO PER GIORNO
            // =============================================
            if (giorniSenzaOrari)
              const Text(
                'Nessun orario disponibile',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              for (final giorno in _giorniSettimana)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    _testoOrarioGiorno(giorno, perGiorno[giorno] ?? const []),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      color: (perGiorno[giorno] ?? const []).isEmpty
                          ? Colors.grey
                          : Colors.black87,
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }

  /// Testo di una riga: 'Lunedì: 12:00-15:00' oppure 'Martedì: chiuso'.
  String _testoOrarioGiorno(String giorno, List<OrariAperturaData> turni) {
    if (turni.isEmpty) {
      return '$giorno: chiuso';
    }

    final intervalli = turni
        .map(
          (turno) =>
              '${_formatoOra(turno.aperturaMinuti)}-${_formatoOra(turno.chiusuraMinuti)}',
        )
        .join(', ');

    return '$giorno: $intervalli';
  }

  Widget _rigaDettaglio(IconData icona, String valore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icona, size: 18, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              valore,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 76, 76),
        foregroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: gradientSfondo),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final imageWidth = constraints.maxWidth < 420
                                ? 88.0
                                : 120.0;

                            // Con abbastanza spazio gli orari stanno
                            // affiancati, allineati a destra; sui schermi
                            // stretti scendono sotto i dettagli,
                            // sempre allineati a destra.
                            final orariAffiancati = constraints.maxWidth >= 640;

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImmagineSalvata(
                                  bytes: widget.mensa.immagine,
                                  width: imageWidth,
                                  height: imageWidth * 1.2,
                                  cerchio: false,
                                  icona: Icons.restaurant,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.mensa.nomeMensa,
                                        style: GoogleFonts.raleway(
                                          color: Colors.black87,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      _rigaDettaglio(
                                        Icons.home_outlined,
                                        widget.mensa.indirizzo,
                                      ),
                                      _rigaDettaglio(
                                        Icons.location_city_outlined,
                                        widget.mensa.comune,
                                      ),
                                      _rigaDettaglio(
                                        Icons.map_outlined,
                                        widget.mensa.citta,
                                      ),
                                      _rigaDettaglio(
                                        Icons.phone_outlined,
                                        widget.mensa.telefono
                                                    ?.trim()
                                                    .isNotEmpty ==
                                                true
                                            ? widget.mensa.telefono!.trim()
                                            : 'Telefono non disponibile',
                                      ),

                                      // ===================================
                                      // ORARI DI APERTURA
                                      // Schermi stretti: sotto i dettagli,
                                      // comunque allineati a destra.
                                      // ===================================
                                      if (!orariAffiancati) ...[
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: _bloccoOrari(),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),

                                // =========================================
                                // ORARI DI APERTURA
                                // Schermi ampi: colonna a destra dentro
                                // il container, tutto allineato a destra.
                                // =========================================
                                if (orariAffiancati) ...[
                                  const SizedBox(width: 24),
                                  _bloccoOrari(),
                                ],
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final actions = Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _visualizzaMenu,
                                icon: Icon(
                                  _menuEspanso
                                      ? Icons.expand_less
                                      : Icons.restaurant_menu,
                                ),
                                label: Text(
                                  _menuEspanso
                                      ? 'Nascondi menù'
                                      : 'Visualizza menù',
                                ),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xFF913535),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _ordinaQui,
                                icon: const Icon(Icons.shopping_bag_outlined),
                                label: const Text('Ordina qui'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF913535),
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );

                        final favoriteButton = OutlinedButton.icon(
                          onPressed:
                              !widget.canToggleFavorite || _isUpdatingFavorite
                              ? null
                              : _toggleFavorite,
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : null,
                          ),
                          label: Text(
                            _isFavorite
                                ? 'Rimuovi dai preferiti'
                                : 'Aggiungi ai preferiti',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              72,
                              69,
                              69,
                            ),
                            foregroundColor: Colors.white,
                          ),
                        );

                        if (constraints.maxWidth < 680) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              actions,
                              const SizedBox(height: 8),
                              favoriteButton,
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(child: actions),
                            const SizedBox(width: 16),
                            favoriteButton,
                          ],
                        );
                      },
                    ),
                    if (_menuEspanso) ...[
                      const SizedBox(height: 8),
                      _buildMenuDelGiorno(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PastoMenuCliente {
  const _PastoMenuCliente({
    required this.pasto,
    required this.incompatibilePreferenza,
    required this.bloccatoAllergia,
    this.disponibilita,
  });

  final PastiData pasto;
  final bool incompatibilePreferenza;
  final bool bloccatoAllergia;

  /// Disponibilità massima impostata dalla mensa per questo piatto
  /// nel menù di oggi (null = senza limite, solo righe vecchie).
  final int? disponibilita;
}
