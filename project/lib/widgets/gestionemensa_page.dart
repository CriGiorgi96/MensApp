import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/widgets/orariapertura_widget.dart';
import 'package:project/database/database.dart';
import 'package:project/pages/selectmenu_page.dart';
import 'package:project/pages/mensa_gestioneordini_page.dart.dart';
import 'package:project/pages/modifica_sede.dart';
import 'package:project/widgets/immagine_salvata.dart';

class GestioneMensaPage extends StatefulWidget {
  final AppDatabase database;
  final int mensaId;

  const GestioneMensaPage({
    super.key,
    required this.database,
    required this.mensaId,
  });

  @override
  State<GestioneMensaPage> createState() => _GestioneMensaPageState();
}

class _GestioneMensaPageState extends State<GestioneMensaPage> {
  static const Color primaryRed = Color.fromARGB(255, 203, 17, 4);

  static const LinearGradient gradientSfondo = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  // =========================================================
  // CATEGORIE DEL MENU
  // =========================================================

  static const List<String> categoriePasti = [
    'PRIMI',
    'SECONDI',
    'CONTORNI',
    'DOLCI',
    'BEVANDE',
    'BAR',
  ];

  // =========================================================
  // MENU DI OGGI COMPLETO?
  // =========================================================

  Future<bool> _menuDiOggiCompleto() async {
    final menu = await widget.database.getMenuDiOggi(widget.mensaId);

    for (final categoria in categoriePasti) {
      final categoriaCompleta = menu.any(
        (pasto) => pasto.categoria == categoria,
      );

      if (!categoriaCompleta) {
        return false;
      }
    }

    return true;
  }

  // =========================================================
  // MENU IMPOSTAZIONI
  // =========================================================

  void _mostraMenuImpostazioni(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Impostazioni struttura',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // =====================================================
              // MODIFICA STRUTTURA
              // =====================================================

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.edit_outlined, color: Colors.black87),
                title: const Text(
                  'Modifica struttura',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onTap: () async {
                  // Chiudiamo il dialog
                  Navigator.pop(dialogContext);

                  // Recuperiamo la mensa dal database
                  final mensa = await widget.database.getMensaPrincipale(
                    widget.mensaId,
                  );

                  if (mensa == null || !mounted) {
                    return;
                  }

                  // Apriamo la pagina di modifica
                  final modificata = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModificaSedeScreen(
                        database: widget.database,
                        mensa: mensa,
                      ),
                    ),
                  );

                  // Se la sede è stata modificata,
                  // aggiorniamo la pagina
                  if (modificata == true && mounted) {
                    setState(() {});
                  }
                },
              ),

              const Divider(),

              // =====================================================
              // ELIMINA STRUTTURA
              // =====================================================
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.delete_outline, color: primaryRed),
                title: const Text(
                  'Elimina struttura',
                  style: TextStyle(
                    color: primaryRed,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(dialogContext);

                  _confermaEliminazioneStruttura(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // CONFERMA ELIMINAZIONE
  // =========================================================

  Future<void> _confermaEliminazioneStruttura(BuildContext context) async {
    final conferma = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Eliminare la struttura?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Sei sicuro di voler eliminare questa struttura?',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text(
                'Annulla',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                foregroundColor: Colors.white,
              ),
              child: const Text('Elimina'),
            ),
          ],
        );
      },
    );

    if (conferma != true) {
      return;
    }

    try {
      await widget.database.eliminaMensa(widget.mensaId);

      if (!mounted) {
        return;
      }

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore durante l\'eliminazione della struttura: $e'),
          backgroundColor: primaryRed,
        ),
      );
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

        // =========================================================
        // APP BAR
        // =========================================================
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

          // =======================================================
          // INGRANAGGIO A DESTRA
          // =======================================================
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white, size: 27),
              onPressed: () {
                _mostraMenuImpostazioni(context);
              },
            ),

            const SizedBox(width: 8),
          ],
        ),

        // =========================================================
        // BODY
        // =========================================================
        body: SafeArea(
          child: FutureBuilder<MenseData?>(
            future: widget.database.getMensaPrincipale(widget.mensaId),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Errore nel caricamento della mensa.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              final mensa = snapshot.data;

              if (mensa == null) {
                return const Center(
                  child: Text(
                    'Mensa non trovata.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // =================================================
                    // NOME MENSA
                    // =================================================
                    Text(
                      mensa.nomeMensa,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // =================================================
                    // PULSANTI PRINCIPALI
                    // =================================================
                    _buildPulsantiPrincipali(context),

                    const SizedBox(height: 20),

                    // =================================================
                    // INFORMAZIONI + ORARI
                    // =================================================
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isSmallScreen = constraints.maxWidth < 700;

                        if (isSmallScreen) {
                          return Column(
                            children: [
                              _buildInformazioniMensa(mensa, isSmallScreen),

                              const SizedBox(height: 20),

                              _buildOrariApertura(),
                            ],
                          );
                        }

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildInformazioniMensa(
                                mensa,
                                isSmallScreen,
                              ),
                            ),

                            const SizedBox(width: 20),

                            Expanded(child: _buildOrariApertura()),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PULSANTI PRINCIPALI
  // =========================================================

  Widget _buildPulsantiPrincipali(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Su schermi stretti i due pulsanti vengono impilati uno sotto
        // l'altro, così i testi si adattano alla larghezza disponibile
        // e non straripano dal pulsante.
        final bool impilaPulsanti = constraints.maxWidth < 460;

        // I due pulsanti vengono costruiti prima e poi sistemati
        // in una Row (schermo largo) o in una Column (schermo stretto).
        // =======================================================
        // GESTIONE ORDINI
        // =======================================================

        final Widget pulsanteGestioneOrdini = SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GestioneOrdiniMensa(
                    database: widget.database,
                    mensaId: widget.mensaId,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryRed,
              foregroundColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.shopping_cart_outlined, size: 25),

                SizedBox(width: 10),

                Expanded(
                  child: Text(
                    'Gestione ordini',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );

        // =======================================================
        // SELEZIONA MENU DI OGGI
        // =======================================================
        final Widget pulsanteSelezionaMenu = SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectMenu(
                    database: widget.database,
                    mensaId: widget.mensaId,
                  ),
                ),
              );

              if (mounted) {
                setState(() {});
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: FutureBuilder<bool>(
              future: _menuDiOggiCompleto(),
              builder: (context, snapshot) {
                final bool menuCompleto = snapshot.data ?? false;

                return Row(
                  children: [
                    Icon(
                      menuCompleto
                          ? Icons.check_circle_outline
                          : Icons.error_outline,
                      color: menuCompleto ? Colors.green : primaryRed,
                      size: 27,
                    ),

                    const SizedBox(width: 10),

                    const Expanded(
                      child: Text(
                        'Seleziona Menù di oggi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );

        // =========================================================
        // RESTO DEL LAYOUT
        // =========================================================
        // Schermo largo: i due pulsanti restano affiancati.
        // Schermo stretto: vengono impilati uno sotto l'altro.
        if (impilaPulsanti) {
          return Column(
            children: [
              pulsanteGestioneOrdini,

              const SizedBox(height: 12),

              pulsanteSelezionaMenu,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: pulsanteGestioneOrdini),

            const SizedBox(width: 12),

            Expanded(child: pulsanteSelezionaMenu),
          ],
        );
      },
    );
  }

  // =========================================================
  // INFORMAZIONI MENSA
  // =========================================================

  Widget _buildInformazioniMensa(MenseData mensa, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================================================
          // INFORMAZIONI
          // =========================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informazioni mensa',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                _InfoRow(
                  icon: Icons.location_on,
                  title: 'Indirizzo',
                  value: '${mensa.indirizzo},\n${mensa.comune}, ${mensa.citta}',
                ),

                if (mensa.telefono != null && mensa.telefono!.isNotEmpty)
                  _InfoRow(
                    icon: Icons.phone,
                    title: 'Telefono',
                    value: mensa.telefono!,
                  ),

                if (mensa.partitaIva != null && mensa.partitaIva!.isNotEmpty)
                  _InfoRow(
                    icon: Icons.business,
                    title: 'Partita IVA',
                    value: mensa.partitaIva!,
                  ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // =========================================================
          // RIQUADRO IMMAGINE (tocca per scegliere la foto)
          // =========================================================
          _riquadroImmagine(mensa),
        ],
      ),
    );
  }

  // =========================================================
  // FOTO DELLA MENSA
  // =========================================================

  /// Riquadro con la foto della mensa: toccandolo si sceglie una
  /// nuova immagine (galleria su telefono, file salvati sul PC).
  Widget _riquadroImmagine(MenseData mensa) {
    final immagine = mensa.immagine;
    final haImmagine = immagine != null && immagine.isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ===============================================
        // SCELTA IMMAGINE
        // ===============================================
        InkWell(
          onTap: _scegliFotoMensa,
          borderRadius: BorderRadius.circular(14),
          child: haImmagine
              ? ImmagineSalvata(
                  bytes: immagine,
                  width: 150,
                  height: 150,
                  cerchio: false,
                  icona: Icons.add,
                  bordo: Colors.grey.shade400,
                )
              : Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 42,
                        color: Color.fromARGB(255, 145, 53, 53),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Aggiungi un\'immagine',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 145, 53, 53),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        ),

        // ===============================================
        // RIMUOVI IMMAGINE
        // ===============================================
        if (haImmagine)
          Positioned(
            top: 6,
            right: 6,
            child: Material(
              color: Colors.black54,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _rimuoviFotoMensa(),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.close, size: 18, color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Apre il selettore immagini (galleria su telefono, file sul PC)
  /// e salva la foto scelta nel database.
  Future<void> _scegliFotoMensa() async {
    try {
      final bytes = await scegliImmagine();

      if (bytes == null || !mounted) {
        return;
      }

      await widget.database.salvaImmagineMensa(
        mensaId: widget.mensaId,
        immagine: bytes,
      );

      if (!mounted) return;
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Immagine della mensa salvata.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Impossibile selezionare l'immagine: $e")),
      );
    }
  }

  /// Rimuove la foto della mensa dal database.
  Future<void> _rimuoviFotoMensa() async {
    await widget.database.salvaImmagineMensa(
      mensaId: widget.mensaId,
      immagine: null,
    );

    if (!mounted) return;
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Immagine della mensa rimossa.')),
    );
  }

  // =========================================================
  // ORARI APERTURA
  // =========================================================

  Widget _buildOrariApertura() {
    return OrariAperturaWidget(
      database: widget.database,
      mensaId: widget.mensaId,
    );
  }
}

// =========================================================
// RIGA INFORMAZIONE
// =========================================================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color.fromARGB(255, 145, 53, 53), size: 22),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
