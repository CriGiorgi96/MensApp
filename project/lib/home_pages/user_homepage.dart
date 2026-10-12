import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';
import 'package:project/login/login_screen.dart';
import 'package:project/pages/mensa_upage.dart';
import 'package:project/pages/ordini_utente_page.dart';
import 'package:project/pages/storico_ordini_page.dart';
import 'package:project/widgets/immagine_salvata.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({
    super.key,
    required this.database,
    required this.utenteId,
  });

  final AppDatabase database;
  final int utenteId;

  @override
  State<UserHomepage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomepage> {
  final Set<int> _strutturePreferiteIds = {};
  final Set<int> _preferitiInAggiornamento = {};
  final List<MenseData> strutturePreferite = [];
  late final Future<List<MenseData>> _menseNellaCitta;
  late Future<UtentiData?> _profiloUtente;
  bool _preferitiCaricati = false;

  final gradientSfondo = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  @override
  void initState() {
    super.initState();
    _menseNellaCitta = widget.database.getMenseNellaCittaUtente(
      widget.utenteId,
    );
    _profiloUtente = widget.database.getUtenteById(widget.utenteId);
    _caricaPreferiti();
  }

  Future<void> _mostraDatiUtente() async {
    if (!mounted) return;
    final utente = await _profiloUtente;
    if (!mounted || utente == null) return;

    final salvato = await showDialog<bool>(
      context: context,
      builder: (dialogContext) =>
          _DialogoDatiUtente(database: widget.database, utente: utente),
    );

    if (salvato == true && mounted) {
      _profiloUtente = widget.database.getUtenteById(widget.utenteId);
      setState(() {});
    }
  }

  Future<void> _mostraAllergieUtente() async {
    final salvato = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => _DialogoAllergieUtente(
        database: widget.database,
        utenteId: widget.utenteId,
      ),
    );

    if (salvato == true && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Allergie aggiornate.')));
    }
  }

  Future<void> _mostraPreferenzeUtente() async {
    final salvato = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => _DialogoPreferenzeUtente(
        database: widget.database,
        utenteId: widget.utenteId,
      ),
    );

    if (salvato == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Preferenze aggiornate.')));
    }
  }

  Future<void> _caricaPreferiti() async {
    try {
      final preferite = await widget.database.getMensePreferiteUtente(
        widget.utenteId,
      );

      if (!mounted) return;

      setState(() {
        _strutturePreferiteIds.addAll(preferite.map((mensa) => mensa.id));
        strutturePreferite.addAll(preferite);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore caricamento preferiti: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _preferitiCaricati = true;
        });
      }
    }
  }

  Future<void> _togglePreferito(
    MenseData mensa, {
    BuildContext? dialogContext,
    StateSetter? setDialogState,
  }) async {
    if (!_preferitiCaricati || _preferitiInAggiornamento.contains(mensa.id)) {
      return;
    }

    final isFavorite = _strutturePreferiteIds.contains(mensa.id);

    setState(() {
      _preferitiInAggiornamento.add(mensa.id);
    });
    if (dialogContext?.mounted == true) {
      setDialogState?.call(() {});
    }

    try {
      if (isFavorite) {
        await widget.database.rimuoviMensaPreferita(
          utenteId: widget.utenteId,
          mensaId: mensa.id,
        );
      } else {
        await widget.database.aggiungiMensaPreferita(
          utenteId: widget.utenteId,
          mensaId: mensa.id,
        );
      }

      if (!mounted) return;

      setState(() {
        if (isFavorite) {
          _strutturePreferiteIds.remove(mensa.id);
          strutturePreferite.removeWhere(
            (preferita) => preferita.id == mensa.id,
          );
        } else {
          _strutturePreferiteIds.add(mensa.id);
          strutturePreferite.add(mensa);
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore aggiornamento preferito: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _preferitiInAggiornamento.remove(mensa.id);
        });
      }
      if (dialogContext?.mounted == true) {
        setDialogState?.call(() {});
      }
    }
  }

  final Map<int, Future<bool>> _statiApertura = {};

  Future<bool> _statoApertura(int mensaId) => _statiApertura.putIfAbsent(
    mensaId,
    () => widget.database.isMensaAperta(mensaId),
  );

  /// Riga "Aperta" / "Chiusa" mostrata sempre sotto il numero
  /// di telefono all'interno della card della mensa.
  Widget _rigaStatoApertura(MenseData mensa) {
    return FutureBuilder<bool>(
      future: _statoApertura(mensa.id),
      builder: (context, snapshot) {
        // Durante il caricamento viene mostrato lo stato provvisorio.
        final aperto = snapshot.data ?? false;

        return Row(
          children: [
            Icon(
              aperto ? Icons.check_circle : Icons.cancel,
              size: 20,
              color: aperto ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                aperto ? 'Aperta' : 'Chiusa',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: aperto ? Colors.green[800] : Colors.red[800],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStructureCard(MenseData mensa, {required bool isFavorite}) {
    final isUpdating = _preferitiInAggiornamento.contains(mensa.id);

    return GestureDetector(
      onTap: () => _apriMensa(mensa),
      child: Container(
        width: 150,
        height: 205,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ImmagineSalvata(
                      bytes: mensa.immagine,
                      width: double.infinity,
                      height: 80,
                      cerchio: false,
                      icona: Icons.restaurant,
                      bordo: Colors.transparent,
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton(
                        tooltip: isFavorite
                            ? 'Rimuovi dai preferiti'
                            : 'Aggiungi ai preferiti',
                        constraints: const BoxConstraints.tightFor(
                          width: 36,
                          height: 36,
                        ),
                        padding: EdgeInsets.zero,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black45,
                        ),
                        onPressed: !_preferitiCaricati || isUpdating
                            ? null
                            : () => _togglePreferito(mensa),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 19,
                          color: isFavorite ? Colors.red : Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mensa.nomeMensa,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              mensa.indirizzo,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_city,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              '${mensa.comune}, ${mensa.citta}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      if (mensa.telefono != null &&
                          mensa.telefono!.trim().isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 12,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                mensa.telefono!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ],

                      // ===========================================
                      // STATO APERTURA (sempre visibile)
                      // ===========================================
                      const SizedBox(height: 8),
                      _rigaStatoApertura(mensa),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _apriMensa(MenseData mensa) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => MensaUpage(
          mensa: mensa,
          database: widget.database,
          utenteId: widget.utenteId,
          isFavorite: _strutturePreferiteIds.contains(mensa.id),
          canToggleFavorite: _preferitiCaricati,
          onToggleFavorite: () async {
            await _togglePreferito(mensa);
            return _strutturePreferiteIds.contains(mensa.id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 76, 76),
        foregroundColor: Colors.white,

        leadingWidth: 170,

        // Pulsante profilo a sinistra
        leading: Builder(
          builder: (context) {
            return TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.person, color: Colors.white),
              label: FutureBuilder<UtentiData?>(
                future: _profiloUtente,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      'Caricamento...',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    );
                  }

                  final utente = snapshot.data;

                  if (utente == null) {
                    return const Text(
                      'Profilo',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    );
                  }

                  // FittedBox mostra l'intero nome accanto all'icona:
                  // si riduce solo se troppo lungo, senza ellissi.
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Menu utente',
                      maxLines: 1,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),

        centerTitle: true,

        // Titolo dell'AppBar
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

      // ============================================================
      // DRAWER
      // ============================================================
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 78, 76, 76),
              ),
              child: FutureBuilder<UtentiData?>(
                future: _profiloUtente,
                builder: (context, snapshot) {
                  final nome = snapshot.data?.nome;
                  return Text(
                    nome == null ? 'Ciao' : 'Ciao, $nome',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _mostraDatiUtente,
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text('I miei dati'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _mostraPreferenzeUtente,
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text('Le mie preferenze'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _mostraAllergieUtente,
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text('Le mie allergie'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => StoricoOrdiniPage(
                        database: widget.database,
                        utenteId: widget.utenteId,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text('Storico ordini'),
              ),
            ),

            // Spazio che spinge il logout in fondo
            const Spacer(),

            const Divider(),

            // ========================================================
            // LOGOUT
            // ========================================================
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),

              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen(database: widget.database),
                  ),
                  (route) => false,
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
      // ============================================================
      // CORPO DELLA HOMEPAGE
      // ============================================================
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: gradientSfondo),

        // ============================================================
        // SCROLL VERTICALE DELL'INTERA PAGINA
        // ============================================================
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 25,
              right: 25,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ======================================================
                // PULSANTE I MIEI ORDINI
                // ======================================================

                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => OrdiniUtentePage(
                          database: widget.database,
                          utenteId: widget.utenteId,
                        ),
                      ),
                    );
                  },

                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.receipt_long,
                        color: Colors.white,
                        size: 26,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        'I miei ordini',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ======================================================
                // PULSANTE CERCA STRUTTURE
                // ======================================================
                TextButton(
                  onPressed: () async {
                    final mense = await widget.database.getTutteLeMense();

                    if (!context.mounted) return;

                    var ricercaMense = '';
                    var localitaSelezionata = '';
                    final localitaDisponibili =
                        mense
                            .map((mensa) => mensa.citta.trim().toUpperCase())
                            .toSet()
                            .toList()
                          ..sort();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setDialogState) {
                            final query = ricercaMense.trim().toLowerCase();
                            final menseFiltrate = mense.where((mensa) {
                              final testoMensa =
                                  '${mensa.nomeMensa} ${mensa.indirizzo} '
                                          '${mensa.comune} ${mensa.citta}'
                                      .toLowerCase();
                              final corrispondeRicerca =
                                  query.isEmpty || testoMensa.contains(query);
                              final localita = mensa.citta.trim().toUpperCase();
                              final corrispondeLocalita =
                                  localitaSelezionata.isEmpty ||
                                  localita == localitaSelezionata;

                              return corrispondeRicerca && corrispondeLocalita;
                            }).toList();

                            return Dialog(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.95,
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                child: Column(
                                  children: [
                                    // ======================================================
                                    // TITOLO
                                    // ======================================================

                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.restaurant,
                                            size: 28,
                                          ),

                                          const SizedBox(width: 10),

                                          const Expanded(
                                            child: Text(
                                              'Cerca strutture',
                                              style: TextStyle(
                                                fontSize: 24,
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
                                    ),

                                    const Divider(),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        20,
                                        8,
                                        20,
                                        12,
                                      ),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          // CITTÀ
                                          final Widget barraCitta = TextField(
                                            decoration: const InputDecoration(
                                              hintText: 'Cerca nome, indirizzo o città',
                                              prefixIcon: Icon(Icons.search),
                                              isDense: true,
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              setDialogState(() {
                                                ricercaMense = value;
                                              });
                                            },
                                          );

                                          // LOCALITÀ
                                          final Widget menuLocalita =
                                              DropdownButtonFormField<String>(
                                                initialValue:
                                                    localitaSelezionata,
                                                isExpanded: true,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: 'Località',
                                                      isDense: true,
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                items: [
                                                  const DropdownMenuItem(
                                                    value: '',
                                                    child: Text('Tutte'),
                                                  ),
                                                  ...localitaDisponibili.map(
                                                    (localita) =>
                                                        DropdownMenuItem(
                                                          value: localita,
                                                          child: Text(
                                                            localita,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  setDialogState(() {
                                                    localitaSelezionata =
                                                        value ?? '';
                                                  });
                                                },
                                              );

                                          // Su schermi stretti la ricerca
                                          // per località passa sotto la
                                          // barra di ricerca.
                                          if (constraints.maxWidth < 500) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                barraCitta,
                                                const SizedBox(height: 10),
                                                menuLocalita,
                                              ],
                                            );
                                          }

                                          return Row(
                                            children: [
                                              Expanded(child: barraCitta),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                width: 190,
                                                child: menuLocalita,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),

                                    // ======================================================
                                    // GRIGLIA MENSE
                                    // ======================================================
                                    Expanded(
                                      child: mense.isEmpty
                                          ? const Center(
                                              child: Text(
                                                'Nessuna mensa registrata.',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            )
                                          : menseFiltrate.isEmpty
                                          ? const Center(
                                              child: Text(
                                                'Nessuna mensa corrisponde ai filtri.',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            )
                                          : GridView.builder(
                                              padding: const EdgeInsets.all(20),

                                              gridDelegate:
                                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 200,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                    mainAxisExtent: 192,
                                                  ),

                                              itemCount: menseFiltrate.length,

                                              itemBuilder: (context, index) {
                                                final mensa =
                                                    menseFiltrate[index];
                                                final isFavorite =
                                                    _strutturePreferiteIds
                                                        .contains(mensa.id);
                                                final isUpdating =
                                                    _preferitiInAggiornamento
                                                        .contains(mensa.id);

                                                return Card(
                                                  elevation: 4,
                                                  margin: EdgeInsets.zero,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: InkWell(
                                                    onTap: () =>
                                                        _apriMensa(mensa),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 80,
                                                          width:
                                                              double.infinity,
                                                          child: Stack(
                                                            fit:
                                                                StackFit.expand,
                                                            children: [
                                                              ImmagineSalvata(
                                                                bytes: mensa
                                                                    .immagine,
                                                                width: double
                                                                    .infinity,
                                                                height: 80,
                                                                cerchio: false,
                                                                icona: Icons
                                                                    .restaurant,
                                                                bordo: Colors
                                                                    .transparent,
                                                              ),
                                                              Positioned(
                                                                top: 4,
                                                                right: 4,
                                                                child: IconButton(
                                                                  tooltip:
                                                                      isFavorite
                                                                      ? 'Rimuovi dai preferiti'
                                                                      : 'Aggiungi ai preferiti',
                                                                  constraints:
                                                                      const BoxConstraints.tightFor(
                                                                        width:
                                                                            36,
                                                                        height:
                                                                            36,
                                                                      ),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  style: IconButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .black45,
                                                                  ),
                                                                  onPressed:
                                                                      !_preferitiCaricati ||
                                                                          isUpdating
                                                                      ? null
                                                                      : () => _togglePreferito(
                                                                          mensa,
                                                                          dialogContext:
                                                                              context,
                                                                          setDialogState:
                                                                              setDialogState,
                                                                        ),
                                                                  icon: Icon(
                                                                    isFavorite
                                                                        ? Icons
                                                                              .favorite
                                                                        : Icons
                                                                              .favorite_border,
                                                                    size: 19,
                                                                    color:
                                                                        isFavorite
                                                                        ? Colors
                                                                              .red
                                                                        : Colors
                                                                              .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 7,
                                                                vertical: 4,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              // FittedBox riduce
                                                              // la larghezza del
                                                              // testo se non ci
                                                              // sta: il nome della
                                                              // mensa non va
                                                              // mai a capo.
                                                              FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  mensa
                                                                      .nomeMensa,
                                                                  maxLines: 1,
                                                                  style: GoogleFonts.raleway(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .location_on,
                                                                    size: 12,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      mensa
                                                                          .indirizzo,
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .location_city,
                                                                    size: 12,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      '${mensa.comune}, ${mensa.citta}',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              if (mensa.telefono !=
                                                                      null &&
                                                                  mensa
                                                                      .telefono!
                                                                      .trim()
                                                                      .isNotEmpty) ...[
                                                                const SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .phone,
                                                                      size: 12,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 3,
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        mensa
                                                                            .telefono!,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                              // ===========================================
                                                              // STATO APERTURA (sempre visibile)
                                                              // ===========================================
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              _rigaStatoApertura(
                                                                mensa,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },

                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, color: Colors.white, size: 26),

                      const SizedBox(width: 6),

                      Text(
                        'Cerca strutture',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ======================================================
                // STRUTTURE PREFERITE
                // ======================================================
                Text(
                  'Le mie strutture preferite:',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                // ======================================================
                // RIGA STRUTTURE PREFERITE
                // ======================================================
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: [
                      // ------------------------------------------------
                      // NESSUNA STRUTTURA PREFERITA
                      // ------------------------------------------------

                      if (strutturePreferite.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: 15),

                          child: Container(
                            width: 150,
                            height: 205,

                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.20),

                              borderRadius: BorderRadius.circular(15),

                              border: Border.all(
                                color: Colors.white.withOpacity(0.12),
                                width: 1,
                              ),
                            ),

                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),

                                child: Text(
                                  'Nessuna struttura\naggiunta ai preferiti',

                                  textAlign: TextAlign.center,

                                  style: GoogleFonts.raleway(
                                    color: Colors.white.withOpacity(0.45),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // ------------------------------------------------
                      // STRUTTURE PREFERITE
                      // ------------------------------------------------
                      ...strutturePreferite.map(
                        (struttura) => Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: _buildStructureCard(
                            struttura,
                            isFavorite: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ======================================================
                // STRUTTURE VICINE
                // ======================================================
                Text(
                  'Strutture vicine:',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                FutureBuilder<List<MenseData>>(
                  future: _menseNellaCitta,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        width: 150,
                        height: 205,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (snapshot.hasError) {
                      return SizedBox(
                        width: 150,
                        height: 205,
                        child: Center(
                          child: Text(
                            'Errore nel caricamento delle mense.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(color: Colors.white),
                          ),
                        ),
                      );
                    }

                    final menseNellaCitta = snapshot.data ?? [];

                    if (menseNellaCitta.isEmpty) {
                      return Container(
                        width: 150,
                        height: 205,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.20),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Nessuna mensa nella tua città',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                color: Colors.white.withOpacity(0.45),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: menseNellaCitta
                            .map(
                              (mensa) => Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: _buildStructureCard(
                                  mensa,
                                  isFavorite: _strutturePreferiteIds.contains(
                                    mensa.id,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DatiAllergieUtente {
  const _DatiAllergieUtente({
    required this.allergeni,
    required this.selezionati,
  });

  final List<AllergieData> allergeni;
  final Set<int> selezionati;
}

class _DialogoAllergieUtente extends StatefulWidget {
  const _DialogoAllergieUtente({
    required this.database,
    required this.utenteId,
  });

  final AppDatabase database;
  final int utenteId;

  @override
  State<_DialogoAllergieUtente> createState() => _DialogoAllergieUtenteState();
}

class _DialogoAllergieUtenteState extends State<_DialogoAllergieUtente> {
  late final Future<_DatiAllergieUtente> _datiFuture;
  final Set<int> _selezionati = {};
  bool _inSalvataggio = false;

  @override
  void initState() {
    super.initState();
    _datiFuture = _caricaDati().then((dati) {
      _selezionati.addAll(dati.selezionati);
      return dati;
    });
  }

  Future<_DatiAllergieUtente> _caricaDati() async {
    final allergeni = await widget.database.getTutteLeAllergie();
    final selezionati = await widget.database.getAllergieUtenteIds(
      widget.utenteId,
    );
    return _DatiAllergieUtente(allergeni: allergeni, selezionati: selezionati);
  }

  Future<void> _salva() async {
    setState(() {
      _inSalvataggio = true;
    });

    try {
      await widget.database.aggiornaAllergieUtente(
        utenteId: widget.utenteId,
        allergieIds: _selezionati,
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _inSalvataggio = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante il salvataggio: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 560,
          maxHeight: MediaQuery.of(context).size.height * 0.82,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FutureBuilder<_DatiAllergieUtente>(
            future: _datiFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Impossibile caricare gli allergeni.'),
                );
              }

              final allergeni = snapshot.data?.allergeni ?? [];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFF913535),
                          child: Icon(
                            Icons.health_and_safety_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Le mie allergie',
                            style: GoogleFonts.raleway(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Chiudi',
                          onPressed: _inSalvataggio
                              ? null
                              : () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Seleziona tutti gli allergeni applicabili.'),
                    ),
                  ),
                  const Divider(height: 20),
                  Expanded(
                    child: allergeni.isEmpty
                        ? const Center(
                            child: Text('Nessun allergene disponibile.'),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: allergeni.length,
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final allergene = allergeni[index];
                              return Material(
                                color: Colors.transparent,
                                child: CheckboxListTile(
                                  value: _selezionati.contains(allergene.id),
                                  title: Text(allergene.nome),
                                  activeColor: const Color(0xFF913535),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  onChanged: _inSalvataggio
                                      ? null
                                      : (selezionato) {
                                          setState(() {
                                            if (selezionato == true) {
                                              _selezionati.add(allergene.id);
                                            } else {
                                              _selezionati.remove(allergene.id);
                                            }
                                          });
                                        },
                                ),
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _inSalvataggio
                              ? null
                              : () => Navigator.pop(context),
                          child: const Text('Annulla'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _inSalvataggio ? null : _salva,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF913535),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            _inSalvataggio ? 'Salvataggio...' : 'Salva',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DatiPreferenzeUtente {
  const _DatiPreferenzeUtente({
    required this.preferenze,
    required this.selezionate,
  });

  final List<PreferenzeData> preferenze;
  final Set<int> selezionate;
}

class _DialogoPreferenzeUtente extends StatefulWidget {
  const _DialogoPreferenzeUtente({
    required this.database,
    required this.utenteId,
  });

  final AppDatabase database;
  final int utenteId;

  @override
  State<_DialogoPreferenzeUtente> createState() =>
      _DialogoPreferenzeUtenteState();
}

class _DialogoPreferenzeUtenteState extends State<_DialogoPreferenzeUtente> {
  late final Future<_DatiPreferenzeUtente> _datiFuture;
  final Set<int> _selezionate = {};
  bool _inSalvataggio = false;

  @override
  void initState() {
    super.initState();
    _datiFuture = _caricaDati().then((dati) {
      _selezionate.addAll(dati.selezionate);
      return dati;
    });
  }

  Future<_DatiPreferenzeUtente> _caricaDati() async {
    final preferenze = await widget.database.getTutteLePreferenze();
    final selezionate = await widget.database.getPreferenzeUtenteIds(
      widget.utenteId,
    );
    return _DatiPreferenzeUtente(
      preferenze: preferenze,
      selezionate: selezionate,
    );
  }

  Future<void> _salva() async {
    setState(() {
      _inSalvataggio = true;
    });

    try {
      await widget.database.aggiornaPreferenzeUtente(
        utenteId: widget.utenteId,
        preferenzeIds: _selezionate,
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _inSalvataggio = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante il salvataggio: $e')),
      );
    }
  }

  void _aggiornaSelezione(PreferenzeData preferenza, bool? selezionata) {
    if (selezionata == true &&
        !_selezionate.contains(preferenza.id) &&
        _selezionate.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Puoi selezionare al massimo 6 preferenze.'),
        ),
      );
      return;
    }

    setState(() {
      if (selezionata == true) {
        _selezionate.add(preferenza.id);
      } else {
        _selezionate.remove(preferenza.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 560,
          maxHeight: MediaQuery.of(context).size.height * 0.82,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FutureBuilder<_DatiPreferenzeUtente>(
            future: _datiFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Impossibile caricare le preferenze.'),
                );
              }

              final preferenze = snapshot.data?.preferenze ?? [];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFF913535),
                          child: Icon(Icons.tune, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Le mie preferenze',
                            style: GoogleFonts.raleway(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Chiudi',
                          onPressed: _inSalvataggio
                              ? null
                              : () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selezionate ${_selezionate.length} di 6 preferenze.',
                      ),
                    ),
                  ),
                  const Divider(height: 20),
                  Expanded(
                    child: preferenze.isEmpty
                        ? const Center(
                            child: Text('Nessuna preferenza disponibile.'),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: preferenze.length,
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final preferenza = preferenze[index];
                              return Material(
                                color: Colors.transparent,
                                child: CheckboxListTile(
                                  value: _selezionate.contains(preferenza.id),
                                  title: Text(preferenza.nome),
                                  activeColor: const Color(0xFF913535),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  onChanged: _inSalvataggio
                                      ? null
                                      : (selezionata) => _aggiornaSelezione(
                                          preferenza,
                                          selezionata,
                                        ),
                                ),
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _inSalvataggio
                              ? null
                              : () => Navigator.pop(context),
                          child: const Text('Annulla'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _inSalvataggio ? null : _salva,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF913535),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            _inSalvataggio ? 'Salvataggio...' : 'Salva',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DialogoDatiUtente extends StatefulWidget {
  const _DialogoDatiUtente({required this.database, required this.utente});

  final AppDatabase database;
  final UtentiData utente;

  @override
  State<_DialogoDatiUtente> createState() => _DialogoDatiUtenteState();
}

class _DialogoDatiUtenteState extends State<_DialogoDatiUtente> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _cognomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _indirizzoController;
  late final TextEditingController _comuneController;
  late final TextEditingController _provinciaController;
  late final TextEditingController _dataNascitaController;

  bool _inModifica = false;
  bool _inSalvataggio = false;

  @override
  void initState() {
    super.initState();
    final utente = widget.utente;
    _nomeController = TextEditingController(text: utente.nome);
    _cognomeController = TextEditingController(text: utente.cognome);
    _emailController = TextEditingController(text: utente.email);
    _passwordController = TextEditingController(text: utente.password);
    _indirizzoController = TextEditingController(text: utente.indirizzo);
    _comuneController = TextEditingController(text: utente.comune);
    _provinciaController = TextEditingController(text: utente.provincia);
    _dataNascitaController = TextEditingController(
      text:
          '${utente.dataNascita.day.toString().padLeft(2, '0')}/'
          '${utente.dataNascita.month.toString().padLeft(2, '0')}/'
          '${utente.dataNascita.year}',
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cognomeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _indirizzoController.dispose();
    _comuneController.dispose();
    _provinciaController.dispose();
    _dataNascitaController.dispose();
    super.dispose();
  }

  String? _validaDataNascita(String? value) {
    if (!_inModifica) return null;
    final parti = value?.split('/') ?? [];
    if (parti.length != 3 ||
        parti.any((parte) => int.tryParse(parte) == null)) {
      return 'Usa il formato gg/mm/aaaa';
    }

    final giorno = int.parse(parti[0]);
    final mese = int.parse(parti[1]);
    final anno = int.parse(parti[2]);
    final data = DateTime(anno, mese, giorno);
    if (data.day != giorno || data.month != mese || data.year != anno) {
      return 'Inserisci una data valida';
    }
    return null;
  }

  Future<void> _salvaModifiche() async {
    if (!_formKey.currentState!.validate()) return;

    final partiData = _dataNascitaController.text.split('/');
    final dataNascita = DateTime(
      int.parse(partiData[2]),
      int.parse(partiData[1]),
      int.parse(partiData[0]),
    );

    setState(() {
      _inSalvataggio = true;
    });

    try {
      await widget.database.aggiornaUtente(
        utenteId: widget.utente.id,
        nome: _nomeController.text,
        cognome: _cognomeController.text,
        email: _emailController.text,
        indirizzo: _indirizzoController.text,
        comune: _comuneController.text,
        provincia: _provinciaController.text,
        password: _passwordController.text,
        dataNascita: dataNascita,
      );

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _inSalvataggio = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante il salvataggio: $e')),
      );
    }
  }

  void _annullaModifica() {
    final utente = widget.utente;
    _nomeController.text = utente.nome;
    _cognomeController.text = utente.cognome;
    _emailController.text = utente.email;
    _passwordController.text = utente.password;
    _indirizzoController.text = utente.indirizzo;
    _comuneController.text = utente.comune;
    _provinciaController.text = utente.provincia;
    _dataNascitaController.text =
        '${utente.dataNascita.day.toString().padLeft(2, '0')}/'
        '${utente.dataNascita.month.toString().padLeft(2, '0')}/'
        '${utente.dataNascita.year}';
    setState(() {
      _inModifica = false;
    });
  }

  Widget _campo({
    required String etichetta,
    required TextEditingController controller,
    required IconData icona,
    String? Function(String?)? validatore,
    TextInputType? tastiera,
    bool oscuraTesto = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: controller,
        readOnly: !_inModifica,
        obscureText: oscuraTesto,
        keyboardType: tastiera,
        validator: validatore,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          labelText: etichetta,
          prefixIcon: Icon(icona),
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 600,
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),

            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFF913535),
                        child: Icon(Icons.person_outline, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'I miei dati',
                          style: GoogleFonts.raleway(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        tooltip: 'Chiudi',
                        onPressed: _inSalvataggio
                            ? null
                            : () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _campo(
                    etichetta: 'Nome',
                    controller: _nomeController,
                    icona: Icons.badge_outlined,
                    validatore: (value) =>
                        _inModifica && (value == null || value.trim().isEmpty)
                        ? 'Inserisci il nome'
                        : null,
                  ),
                  _campo(
                    etichetta: 'Cognome',
                    controller: _cognomeController,
                    icona: Icons.badge_outlined,
                    validatore: (value) =>
                        _inModifica && (value == null || value.trim().isEmpty)
                        ? 'Inserisci il cognome'
                        : null,
                  ),
                  _campo(
                    etichetta: 'Email',
                    controller: _emailController,
                    icona: Icons.email_outlined,
                    tastiera: TextInputType.emailAddress,
                    validatore: (value) =>
                        _inModifica && (value == null || !value.contains('@'))
                        ? 'Inserisci un indirizzo email valido'
                        : null,
                  ),
                  _campo(
                    etichetta: 'Password',
                    controller: _passwordController,
                    icona: Icons.lock_outline,
                    oscuraTesto: true,
                    validatore: (value) =>
                        _inModifica && (value == null || value.length < 6)
                        ? 'La password deve contenere almeno 6 caratteri'
                        : null,
                  ),
                  _campo(
                    etichetta: 'Indirizzo',
                    controller: _indirizzoController,
                    icona: Icons.home_outlined,
                    validatore: (value) =>
                        _inModifica && (value == null || value.trim().isEmpty)
                        ? 'Inserisci l’indirizzo'
                        : null,
                  ),
                  _campo(
                    etichetta: 'Comune',
                    controller: _comuneController,
                    icona: Icons.location_city_outlined,
                    validatore: (value) =>
                        _inModifica && (value == null || value.trim().isEmpty)
                        ? 'Inserisci il comune'
                        : null,
                  ),
                  _campo(
                    etichetta: 'Provincia',
                    controller: _provinciaController,
                    icona: Icons.map_outlined,
                    validatore: (value) =>
                        _inModifica && (value == null || value.trim().isEmpty)
                        ? 'Inserisci la provincia'
                        : null,
                  ),
                  _campo(
                    etichetta: 'Data di nascita (gg/mm/aaaa)',
                    controller: _dataNascitaController,
                    icona: Icons.cake_outlined,
                    tastiera: TextInputType.datetime,
                    validatore: _validaDataNascita,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_inModifica)
                        TextButton(
                          onPressed: _inSalvataggio ? null : _annullaModifica,
                          child: const Text('Annulla'),
                        ),
                      TextButton(
                        onPressed: _inSalvataggio
                            ? null
                            : _inModifica
                            ? _salvaModifiche
                            : () => setState(() {
                                _inModifica = true;
                              }),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF913535),
                        ),
                        child: Text(
                          _inSalvataggio
                              ? 'Salvataggio...'
                              : _inModifica
                              ? 'Salva modifiche'
                              : 'Modifica dati',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
