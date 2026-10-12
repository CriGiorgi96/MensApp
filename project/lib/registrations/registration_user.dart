import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/database/database.dart';
import 'package:project/home_pages/user_homepage.dart';

class RegistrationUser extends StatefulWidget {
  const RegistrationUser({super.key, required this.database});
  final AppDatabase database;

  @override
  State<RegistrationUser> createState() {
    return _RegistrationUserState();
  }
}

class _RegistrationUserState extends State<RegistrationUser> {
  final _formKey = GlobalKey<FormState>();

  static const Color _primaryRed = Color.fromARGB(255, 203, 17, 4);

  final gradient_sfondo = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 78, 76, 76), Color.fromARGB(255, 145, 53, 53)],
  );

  final TextEditingController _dataNascitaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cognomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _indirizzoController = TextEditingController();
  final TextEditingController _comuneController = TextEditingController();
  final TextEditingController _provinciaController = TextEditingController();

  bool _passwordObscureText = true;
  bool _confermaObscuretext = true;
  bool _isLoading = false;

  final List<String> _preferenze = const [
    'Vegano',
    'Vegetariano',
    'Fruttariano',
    'Pescatariano',
    'Crudista',
  ];

  final Map<String, bool> _preferenzeSelezionate = {};

  final List<String> _allergie = const [
    'Glutine',
    'Crostacei',
    'Uova',
    'Pesce',
    'Arachidi',
    'Soia',
    'Latte',
    'Frutta a guscio',
    'Sedano',
    'Senape',
    'Sesamo',
    'Anidride solforosa',
    'Lupini',
    'Molluschi',
  ];

  final Map<String, bool> _allergieSelezionate = {};

  @override
  void initState() {
    super.initState();
    for (var pref in _preferenze) {
      _preferenzeSelezionate[pref] = false;
    }
    for (var all in _allergie) {
      _allergieSelezionate[all] = false;
    }
  }

  @override
  void dispose() {
    _dataNascitaController.dispose();
    _nomeController.dispose();
    _cognomeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _indirizzoController.dispose();
    _comuneController.dispose();
    _provinciaController.dispose();
    super.dispose();
  }

  Future<void> _registraUtente() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final List<String> allergieScelte = _allergieSelezionate.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final List<String> preferenzeScelte = _preferenzeSelezionate.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    DateTime dataNascita;
    try {
      final parti = _dataNascitaController.text.split('/');
      dataNascita = DateTime(
        int.parse(parti[2]),
        int.parse(parti[1]),
        int.parse(parti[0]),
      );
    } catch (_) {
      dataNascita = DateTime.now();
    }

    try {
      final utenteId = await widget.database.registerUser(
        nome: _nomeController.text.trim(),
        cognome: _cognomeController.text.trim(),
        indirizzo: _indirizzoController.text.trim(),
        comune: _comuneController.text.trim(),
        provincia: _provinciaController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        dataNascita: dataNascita,
        allergieSelezionate: allergieScelte,
        preferenzeSelezionate: preferenzeScelte,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrazione completata con successo!'),
          backgroundColor: Color.fromARGB(255, 145, 53, 53),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UserHomepage(database: widget.database, utenteId: utenteId),
        ),
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
      decoration: BoxDecoration(gradient: gradient_sfondo),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
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
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              // 👈 SingleChildScrollView messo all'esterno del contenitore
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Benvenuto alla registrazione come Cliente!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Per procedere con la registrazione, ti chiediamo di compilare i seguenti campi obbligatori:',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          controller: _nomeController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            hintText: 'Inserisci il tuo nome',
                            hintStyle: TextStyle(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                          ),
                          validator: (nomevalue) {
                            if (nomevalue == null || nomevalue.isEmpty) {
                              return 'Inserisci un nome valido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _cognomeController,
                          decoration: InputDecoration(
                            labelText: 'Cognome',
                            hintText: 'Inserisci il tuo cognome',
                            hintStyle: TextStyle(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                          ),
                          validator: (cognomevalue) {
                            if (cognomevalue == null || cognomevalue.isEmpty) {
                              return 'Inserisci un cognome valido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _indirizzoController,
                          decoration: InputDecoration(
                            labelText: 'Indirizzo',
                            hintText: 'Inserisci il tuo indirizzo',
                            hintStyle: TextStyle(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                          ),
                          validator: (indirizzo) {
                            if (indirizzo == null || indirizzo.isEmpty) {
                              return "Inserisci un indirizzo valido";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _comuneController,
                                decoration: InputDecoration(
                                  labelText: 'Comune',
                                  hintText: 'Inserisci il comune di residenza',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withValues(alpha: 0.3),
                                  ),
                                ),
                                validator: (comune) {
                                  if (comune == null || comune.isEmpty) {
                                    return "Inserisci un comune valido";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _provinciaController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]'),
                                  ),
                                  LengthLimitingTextInputFormatter(2),
                                  TextInputFormatter.withFunction(
                                    (oldValue, newValue) => newValue.copyWith(
                                      text: newValue.text.toUpperCase(),
                                      selection: newValue.selection,
                                    ),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Provincia',
                                ),
                                validator: (provincia) {
                                  if (provincia == null || provincia.isEmpty) {
                                    return 'Inserisci provincia';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            hintText: 'Inserisci la tua mail',
                            hintStyle: TextStyle(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                          ),
                          validator: (mailvalue) {
                            if (mailvalue == null ||
                                mailvalue.isEmpty ||
                                !mailvalue.contains('@')) {
                              return 'Inserire una mail valida';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final passwordField = TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _passwordObscureText,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Scegli la tua password',
                                hintStyle: TextStyle(
                                  color: Colors.black.withValues(alpha: 0.3),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordObscureText =
                                          !_passwordObscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _passwordObscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              validator: (passwordvalue) {
                                if (passwordvalue == null ||
                                    passwordvalue.isEmpty ||
                                    passwordvalue.length < 6) {
                                  return 'Inserisci una password valida di almeno 6 caratteri';
                                }
                                return null;
                              },
                            );

                            final confermaPasswordField = TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _confermaObscuretext,
                              decoration: InputDecoration(
                                labelText: 'Conferma password',
                                hintText: 'Reinserisci la tua password',
                                hintStyle: TextStyle(
                                  color: Colors.black.withValues(alpha: 0.3),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _confermaObscuretext =
                                          !_confermaObscuretext;
                                    });
                                  },
                                  icon: Icon(
                                    _confermaObscuretext
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              validator: (confermavalue) {
                                if (confermavalue == null ||
                                    confermavalue.isEmpty) {
                                  return 'Reinserire la password';
                                }
                                if (confermavalue != _passwordController.text) {
                                  return 'Le password non corrispondono';
                                }
                                return null;
                              },
                            );

                            if (constraints.maxWidth > 500) {
                              return Row(
                                children: [
                                  Expanded(child: passwordField),
                                  const SizedBox(width: 15),
                                  Expanded(child: confermaPasswordField),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  passwordField,
                                  const SizedBox(height: 15),
                                  confermaPasswordField,
                                ],
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _dataNascitaController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Data di nascita',
                            hintText: 'GG/MM/AAAA',
                            hintStyle: TextStyle(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          validator: (datavalue) {
                            if (datavalue == null || datavalue.isEmpty) {
                              return 'Inserire una data valida';
                            }
                            return null;
                          },
                          onTap: () async {
                            DateTime? dataSelezionata = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (dataSelezionata != null) {
                              setState(() {
                                _dataNascitaController.text =
                                    "${dataSelezionata.day.toString().padLeft(2, '0')}/${dataSelezionata.month.toString().padLeft(2, '0')}/${dataSelezionata.year}";
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 55),
                        const Text(
                          'Seleziona eventuali allergie alimentari:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 25),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _allergie.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 6,
                                crossAxisCount: 2,
                              ),
                          itemBuilder: (context, index) {
                            final allergia = _allergie[index];
                            final isChecked =
                                _allergieSelezionate[allergia] ?? false;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _allergieSelezionate[allergia] = !isChecked;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _allergieSelezionate[allergia] =
                                              value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      allergia,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 55),
                        const Text(
                          'Hai preferenze alimentari?',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 25),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 12,
                                crossAxisCount: 1,
                              ),
                          itemCount: _preferenze.length,
                          itemBuilder: (context, index) {
                            final preferenza = _preferenze[index];
                            final isChecked =
                                _preferenzeSelezionate[preferenza] ?? false;
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _preferenzeSelezionate[preferenza] =
                                      !isChecked;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _preferenzeSelezionate[preferenza] =
                                              value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      preferenza,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 40),

                        // Pulsante Registrati
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _registraUtente,
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
                                    'Registrati',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // TextButton per tornare al Login
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black87,
                            ),
                            child: const Text('Hai già un account? Accedi'),
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
      ),
    );
  }
}
