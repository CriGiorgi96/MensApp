import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';

class NewMensaScreen extends StatefulWidget {
  const NewMensaScreen({
    super.key,
    required this.database,
    required this.mensaPrincipale,
  });

  final AppDatabase database;
  final MenseData mensaPrincipale;

  @override
  State<NewMensaScreen> createState() => _NewMensaScreenState();
}

class _NewMensaScreenState extends State<NewMensaScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _cittaController = TextEditingController();
  final _comuneController = TextEditingController();
  final _indirizzoController = TextEditingController();
  final _telefonoController = TextEditingController();

  late final TextEditingController _emailController;
  late final TextEditingController _partitaIvaController;

  bool _isLoading = false;

  static const Color primaryRed = Color.fromARGB(255, 203, 17, 4);

  static const LinearGradient gradientSfondo = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  @override
  void initState() {
    super.initState();

    // L'email viene recuperata dal gestore associato
    // alla mensa principale.
    _emailController = TextEditingController();

    _partitaIvaController = TextEditingController(
      text: widget.mensaPrincipale.partitaIva ?? '',
    );

    _caricaDatiGestore();
  }

  Future<void> _caricaDatiGestore() async {
    try {
      final gestore = await widget.database.getGestoreMensa(
        widget.mensaPrincipale.id,
      );

      if (!mounted) return;

      if (gestore != null) {
        _emailController.text = gestore.email;
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
    _emailController.dispose();
    _partitaIvaController.dispose();

    super.dispose();
  }

  // =========================================================
  // SALVA NUOVA SEDE
  // =========================================================

  Future<void> _salvaNuovaSede() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Recuperiamo il gestore proprietario della mensa principale.
      final gestore = await widget.database.getGestoreMensa(
        widget.mensaPrincipale.id,
      );

      if (gestore == null) {
        throw Exception('Gestore della mensa non trovato.');
      }

      // Creiamo solamente la nuova sede.
      //
      // NON creiamo un nuovo Gestore:
      // la nuova sede appartiene allo stesso account proprietario.
      await widget.database.inserisciNuovaSede(
        gestoreId: gestore.id,
        nomeMensa: _nomeController.text.trim(),
        citta: _cittaController.text.trim(),
        comune: _comuneController.text.trim(),
        indirizzo: _indirizzoController.text.trim(),
        telefono: _telefonoController.text.trim().isEmpty
            ? null
            : _telefonoController.text.trim(),
        partitaIva: widget.mensaPrincipale.partitaIva,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nuova sede aggiunta con successo!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore durante il salvataggio: $e'),
          backgroundColor: Colors.red,
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
                      'Registra una nuova sede',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =================================================
                    // 1. NOME SEDE
                    // =================================================
                    TextFormField(
                      controller: _nomeController,
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
                    // 2. EMAIL
                    // =================================================
                    TextFormField(
                      controller: _emailController,
                      enabled: false,
                      style: TextStyle(color: Colors.black.withOpacity(0.4)),
                      decoration: InputDecoration(
                        labelText: 'E-mail (Account proprietario)',
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
                    // 3. PARTITA IVA
                    // =================================================
                    TextFormField(
                      controller: _partitaIvaController,
                      enabled: false,
                      style: TextStyle(color: Colors.black.withOpacity(0.4)),
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
                    // 4. CITTÀ
                    // =================================================
                    TextFormField(
                      controller: _cittaController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
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
                    // 5. COMUNE
                    // =================================================
                    TextFormField(
                      controller: _comuneController,
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
                    // 6. INDIRIZZO
                    // =================================================
                    TextFormField(
                      controller: _indirizzoController,
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
                    // 7. TELEFONO
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
                        onPressed: _isLoading ? null : _salvaNuovaSede,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: primaryRed.withOpacity(0.6),
                          padding: const EdgeInsets.symmetric(vertical: 14),
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
                                'Salva Nuova Sede',
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
