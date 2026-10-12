import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project/database/database.dart';
import 'package:project/home_pages/mensa_homepage.dart';
import 'package:project/home_pages/user_homepage.dart';

import 'package:project/registrations/registration_mensa.dart';
import 'package:project/registrations/registration_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.database});

  final AppDatabase database;

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static const Color _primaryRed = Color.fromARGB(255, 203, 17, 4);

  bool _obscureText = true;
  bool _isLoading = false;

  final gradientSfondo = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOGIN
  // ============================================================

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      // ==========================================================
      // 1. LOGIN COME UTENTE CLIENTE
      // ==========================================================

      final user = await widget.database.loginUser(email, password);

      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UserHomepage(database: widget.database, utenteId: user.id),
          ),
        );

        return;
      }

      // ==========================================================
      // 2. LOGIN COME GESTORE
      // ==========================================================

      final gestore = await widget.database.loginGestore(email, password);

      if (!mounted) return;

      if (gestore != null) {
        // Recuperiamo tutte le mense appartenenti
        // a questo profilo gestore.
        final mense = await widget.database.getMenseGestore(gestore.id);

        if (!mounted) return;

        // Nessuna mensa associata al gestore.
        if (mense.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Il profilo gestore non ha nessuna mensa associata.',
              ),
              backgroundColor: Colors.orange,
            ),
          );

          return;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MensaHomepage(
              database: widget.database,
              mensaId: mense.first.id,
            ),
          ),
        );

        return;
      }

      // ==========================================================
      // 3. CREDENZIALI NON VALIDE
      // ==========================================================

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email o password non valide.'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore durante il login: $e'),
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

  // ============================================================
  // BUILD
  // ============================================================

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ==================================================
                  // LOGO & TITOLO
                  // ==================================================

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

                  const SizedBox(height: 30),

                  // ==================================================
                  // FORM LOGIN
                  // ==================================================
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 30.0,
                    ),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Effettua il Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // ==================================================
                            // EMAIL
                            // ==================================================
                            TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Inserisci la tua email';
                                }

                                if (!value.contains('@')) {
                                  return 'Inserisci un\'email valida';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                hintText: 'Inserisci la tua mail',
                                hintStyle: TextStyle(
                                  color: Colors.black.withValues(alpha: 0.3),
                                ),
                                prefixIcon: const Icon(Icons.mail),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // ==================================================
                            // PASSWORD
                            // ==================================================
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Inserisci la password';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Inserisci la tua password',
                                hintStyle: TextStyle(
                                  color: Colors.black.withValues(alpha: 0.3),
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // ==================================================
                            // LOGIN BUTTON
                            // ==================================================
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
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
                                        'Accedi',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // ==================================================
                            // REGISTRAZIONE CLIENTE
                            // ==================================================
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationUser(
                                      database: widget.database,
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: _primaryRed,
                              ),
                              child: const Text(
                                'Non hai un account? '
                                'Registrati come Cliente',
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: 5),

                            // ==================================================
                            // REGISTRAZIONE GESTORE
                            // ==================================================
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationMensa(
                                      database: widget.database,
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: _primaryRed,
                              ),
                              child: const Text(
                                'Gestisci una mensa? '
                                'Registra la tua struttura',
                                textAlign: TextAlign.center,
                              ),
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
