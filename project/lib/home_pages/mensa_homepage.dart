import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';
import 'package:project/login/login_screen.dart';
import 'package:project/registrations/new_sede.dart';
import 'package:project/widgets/mensa_card.dart';
import 'package:project/widgets/pasto_item.dart';
import 'package:project/widgets/gestionemensa_page.dart';

class MensaHomepage extends StatefulWidget {
  const MensaHomepage({
    super.key,
    required this.database,
    required this.mensaId,
  });

  final AppDatabase database;
  final int mensaId;

  @override
  State<MensaHomepage> createState() => _MensaHomePageState();
}

class _MensaHomePageState extends State<MensaHomepage> {
  String categoriaSelezionata = 'PRIMI';

  // Categorie disponibili
  final List<String> categoriePasti = [
    'PRIMI',
    'SECONDI',
    'CONTORNI',
    'DOLCI',
    'BEVANDE',
    'BAR',
  ];

  final gradientSfondo = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  /// Recupera tutte le sedi appartenenti al profilo gestore.
  Stream<List<MenseData>> _watchTutteLeMense() async* {
    final gestore = await widget.database.getGestoreMensa(widget.mensaId);

    if (gestore == null) {
      yield [];
      return;
    }

    yield* widget.database.watchMenseGestore(gestore.id);
  }

  void _aggiornaStatoMense() {
    if (!mounted) return;

    setState(() {});
  }

  Future<bool> _mensaEaperta(MenseData mensa) async {
    final orari = await widget.database.getOrariMensa(mensa.id);

    final adesso = DateTime.now();

    String giornoOggi;

    switch (adesso.weekday) {
      case DateTime.monday:
        giornoOggi = 'Lunedì';
        break;

      case DateTime.tuesday:
        giornoOggi = 'Martedì';
        break;

      case DateTime.wednesday:
        giornoOggi = 'Mercoledì';
        break;

      case DateTime.thursday:
        giornoOggi = 'Giovedì';
        break;

      case DateTime.friday:
        giornoOggi = 'Venerdì';
        break;

      case DateTime.saturday:
        giornoOggi = 'Sabato';
        break;

      case DateTime.sunday:
        giornoOggi = 'Domenica';
        break;

      default:
        return false;
    }

    final minutiAttuali = adesso.hour * 60 + adesso.minute;

    final orariDiOggi = orari.where((orario) => orario.giorno == giornoOggi);

    for (final orario in orariDiOggi) {
      if (minutiAttuali >= orario.aperturaMinuti &&
          minutiAttuali < orario.chiusuraMinuti) {
        return true;
      }
    }

    return false;
  }

  void apriDialog() {
    mostraDialogAggiungiPasto(
      context: context,
      database: widget.database,
      mensaId: widget.mensaId,
      categoria: categoriaSelezionata,
    );
  }

  List<Widget> _figliConEspansione({
    required bool espandi,
    required Widget child,
  }) {
    if (espandi) {
      return [Expanded(child: child)];
    }

    return [child];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 76, 76),
        foregroundColor: Colors.white,

        // =====================================================
        // LOGOUT DIRETTO
        // =====================================================
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(database: widget.database),
              ),
              (route) => false,
            );
          },
          icon: const Icon(Icons.logout),
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
        decoration: BoxDecoration(gradient: gradientSfondo),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isDesktop = constraints.maxWidth > 700;

              // =================================================
              // COLONNE GRIGLIA PASTI
              // =================================================
              // Il numero di colonne si adatta sempre alla larghezza
              // disponibile (metà finestra in desktop, tutta in mobile):
              // così i testi e i pulsanti delle card non si stringono
              // mai troppo.
              final double larghezzaPannello = isDesktop
                  ? (constraints.maxWidth - 24) / 2
                  : constraints.maxWidth;

              int colonneGriglia = (larghezzaPannello / 150).floor();

              if (colonneGriglia < 2) {
                colonneGriglia = 2;
              }

              if (colonneGriglia > 5) {
                colonneGriglia = 5;
              }

              // =================================================
              // COLONNA SEDI
              // =================================================

              final Widget colonnaSedi = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Le mie sedi:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Su schermo stretto la lista va sotto il titolo e viene
                  // fatta scorrere dalla SingleChildScrollView esterna.
                  ..._figliConEspansione(
                    espandi: isDesktop,
                    child: StreamBuilder<List<MenseData>>(
                      stream: _watchTutteLeMense(),

                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Errore DB: ${snapshot.error}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        final menseDB = snapshot.data ?? [];

                        if (menseDB.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nessuna sede trovata.',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return ListView.builder(
                          // Su schermo piccolo la lista si adatta al contenuto
                          // e lascia scorrere il SingleChildScrollView esterno.
                          shrinkWrap: !isDesktop,
                          physics: isDesktop
                              ? null
                              : const NeverScrollableScrollPhysics(),

                          itemCount: menseDB.length + 1,

                          itemBuilder: (context, index) {
                            // =================================
                            // SEDI ESISTENTI
                            // =================================

                            if (index < menseDB.length) {
                              final mensa = menseDB[index];

                              return FutureBuilder<bool>(
                                future: _mensaEaperta(mensa),

                                builder: (context, statoApertura) {
                                  final bool aperta =
                                      statoApertura.data ?? false;

                                  return MensaCard(
                                    nomeMensa: mensa.nomeMensa,
                                    indirizzo: mensa.indirizzo,
                                    citta: mensa.citta,
                                    comune: mensa.comune,
                                    telefono: mensa.telefono,
                                    aperto: aperta,

                                    // Mostro la foto scelta per la mensa;
                                    // se non c'è, MensaCard mostra da sola
                                    // l'icona di segnaposto.
                                    immagine: mensa.immagine,

                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GestioneMensaPage(
                                                database: widget.database,
                                                mensaId: mensa.id,
                                              ),
                                        ),
                                      );

                                      _aggiornaStatoMense();
                                    },
                                  );
                                },
                              );
                            }

                            // =================================
                            // AGGIUNGI ALTRA SEDE
                            // =================================

                            return Card(
                              elevation: 0,
                              color: Colors.white.withOpacity(0.15),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),

                                onTap: () async {
                                  final principale = await widget.database
                                      .getMensaPrincipale(widget.mensaId);

                                  if (principale == null || !context.mounted) {
                                    return;
                                  }

                                  await Navigator.push<bool>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewMensaScreen(
                                        database: widget.database,
                                        mensaPrincipale: principale,
                                      ),
                                    ),
                                  );
                                },

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 16,
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      const Text(
                                        'Aggiungi altra sede',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );

              // =================================================
              // COLONNA PASTI
              // =================================================

              final Widget colonnaPannello = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'I miei pasti:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 17),

                  // =================================================
                  // MENU CATEGORIE
                  // =================================================
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),

                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: categoriaSelezionata,

                        isExpanded: true,

                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.red,
                        ),

                        dropdownColor: Colors.white,

                        borderRadius: BorderRadius.circular(12),

                        items: categoriePasti.map((String categoria) {
                          return DropdownMenuItem<String>(
                            value: categoria,

                            child: Text(
                              categoria,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          );
                        }).toList(),

                        onChanged: (String? nuovaCategoria) {
                          if (nuovaCategoria != null) {
                            setState(() {
                              categoriaSelezionata = nuovaCategoria;
                            });
                          }
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // GRIGLIA PASTI
                  // =================================================
                  // Su schermo stretto la colonna dei pasti passa sotto
                  // quella delle sedi, dentro la SingleChildScrollView.
                  ..._figliConEspansione(
                    espandi: isDesktop,
                    child: StreamBuilder<List<PastiData>>(
                      stream: widget.database.watchPastiPerCategoria(
                        widget.mensaId,
                        categoriaSelezionata,
                      ),

                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Errore DB: ${snapshot.error}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        final pastiSalvati = snapshot.data ?? [];

                        return GridView.builder(
                          // Su schermo piccolo la griglia si adatta al
                          // contenuto e lascia scorrere il SingleChildScrollView
                          // esterno.
                          shrinkWrap: !isDesktop,
                          physics: isDesktop
                              ? null
                              : const NeverScrollableScrollPhysics(),

                          padding: const EdgeInsets.all(8),

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: colonneGriglia,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                childAspectRatio: 1.2,
                              ),

                          // +1 perché l'ultimo elemento
                          // è il pulsante "+"
                          itemCount: pastiSalvati.length + 1,

                          itemBuilder: (context, index) {
                            // =================================
                            // PULSANTE AGGIUNGI PASTO
                            // =================================

                            if (index == pastiSalvati.length) {
                              return AggiungiPastoItem(onTap: apriDialog);
                            }

                            // =================================
                            // PASTO DAL DATABASE
                            // =================================

                            final pasto = pastiSalvati[index];

                            return PastoItem(
                              pasto: pasto,
                              database: widget.database,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );

              // =================================================
              // LAYOUT DESKTOP
              // =================================================

              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(child: colonnaSedi),

                    const SizedBox(width: 24),

                    Expanded(child: colonnaPannello),
                  ],
                );
              }

              // =================================================
              // LAYOUT MOBILE
              // =================================================

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    colonnaSedi,

                    const SizedBox(height: 24),

                    colonnaPannello,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
