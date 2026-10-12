import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project/database/database.dart';

class SelectMenu extends StatefulWidget {
  final AppDatabase database;
  final int mensaId;

  const SelectMenu({super.key, required this.database, required this.mensaId});

  @override
  State<SelectMenu> createState() => _SelectMenuState();
}

class _SelectMenuState extends State<SelectMenu> {
  static const Color primaryRed = Color.fromARGB(255, 203, 17, 4);

  static const LinearGradient gradientSfondo = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  static const List<String> categoriePasti = [
    'PRIMI',
    'SECONDI',
    'CONTORNI',
    'DOLCI',
    'BEVANDE',
    'BAR',
  ];

  // =========================================================
  // MENU SELEZIONATO
  // =========================================================

  final Map<String, List<PastiData>> menuSelezionato = {};

  // Quantità disponibile impostata per ogni piatto del menù di oggi
  // (pastoId -> quantità; null = non ancora impostata, dati vecchi).
  final Map<int, int?> quantitaSelezionate = {};

  // =========================================================
  // INIT STATE
  // =========================================================

  @override
  void initState() {
    super.initState();

    _caricaMenuDiOggi();
  }

  // =========================================================
  // CARICA MENU DI OGGI DAL DATABASE
  // =========================================================

  Future<void> _caricaMenuDiOggi() async {
    try {
      final nuovoMenu = <String, List<PastiData>>{};

      for (final categoria in categoriePasti) {
        final piatti = await widget.database.getMenuCategoriaOggi(
          mensaId: widget.mensaId,
          categoria: categoria,
        );

        nuovoMenu[categoria] = piatti;
      }

      final quantita = await widget.database.getQuantitaMenuDiOggi(
        widget.mensaId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        menuSelezionato.clear();
        menuSelezionato.addAll(nuovoMenu);

        quantitaSelezionate
          ..clear()
          ..addAll(quantita);
      });
    } catch (e) {
      debugPrint('Errore caricamento menu di oggi: $e');
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: gradientSfondo),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // =====================================================
        // APP BAR
        // =====================================================
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

        // =====================================================
        // BODY
        // =====================================================
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [
                const SizedBox(height: 10),

                // FittedBox fa ridurre il titolo se non sta nella
                // larghezza dello schermo.
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Seleziona il menù di oggi',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8),

                    // =================================================
                    // UNA SOLA COLONNA DI CARD
                    // =================================================
                    // Le card occupano tutta la larghezza disponibile
                    // e vengono messe una sotto l'altra.
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final categoria in categoriePasti) ...[
                          _buildCategoriaCard(context, categoria),

                          const SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // CARD CATEGORIA
  // =========================================================

  Widget _buildCategoriaCard(BuildContext context, String categoria) {
    final piatti = menuSelezionato[categoria] ?? [];

    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // =================================================
          // TITOLO
          // =================================================

          SizedBox(
            height: 35,

            child: Stack(
              alignment: Alignment.center,

              children: [
                Align(
                  alignment: Alignment.centerLeft,

                  child: Icon(
                    piatti.isEmpty
                        ? Icons.error_outline
                        : Icons.check_circle_outline,
                    color: piatti.isEmpty ? primaryRed : Colors.green,
                    size: 25,
                  ),
                ),

                Text(
                  categoria,
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // =================================================
          // PIATTI SELEZIONATI
          // =================================================
          if (piatti.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),

              child: Text(
                'Nessun piatto\nselezionato',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.black.withOpacity(0.35),
                  fontSize: 13,
                ),
              ),
            )
          else
            Column(children: piatti.map(_buildRigaPasto).toList()),

          const SizedBox(height: 5),

          // =================================================
          // PULSANTE +
          // =================================================
          IconButton(
            onPressed: () {
              _apriSelezionePiatti(context, categoria);
            },

            icon: Icon(
              Icons.add_circle_outline,
              size: 38,
              color: Colors.black.withOpacity(0.45),
            ),
          ),

          Text(
            piatti.isEmpty ? 'Seleziona piatti' : 'Modifica',

            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.35),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // RIGA PASTO (NOME + PREZZO)
  // =========================================================

  static const TextStyle _stileNome = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle _stilePrezzo = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: primaryRed,
  );

  static const TextStyle _stileQuantita = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );

  /// true se [testo] sta in una sola riga entro [larghezzaMax]
  /// con lo [stile] indicato.
  bool _staInUnaRiga({
    required String testo,
    required TextStyle stile,
    required double larghezzaMax,
  }) {
    if (larghezzaMax <= 0) {
      return false;
    }

    final painter = TextPainter(
      text: TextSpan(text: testo, style: stile),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: larghezzaMax);

    return !painter.didExceedMaxLines;
  }

  /// Card di un singolo piatto.
  ///
  /// Se il nome sta completo in una riga accanto al prezzo, i due restano
  /// affiancati; altrimenti il nome occupa tutta la larghezza della card
  /// (scritto per intero) e il prezzo passa sotto, separato dal pasto
  /// successivo da una linea.
  Widget _buildRigaPasto(PastiData pasto) {
    final testoPrezzo = '${pasto.prezzo.toStringAsFixed(2)} €';

    // Disponibilità residua, se la quantità è gestita dalla mensa.
    final quantita = quantitaSelezionate[pasto.id];
    final testoQuantita = quantita == null ? null : 'Disp. $quantita';

    return LayoutBuilder(
      builder: (context, constraints) {
        // constraints.maxWidth è la larghezza interna della card
        // (padding già escluso).

        final prezzoPainter = TextPainter(
          text: TextSpan(text: testoPrezzo, style: _stilePrezzo),
          textDirection: TextDirection.ltr,
        )..layout();

        final quantitaPainter = testoQuantita == null
            ? null
            : (TextPainter(
                text: TextSpan(text: testoQuantita, style: _stileQuantita),
                textDirection: TextDirection.ltr,
              )..layout());

        final larghezzaDestra =
            prezzoPainter.width +
            (quantitaPainter == null ? 0 : quantitaPainter.width + 6);

        final larghezzaNome = constraints.maxWidth - 6 - larghezzaDestra;

        final nomeAffiancato = _staInUnaRiga(
          testo: pasto.nome,
          stile: _stileNome,
          larghezzaMax: larghezzaNome,
        );

        return Container(
          width: double.infinity,

          margin: const EdgeInsets.only(bottom: 5),

          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),

          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),

          child: nomeAffiancato
              ? Row(
                  children: [
                    Expanded(
                      child: Text(
                        pasto.nome,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _stileNome,
                      ),
                    ),

                    const SizedBox(width: 6),

                    if (testoQuantita != null) ...[
                      Text(testoQuantita, style: _stileQuantita),
                      const SizedBox(width: 6),
                    ],

                    Text(testoPrezzo, style: _stilePrezzo),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pasto.nome, style: _stileNome),

                    const SizedBox(height: 4),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (testoQuantita != null) ...[
                          Text(testoQuantita, style: _stileQuantita),
                          const SizedBox(width: 6),
                        ],
                        Text(testoPrezzo, style: _stilePrezzo),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Linea che divide il prezzo dal pasto successivo.
                    const Divider(height: 1),
                  ],
                ),
        );
      },
    );
  }

  // =========================================================
  // APERTURA DIALOG
  // =========================================================

  Future<void> _apriSelezionePiatti(
    BuildContext context,
    String categoria,
  ) async {
    final selezionatiAttuali = menuSelezionato[categoria] ?? [];

    final risultato = await showDialog<RisultatoSelezionePiatti>(
      context: context,

      builder: (_) {
        return SelezionePiattiDialog(
          database: widget.database,
          mensaId: widget.mensaId,
          categoria: categoria,
          piattiGiaSelezionati: selezionatiAttuali,
          quantitaIniziale: Map<int, int?>.of(quantitaSelezionate),
        );
      },
    );

    if (!mounted || risultato == null) {
      return;
    }

    try {
      // ===================================================
      // SALVA REALMENTE NEL DATABASE
      // ===================================================

      await widget.database.salvaMenuCategoriaOggi(
        mensaId: widget.mensaId,
        categoria: categoria,
        pastiSelezionati: risultato.piatti.map((pasto) => pasto.id).toList(),
        quantita: risultato.quantita,
      );

      // ===================================================
      // AGGIORNA LA UI
      // ===================================================

      if (!mounted) {
        return;
      }

      setState(() {
        final precedenti = menuSelezionato[categoria] ?? [];
        menuSelezionato[categoria] = risultato.piatti;

        // Le quantità dei piatti deselezionati non servono più.
        for (final pasto in precedenti) {
          final ancoraPresente = risultato.piatti.any(
            (altro) => altro.id == pasto.id,
          );

          if (!ancoraPresente) {
            quantitaSelezionate.remove(pasto.id);
          }
        }

        quantitaSelezionate.addAll(risultato.quantita);
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore nel salvataggio del menu:\n$e'),
          backgroundColor: Colors.red,
        ),
      );

      debugPrint('Errore salvataggio menu: $e');
    }
  }
}

// =============================================================
// DIALOG SELEZIONE PIATTI
// =============================================================

class SelezionePiattiDialog extends StatefulWidget {
  final AppDatabase database;
  final int mensaId;
  final String categoria;
  final List<PastiData> piattiGiaSelezionati;

  // Quantità già impostate dalla mensa (pastoId -> quantità;
  // null = non ancora impostata, dati vecchi).
  final Map<int, int?> quantitaIniziale;

  const SelezionePiattiDialog({
    super.key,
    required this.database,
    required this.mensaId,
    required this.categoria,
    required this.piattiGiaSelezionati,
    required this.quantitaIniziale,
  });

  @override
  State<SelezionePiattiDialog> createState() => _SelezionePiattiDialogState();
}

class _SelezionePiattiDialogState extends State<SelezionePiattiDialog> {
  late Future<List<PastiData>> _pastiFuture;

  final Set<int> _selezionati = {};

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    // Mantiene le selezioni già presenti.
    _selezionati.addAll(widget.piattiGiaSelezionati.map((pasto) => pasto.id));

    // Recupera i piatti disponibili
    // per la P.IVA della mensa.
    _pastiFuture = widget.database.getPastiPerCategoria(
      widget.mensaId,
      widget.categoria,
    );
  }

  // Controller per il campo "Disponibilità" di ogni piatto elencato.
  final Map<int, TextEditingController> _controllerQuantita = {};

  /// Controller del piatto [pastoId], precaricato con la quantità
  /// già salvata (testo vuoto = non ancora impostata).
  TextEditingController _controllerPer(int pastoId) {
    return _controllerQuantita.putIfAbsent(pastoId, () {
      final quantita = widget.quantitaIniziale[pastoId];
      return TextEditingController(text: quantita?.toString() ?? '');
    });
  }

  @override
  void dispose() {
    for (final controller in _controllerQuantita.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final width = size.width > 600 ? 550.0 : size.width * 0.90;

    final height = size.height > 700 ? 500.0 : size.height * 0.70;

    return Dialog(
      backgroundColor: Colors.white,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: SizedBox(
        width: width,
        height: height,

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              // =================================================
              // HEADER
              // =================================================

              Row(
                children: [
                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'Seleziona ${widget.categoria.toLowerCase()}',
                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const Divider(),

              // =================================================
              // LISTA PIATTI
              // =================================================
              Expanded(
                child: FutureBuilder<List<PastiData>>(
                  future: _pastiFuture,

                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),

                          child: Text(
                            'Errore nel caricamento dei piatti:\n\n'
                            '${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }

                    final pasti = snapshot.data ?? [];

                    if (pasti.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            const SizedBox(height: 15),

                            Text(
                              'Nessun piatto trovato\n'
                              'nella categoria ${widget.categoria}.',

                              textAlign: TextAlign.center,

                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: pasti.length,

                      separatorBuilder: (_, __) {
                        return const Divider(height: 1);
                      },

                      itemBuilder: (context, index) {
                        final pasto = pasti[index];

                        final selezionato = _selezionati.contains(pasto.id);

                        return CheckboxListTile(
                          value: selezionato,

                          title: Text(
                            pasto.nome,

                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),

                          subtitle: Row(
                            children: [
                              Text('${pasto.prezzo.toStringAsFixed(2)} €'),
                              const Spacer(),
                              SizedBox(
                                width: 135,
                                child: TextFormField(
                                  controller: _controllerPer(pasto.id),
                                  enabled: selezionato,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontSize: 13),
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    labelText: 'Disponibilità',
                                    hintText: 'Es. 20',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selezionati.add(pasto.id);
                              } else {
                                _selezionati.remove(pasto.id);
                              }
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // =================================================
              // BOTTONI
              // =================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      'Annulla',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final pasti = await _pastiFuture;

                        final selezionati = pasti.where((pasto) {
                          return _selezionati.contains(pasto.id);
                        }).toList();

                        // =================================================
                        // VALIDAZIONE DELLE QUANTITÀ INSERITE
                        // =================================================

                        // La disponibilità è obbligatoria per ogni
                        // piatto selezionato nel menù.
                        final quantita = <int, int>{};

                        for (final pasto in selezionati) {
                          final testo = _controllerPer(
                            pasto.id,
                          ).text.trim();

                          final valore = int.tryParse(testo);

                          if (testo.isEmpty) {
                            if (!context.mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Imposta la disponibilità di '
                                  '"${pasto.nome}": è obbligatoria.',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (valore == null || valore < 1) {
                            if (!context.mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Disponibilità non valida per '
                                  '"${pasto.nome}": usa un numero '
                                  'maggiore di 0.',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          quantita[pasto.id] = valore;
                        }

                        if (!context.mounted) {
                          return;
                        }
                        Navigator.pop(
                          context,
                          RisultatoSelezionePiatti(
                            piatti: selezionati,
                            quantita: quantita,
                          ),
                        );
                      } catch (e) {
                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Errore: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Salva'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 203, 17, 4),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================
// RISULTATO DIALOG SELEZIONE PIATTI
// =============================================================

/// Esito della selezione piatti: i piatti scelti per la categoria e la
/// quantità disponibile obbligatoria impostata per ciascuno (>= 1).
class RisultatoSelezionePiatti {
  const RisultatoSelezionePiatti({
    required this.piatti,
    required this.quantita,
  });

  final List<PastiData> piatti;
  final Map<int, int> quantita;
}

