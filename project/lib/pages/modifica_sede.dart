import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';

class ModificaSedeScreen extends StatefulWidget {
  const ModificaSedeScreen({
    super.key,
    required this.database,
    required this.mensa,
  });

  final AppDatabase database;
  final MenseData mensa;

  @override
  State<ModificaSedeScreen> createState() => _ModificaSedeScreenState();
}

class _ModificaSedeScreenState extends State<ModificaSedeScreen> {
  static const Color primaryRed = Color.fromARGB(255, 203, 17, 4);

  static const LinearGradient gradientSfondo = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomeController;
  late final TextEditingController _cittaController;
  late final TextEditingController _comuneController;
  late final TextEditingController _indirizzoController;
  late final TextEditingController _telefonoController;
  late final TextEditingController _partitaIvaController;
  late final TextEditingController _emailController;

  bool _isLoading = false;

  // Email del gestore (utente registrato come mensa)
  // attualmente proprietario della sede in modifica.
  String _emailGestore = '';

  @override
  void initState() {
    super.initState();

    _nomeController = TextEditingController(text: widget.mensa.nomeMensa);

    _cittaController = TextEditingController(text: widget.mensa.citta);

    _comuneController = TextEditingController(text: widget.mensa.comune);

    _indirizzoController = TextEditingController(text: widget.mensa.indirizzo);

    _telefonoController = TextEditingController(
      text: widget.mensa.telefono ?? '',
    );

    // Dati non modificabili

    _partitaIvaController = TextEditingController(
      text: widget.mensa.partitaIva ?? '',
    );

    // L'email viene recuperata dal gestore associato
    // alla mensa.
    _emailController = TextEditingController();

    _caricaDatiGestore();
  }

  Future<void> _caricaDatiGestore() async {
    try {
      final gestore = await widget.database.getGestoreMensa(widget.mensa.id);

      if (!mounted) return;

      if (gestore != null) {
        setState(() {
          _emailGestore = gestore.email;
          _emailController.text = gestore.email;
        });
      }
    } catch (e) {
      // L'errore verrà mostrato solamente se necessario
      // durante il salvataggio.
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cittaController.dispose();
    _comuneController.dispose();
    _indirizzoController.dispose();
    _telefonoController.dispose();
    _partitaIvaController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  Future<void> _salvaModifiche() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.database.modificaMensa(
        mensaId: widget.mensa.id,
        nomeMensa: _nomeController.text.trim(),
        citta: _cittaController.text.trim().toUpperCase(),
        comune: _comuneController.text.trim(),
        indirizzo: _indirizzoController.text.trim(),
        telefono: _telefonoController.text.trim().isEmpty
            ? null
            : _telefonoController.text.trim(),
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dati della sede modificati con successo!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore durante il salvataggio: $e'),
          backgroundColor: primaryRed,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      Text(
                        'Modifica sede',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =================================================
                      // NOME SEDE
                      // =================================================
                      TextFormField(
                        controller: _nomeController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Nome Sede',
                          prefixIcon: Icon(Icons.business),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Inserisci il nome della sede';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // =================================================
                      // EMAIL
                      // =================================================
                      TextFormField(
                        controller: _emailController,
                        enabled: false,
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                        decoration: InputDecoration(
                          labelText: _emailGestore.isEmpty
                              ? 'E-mail'
                              : _emailGestore,
                          prefixIcon: const Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: const OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // =================================================
                      // PARTITA IVA
                      // =================================================
                      TextFormField(
                        controller: _partitaIvaController,
                        enabled: false,
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Partita IVA',
                          prefixIcon: const Icon(Icons.receipt_long),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: const OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // =================================================
                      // CITTÀ
                      // =================================================
                      TextFormField(
                        controller: _cittaController,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]'),
                          ),
                          LengthLimitingTextInputFormatter(2),
                          UpperCaseTextFormatter(),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Città (sigla)',
                          prefixIcon: Icon(Icons.location_city),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Inserisci la sigla della città';
                          }

                          if (value.trim().length != 2) {
                            return 'Inserisci esattamente 2 lettere';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // =================================================
                      // COMUNE
                      // =================================================
                      TextFormField(
                        controller: _comuneController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Comune',
                          prefixIcon: Icon(Icons.location_city),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Inserisci il comune';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // =================================================
                      // INDIRIZZO
                      // =================================================
                      TextFormField(
                        controller: _indirizzoController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Indirizzo',
                          prefixIcon: Icon(Icons.home),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Inserisci l\'indirizzo';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // =================================================
                      // TELEFONO
                      // =================================================
                      TextFormField(
                        controller: _telefonoController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Telefono (opzionale)',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // =================================================
                      // SALVA
                      // =================================================
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _salvaModifiche,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryRed,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: primaryRed.withValues(
                              alpha: 0.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Salva modifiche',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================
// FORMATTER MAIUSCOLO
// =========================================================

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
