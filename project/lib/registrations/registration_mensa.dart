import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';
import 'package:project/login/login_screen.dart';

class RegistrationMensa extends StatefulWidget {
  const RegistrationMensa({super.key, required this.database});
  final AppDatabase database;

  @override
  State<RegistrationMensa> createState() {
    return _RegistrationMensaState();
  }
}

class _RegistrationMensaState extends State<RegistrationMensa> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _indirizzoController = TextEditingController();
  final _cittaController = TextEditingController();
  final _capController = TextEditingController();
  final _comuneController = TextEditingController();
  final _pIvaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  static const Color _primaryRed = Color.fromARGB(255, 203, 17, 4);

  final gradientSfondo = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  @override
  void dispose() {
    _nomeController.dispose();
    _indirizzoController.dispose();
    _cittaController.dispose();
    _comuneController.dispose();
    _capController.dispose();
    _pIvaController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Inserimento della mensa nel database Drift
      await widget.database.registerMensa(
        nomeMensa: _nomeController.text.trim(),
        indirizzo: _indirizzoController.text.trim(),
        partitaIva: _pIvaController.text.trim().isNotEmpty
            ? _pIvaController.text.trim()
            : null,
        telefono: _telefonoController.text.trim().isNotEmpty
            ? _telefonoController.text.trim()
            : null,
        email: _emailController.text.trim(),
        password: _passwordController.text,
        citta: _cittaController.text.trim(),
        comune: _comuneController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrazione mensa completata con successo!'),
          backgroundColor: Colors.green,
        ),
      );

      // Reindirizzamento al Login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(database: widget.database),
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore durante la registrazione: $e'),
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
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: gradientSfondo),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Logo & Titolo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/images/logo_app.png',
                              height: 80,
                              width: 80,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'MensApp',
                              style: GoogleFonts.raleway(
                                color: _primaryRed,
                                fontSize: 67,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Form Registrazione Mensa
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 450),
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Registrazione Mensa',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Nome Struttura / Mensa
                            TextFormField(
                              controller: _nomeController,
                              decoration: const InputDecoration(
                                labelText: 'Nome Mensa / Struttura',
                                prefixIcon: Icon(Icons.store),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Inserisci il nome della mensa';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            // Città e CAP affiancati
                            // Città
                            TextFormField(
                              controller: _cittaController,
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
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Inserisci la sigla della città';
                                }

                                if (value.trim().length != 2) {
                                  return 'Inserisci una sigla di 2 lettere';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            // Comune
                            TextFormField(
                              controller: _comuneController,
                              decoration: const InputDecoration(
                                labelText: 'Comune',
                                prefixIcon: Icon(Icons.location_city),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Inserisci il comune';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            // CAP
                            TextFormField(
                              controller: _capController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'CAP',
                                prefixIcon: Icon(Icons.markunread_mailbox),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'CAP mancante';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            // Indirizzo
                            TextFormField(
                              controller: _indirizzoController,
                              decoration: const InputDecoration(
                                labelText: 'Indirizzo',
                                prefixIcon: Icon(Icons.location_on),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Inserisci l\'indirizzo';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 12),

                            // Partita IVA
                            TextFormField(
                              controller: _pIvaController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Partita IVA',
                                prefixIcon: Icon(Icons.receipt_long),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Inserisci la Partita IVA';
                                }
                                if (value.length != 11) {
                                  return 'La Partita IVA deve contenere 11 cifre';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // Telefono
                            TextFormField(
                              controller: _telefonoController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Telefono',
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Email
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'E-mail Aziendale',
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Inserisci un\'email';
                                }
                                if (!value.contains('@')) {
                                  return 'Inserisci un\'email valida';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // Password
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Inserisci la password';
                                }
                                if (value.length < 6) {
                                  return 'Almeno 6 caratteri';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // Conferma Password
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              decoration: InputDecoration(
                                labelText: 'Conferma Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Le password non coincidono';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 25),

                            // Bottone Registra
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _primaryRed,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
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
                                        'Registra Mensa',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Ritorna al Login
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black87,
                              ),
                              child: const Text('Hai già un account? Accedi'),
                            ),
                          ],
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
    );
  }
}

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
