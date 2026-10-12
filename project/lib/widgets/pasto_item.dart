import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/database/database.dart';
import 'package:project/widgets/immagine_salvata.dart';

// =========================================================
// FORMATTER PREZZO
// =========================================================

class _PrezzoInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final testo = newValue.text;

    // Consente:
    // - numeri
    // - una sola virgola oppure un solo punto
    // - massimo due cifre decimali
    if (!RegExp(r'^[0-9]*[,.]?[0-9]{0,2}$').hasMatch(testo)) {
      return oldValue;
    }

    if (testo.contains(',') && testo.contains('.')) {
      return oldValue;
    }

    return newValue;
  }
}

// =========================================================
// FUNZIONI PREZZO
// =========================================================

double? _parsePrezzo(String testo) {
  final normalizzato = testo.trim().replaceAll(',', '.');

  if (normalizzato.isEmpty) {
    return null;
  }

  return double.tryParse(normalizzato);
}

void _formattaPrezzo(TextEditingController controller) {
  final prezzo = _parsePrezzo(controller.text);

  if (prezzo == null) {
    return;
  }

  controller.text = prezzo.toStringAsFixed(2).replaceAll('.', ',');

  controller.selection = TextSelection.collapsed(
    offset: controller.text.length,
  );
}

// =========================================================
// CHECKBOX GRID RIUTILIZZABILE
// =========================================================

Widget _buildCheckboxGrid<T>({
  required List<T> elementi,
  required Set<int> selezionati,
  required int Function(T elemento) getId,
  required String Function(T elemento) getNome,
  required ValueChanged<int> onToggle,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Su schermi stretti le righe diventano più alte e con più
      // spazio verticale, così si legge per intero il nome
      // dell'allergene (o del tipo di pasto).
      final bool stretto = constraints.maxWidth < 340;

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: stretto ? 8 : 0,
          childAspectRatio: stretto ? 2.8 : 4.5,
        ),
        itemCount: elementi.length,
        itemBuilder: (context, index) {
          final elemento = elementi[index];
          final id = getId(elemento);

          return CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: const VisualDensity(vertical: -3, horizontal: -2),
            title: Text(
              getNome(elemento),
              style: const TextStyle(fontSize: 13),
            ),
            value: selezionati.contains(id),
            onChanged: (selezionato) {
              onToggle(id);
            },
          );
        },
      );
    },
  );
}

// =========================================================
// AGGIUNGI PASTO
// =========================================================

Future<void> mostraDialogAggiungiPasto({
  required BuildContext context,
  required AppDatabase database,
  required int mensaId,
  required String categoria,
}) async {
  final controllerNomePasto = TextEditingController();
  final controllerDescrizione = TextEditingController();
  final controllerPrezzo = TextEditingController();

  final focusNodePrezzo = FocusNode();

  final allergie = await database.getTutteLeAllergie();
  final preferenze = await database.getTutteLePreferenze();

  final allergieSelezionate = <int>{};
  final preferenzeSelezionate = <int>{};

  // Le categorie BEVANDE e BAR non hanno allergeni né tipo di pasto.
  final mostraSezioniAllergiePreferenze =
      categoria != 'BEVANDE' && categoria != 'BAR';

  // Immagine scelta dall'utente (opzionale).
  Uint8List? immagineSelezionata;

  // =====================================================
  // FORMATTAZIONE PREZZO
  // =====================================================

  void aggiornaFormatoPrezzo() {
    _formattaPrezzo(controllerPrezzo);
  }

  focusNodePrezzo.addListener(() {
    if (!focusNodePrezzo.hasFocus) {
      aggiornaFormatoPrezzo();
    }
  });

  if (!context.mounted) {
    controllerNomePasto.dispose();
    controllerDescrizione.dispose();
    controllerPrezzo.dispose();
    focusNodePrezzo.dispose();
    return;
  }

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              'Stai inserendo un nuovo piatto nella categoria:',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),

            content: SizedBox(
              width: 450,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // =====================================================
                    // CATEGORIA
                    // =====================================================

                    Text(
                      categoria,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =====================================================
                    // IMMAGINE
                    // =====================================================
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              final bytes = await scegliImmagine();

                              if (bytes == null) {
                                return;
                              }

                              setState(() => immagineSelezionata = bytes);
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Impossibile selezionare l'immagine: $e",
                                  ),
                                ),
                              );
                            }
                          },
                          child: ImmagineSalvata(
                            bytes: immagineSelezionata,
                            width: 110,
                            height: 110,
                            cerchio: true,
                            icona: Icons.add,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          immagineSelezionata == null
                              ? 'Inserisci immagine (opzionale)'
                              : 'Immagine scelta (tocca per cambiarla)',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // =====================================================
                    // NOME + PREZZO
                    // =====================================================
                    _buildNomePrezzoRow(
                      controllerNome: controllerNomePasto,
                      controllerPrezzo: controllerPrezzo,
                      focusNodePrezzo: focusNodePrezzo,
                    ),

                    const SizedBox(height: 18),

                    // =====================================================
                    // DESCRIZIONE
                    // =====================================================
                    TextField(
                      controller: controllerDescrizione,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Descrizione del piatto',
                        hintText: 'Inserisci una descrizione...',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),

                    if (mostraSezioniAllergiePreferenze) ...[
                      const SizedBox(height: 20),

                      // =====================================================
                      // ALLERGENI
                      // =====================================================
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Indicare eventuali allergeni:',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 8),

                      _buildCheckboxGrid(
                        elementi: allergie,
                        selezionati: allergieSelezionate,
                        getId: (allergia) => allergia.id,
                        getNome: (allergia) => allergia.nome,
                        onToggle: (id) {
                          setState(() {
                            if (allergieSelezionate.contains(id)) {
                              allergieSelezionate.remove(id);
                            } else {
                              allergieSelezionate.add(id);
                            }
                          });
                        },
                      ),

                      const SizedBox(height: 8),

                      // =====================================================
                      // PREFERENZE
                      // =====================================================
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Seleziona tipo di pasto:',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 8),

                      _buildCheckboxGrid(
                        elementi: preferenze,
                        selezionati: preferenzeSelezionate,
                        getId: (preferenza) => preferenza.id,
                        getNome: (preferenza) => preferenza.nome,
                        onToggle: (id) {
                          setState(() {
                            if (preferenzeSelezionate.contains(id)) {
                              preferenzeSelezionate.remove(id);
                            } else {
                              preferenzeSelezionate.add(id);
                            }
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // ===========================================================
            // PULSANTI
            // ===========================================================
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('Annulla'),
              ),

              ElevatedButton(
                onPressed: () async {
                  final nome = controllerNomePasto.text.trim();

                  _formattaPrezzo(controllerPrezzo);

                  final prezzo = _parsePrezzo(controllerPrezzo.text);

                  if (nome.isEmpty || prezzo == null) {
                    return;
                  }

                  final nuovoPastoId = await database.inserisciPasto(
                    mensaId: mensaId,
                    nome: nome,
                    descrizione: controllerDescrizione.text.trim(),
                    categoria: categoria,
                    prezzo: prezzo,
                    allergie: allergieSelezionate.toList(),
                    preferenze: preferenzeSelezionate.toList(),
                    imagePath: null,
                  );

                  // ===============================================
                  // SALVATAGGIO IMMAGINE NEL DATABASE
                  // ===============================================
                  if (immagineSelezionata != null) {
                    await database.salvaImmaginePasto(
                      pastoId: nuovoPastoId,
                      immagine: immagineSelezionata,
                    );
                  }

                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                },
                child: const Text('Salva'),
              ),
            ],
          );
        },
      );
    },
  );

  controllerNomePasto.dispose();
  controllerDescrizione.dispose();
  controllerPrezzo.dispose();
  focusNodePrezzo.dispose();
}

// =========================================================
// NOME + PREZZO
// =========================================================

Widget _buildNomePrezzoRow({
  required TextEditingController controllerNome,
  required TextEditingController controllerPrezzo,
  required FocusNode focusNodePrezzo,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 3,
        child: TextFormField(
          controller: controllerNome,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Nome del piatto',
            border: OutlineInputBorder(),
          ),
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        flex: 1,
        child: TextFormField(
          controller: controllerPrezzo,
          focusNode: focusNodePrezzo,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [_PrezzoInputFormatter()],
          decoration: const InputDecoration(
            labelText: 'Prezzo',
            suffixText: '€',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    ],
  );
}

// =========================================================
// AGGIUNGI PASTO ITEM
// =========================================================

class AggiungiPastoItem extends StatelessWidget {
  final VoidCallback onTap;

  const AggiungiPastoItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.3),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 2,
              ),
            ),
            child: const Center(
              child: Icon(Icons.add, color: Colors.white, size: 40),
            ),
          ),

          const SizedBox(height: 8),

          // Il testo usa tutta la larghezza della card così si adatta
          // alla larghezza dello schermo.
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'Aggiungi piatto',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// MODIFICA PASTO
// =========================================================

Future<void> mostraDialogModificaPasto({
  required BuildContext context,
  required AppDatabase database,
  required PastiData pasto,
}) async {
  // =====================================================
  // RECUPERA DATI
  // =====================================================

  final allergie = await database.getTutteLeAllergie();
  final preferenze = await database.getTutteLePreferenze();

  final allergiePasto = await database.getAllergiePasto(pasto.id);
  final preferenzePasto = await database.getPreferenzePasto(pasto.id);

  // =====================================================
  // CONTROLLER
  // =====================================================

  final controllerNomePasto = TextEditingController(text: pasto.nome);

  final controllerDescrizione = TextEditingController(text: pasto.descrizione);

  final controllerPrezzo = TextEditingController(
    text: pasto.prezzo.toStringAsFixed(2).replaceAll('.', ','),
  );

  final focusNodePrezzo = FocusNode();

  // =====================================================
  // SELEZIONI ATTUALI
  // =====================================================

  final allergieSelezionate = allergiePasto
      .map((allergia) => allergia.id)
      .toSet();

  final preferenzeSelezionate = preferenzePasto
      .map((preferenza) => preferenza.id)
      .toSet();

  // Le categorie BEVANDE e BAR non hanno allergeni né tipo di pasto.
  final mostraSezioniAllergiePreferenze =
      pasto.categoria != 'BEVANDE' && pasto.categoria != 'BAR';

  // Immagine attuale del pasto (sostituibile o rimovibile).
  Uint8List? immagineSelezionata = pasto.immagine;

  // =====================================================
  // FORMATTAZIONE PREZZO
  // =====================================================

  focusNodePrezzo.addListener(() {
    if (!focusNodePrezzo.hasFocus) {
      _formattaPrezzo(controllerPrezzo);
    }
  });

  if (!context.mounted) {
    controllerNomePasto.dispose();
    controllerDescrizione.dispose();
    controllerPrezzo.dispose();
    focusNodePrezzo.dispose();
    return;
  }

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              'Modifica piatto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            content: SizedBox(
              width: 450,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // =====================================================
                    // CATEGORIA
                    // =====================================================

                    Text(
                      pasto.categoria,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =====================================================
                    // IMMAGINE
                    // =====================================================
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              final bytes = await scegliImmagine();

                              if (bytes == null) {
                                return;
                              }

                              setState(() => immagineSelezionata = bytes);
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Impossibile selezionare l'immagine: $e",
                                  ),
                                ),
                              );
                            }
                          },
                          child: ImmagineSalvata(
                            bytes: immagineSelezionata,
                            width: 110,
                            height: 110,
                            cerchio: true,
                            icona: Icons.add,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          immagineSelezionata == null
                              ? 'Modifica immagine (opzionale)'
                              : 'Immagine scelta (tocca per cambiarla)',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),

                        // =========================================
                        // RIMUOVI L'IMMAGINE ATTUALE
                        // =========================================
                        if (immagineSelezionata != null)
                          TextButton.icon(
                            onPressed: () {
                              setState(() => immagineSelezionata = null);
                            },
                            icon: const Icon(Icons.delete_outline, size: 16),
                            label: const Text('Rimuovi immagine'),
                          ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // =====================================================
                    // NOME + PREZZO
                    // =====================================================
                    _buildNomePrezzoRow(
                      controllerNome: controllerNomePasto,
                      controllerPrezzo: controllerPrezzo,
                      focusNodePrezzo: focusNodePrezzo,
                    ),

                    const SizedBox(height: 18),

                    // =====================================================
                    // DESCRIZIONE
                    // =====================================================
                    TextField(
                      controller: controllerDescrizione,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Descrizione del piatto',
                        hintText: 'Inserisci una descrizione...',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),

                    if (mostraSezioniAllergiePreferenze) ...[
                      const SizedBox(height: 20),

                      // =====================================================
                      // ALLERGENI
                      // =====================================================
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Indicare eventuali allergeni:',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 8),

                      _buildCheckboxGrid(
                        elementi: allergie,
                        selezionati: allergieSelezionate,
                        getId: (allergia) => allergia.id,
                        getNome: (allergia) => allergia.nome,
                        onToggle: (id) {
                          setState(() {
                            if (allergieSelezionate.contains(id)) {
                              allergieSelezionate.remove(id);
                            } else {
                              allergieSelezionate.add(id);
                            }
                          });
                        },
                      ),

                      const SizedBox(height: 8),

                      // =====================================================
                      // PREFERENZE
                      // =====================================================
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Seleziona tipo di pasto:',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 8),

                      _buildCheckboxGrid(
                        elementi: preferenze,
                        selezionati: preferenzeSelezionate,
                        getId: (preferenza) => preferenza.id,
                        getNome: (preferenza) => preferenza.nome,
                        onToggle: (id) {
                          setState(() {
                            if (preferenzeSelezionate.contains(id)) {
                              preferenzeSelezionate.remove(id);
                            } else {
                              preferenzeSelezionate.add(id);
                            }
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // ===========================================================
            // PULSANTI
            // ===========================================================
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('Annulla'),
              ),

              ElevatedButton(
                onPressed: () async {
                  final nome = controllerNomePasto.text.trim();
                  final descrizione = controllerDescrizione.text.trim();

                  _formattaPrezzo(controllerPrezzo);

                  final prezzo = _parsePrezzo(controllerPrezzo.text);

                  if (nome.isEmpty || prezzo == null) {
                    return;
                  }

                  await database.modificaPasto(
                    pastoId: pasto.id,
                    nome: nome,
                    prezzo: prezzo,
                    descrizione: descrizione,
                    allergie: allergieSelezionate.toList(),
                    preferenze: preferenzeSelezionate.toList(),
                    imagePath: pasto.imagePath,
                  );

                  // ===============================================
                  // SALVATAGGIO IMMAGINE NEL DATABASE
                  // (null = immagine rimossa)
                  // ===============================================
                  await database.salvaImmaginePasto(
                    pastoId: pasto.id,
                    immagine: immagineSelezionata,
                  );

                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                },
                child: const Text('Salva modifiche'),
              ),
            ],
          );
        },
      );
    },
  );

  // =====================================================
  // DISPOSE
  // =====================================================

  controllerNomePasto.dispose();
  controllerDescrizione.dispose();
  controllerPrezzo.dispose();
  focusNodePrezzo.dispose();
}

// =========================================================
// PASTO ITEM
// =========================================================

class PastoItem extends StatelessWidget {
  final PastiData pasto;
  final AppDatabase database;

  const PastoItem({super.key, required this.pasto, required this.database});

  // =======================================================
  // DETTAGLI PASTO
  // =======================================================

  Future<void> _mostraDettagliPasto(BuildContext context) async {
    // Recuperiamo sempre il dato aggiornato dal database.
    final pastoAggiornato = await (database.select(
      database.pasti,
    )..where((tbl) => tbl.id.equals(pasto.id))).getSingleOrNull();

    if (pastoAggiornato == null || !context.mounted) {
      return;
    }

    final allergie = await database.getAllergiePasto(pastoAggiornato.id);

    final preferenze = await database.getPreferenzePasto(pastoAggiornato.id);

    if (!context.mounted) {
      return;
    }

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          // TITOLO + "X" DI USCITA IN ALTO A DESTRA
          title: Row(
            children: [
              Expanded(
                child: Text(
                  pastoAggiornato.nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(dialogContext),
                icon: const Icon(Icons.close),
                tooltip: 'Chiudi',
              ),
            ],
          ),

          content: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // =====================================================
                  // PREZZO
                  // =====================================================

                  Text(
                    '${pastoAggiornato.prezzo.toStringAsFixed(2).replaceAll('.', ',')} €',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 145, 53, 53),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =====================================================
                  // IMMAGINE + ALLERGENI + PREFERENZE
                  // =====================================================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMMAGINE

                      ImmagineSalvata(
                        bytes: pastoAggiornato.immagine,
                        width: 120,
                        height: 120,
                        cerchio: true,
                        icona: Icons.local_restaurant,
                      ),

                      const SizedBox(width: 30),

                      // ALLERGENI
                      Expanded(
                        child: _buildListaDettagli(
                          titolo: 'Allergeni:',
                          elementi: allergie.map((e) => e.nome).toList(),
                          testoVuoto: 'Nessun allergene',
                        ),
                      ),

                      const SizedBox(width: 25),

                      // PREFERENZE
                      Expanded(
                        child: _buildListaDettagli(
                          titolo: 'Tipo piatto:',
                          elementi: preferenze.map((e) => e.nome).toList(),
                          testoVuoto: 'Tipo non specificato',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // DESCRIZIONE
                  // =====================================================
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Descrizione:',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      pastoAggiornato.descrizione.isEmpty
                          ? 'Nessuna descrizione disponibile.'
                          : pastoAggiornato.descrizione,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===========================================================
          // PULSANTI
          // ===========================================================
          actions: [
            Row(
              children: [
                // =========================================================
                // ELIMINA PIATTO — SINISTRA
                // =========================================================
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 145, 53, 53),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () async {
                    final conferma = await showDialog<bool>(
                      context: dialogContext,
                      builder: (confirmContext) {
                        return AlertDialog(
                          title: const Text('Elimina piatto'),
                          content: Text(
                            'Sei sicuro di voler eliminare '
                            '"${pastoAggiornato.nome}"?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(confirmContext, false);
                              },
                              child: const Text('Annulla'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  145,
                                  53,
                                  53,
                                ),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(confirmContext, true);
                              },
                              child: const Text('Elimina'),
                            ),
                          ],
                        );
                      },
                    );

                    if (conferma != true) {
                      return;
                    }

                    await database.eliminaPasto(pastoAggiornato.id);

                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                    }
                  },
                  child: const Text('Elimina piatto'),
                ),

                // =========================================================
                // SPAZIO
                // =========================================================
                const Spacer(),

                // =========================================================
                // MODIFICA
                // =========================================================
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogContext);

                    await mostraDialogModificaPasto(
                      context: context,
                      database: database,
                      pasto: pastoAggiornato,
                    );

                    if (!context.mounted) {
                      return;
                    }

                    await _mostraDettagliPasto(context);
                  },
                  child: const Text('Modifica'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // =======================================================
  // LISTA DETTAGLI
  // =======================================================

  Widget _buildListaDettagli({
    required String titolo,
    required List<String> elementi,
    required String testoVuoto,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titolo,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        if (elementi.isEmpty)
          Text(testoVuoto, style: const TextStyle(color: Colors.black54))
        else
          ...elementi.map(
            (elemento) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(elemento, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // =======================================================
  // BUILD
  // =======================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _mostraDettagliPasto(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImmagineSalvata(
            bytes: pasto.immagine,
            width: 75,
            height: 75,
            cerchio: true,
            icona: Icons.local_restaurant,
            sfondo: Colors.white,
            bordo: Colors.transparent,
            coloreIcona: const Color.fromARGB(255, 145, 53, 53),
          ),

          const SizedBox(height: 8),

          // Il nome usa tutta la larghezza della card così il testo
          // si adatta alla larghezza dello schermo.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              pasto.nome,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
