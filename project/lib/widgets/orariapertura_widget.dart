import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/database/database.dart';

class OrariAperturaWidget extends StatefulWidget {
  final AppDatabase database;
  final int mensaId;

  const OrariAperturaWidget({
    super.key,
    required this.database,
    required this.mensaId,
  });

  @override
  State<OrariAperturaWidget> createState() => _OrariAperturaWidgetState();
}

class _OrariAperturaWidgetState extends State<OrariAperturaWidget> {
  static const Color rosso = Color.fromARGB(255, 145, 53, 53);

  final List<String> giorni = [
    'Lunedì',
    'Martedì',
    'Mercoledì',
    'Giovedì',
    'Venerdì',
    'Sabato',
    'Domenica',
  ];

  final Map<String, List<_Turno>> orari = {
    'Lunedì': [],
    'Martedì': [],
    'Mercoledì': [],
    'Giovedì': [],
    'Venerdì': [],
    'Sabato': [],
    'Domenica': [],
  };

  StreamSubscription<List<OrariAperturaData>>? _orariSubscription;

  @override
  void initState() {
    super.initState();

    _orariSubscription = widget.database
        .watchOrariMensa(widget.mensaId)
        .listen(_caricaOrariDalDatabase);
  }

  @override
  void dispose() {
    _orariSubscription?.cancel();
    super.dispose();
  }

  // =========================================================
  // CARICA ORARI DAL DATABASE
  // =========================================================

  void _caricaOrariDalDatabase(List<OrariAperturaData> dati) {
    final nuoviOrari = {
      'Lunedì': <_Turno>[],
      'Martedì': <_Turno>[],
      'Mercoledì': <_Turno>[],
      'Giovedì': <_Turno>[],
      'Venerdì': <_Turno>[],
      'Sabato': <_Turno>[],
      'Domenica': <_Turno>[],
    };

    for (final orario in dati) {
      if (!nuoviOrari.containsKey(orario.giorno)) {
        continue;
      }

      nuoviOrari[orario.giorno]!.add(
        _Turno(
          id: orario.id,
          apertura: _minutiToTimeOfDay(orario.aperturaMinuti),
          chiusura: _minutiToTimeOfDay(orario.chiusuraMinuti),
        ),
      );
    }

    if (!mounted) {
      return;
    }

    setState(() {
      orari
        ..clear()
        ..addAll(nuoviOrari);
    });
  }

  // =========================================================
  // CONVERSIONE MINUTI -> TIMEOFDAY
  // =========================================================

  TimeOfDay _minutiToTimeOfDay(int minuti) {
    return TimeOfDay(hour: minuti ~/ 60, minute: minuti % 60);
  }

  // =========================================================
  // CONVERSIONE TIMEOFDAY -> MINUTI
  // =========================================================

  int _timeOfDayToMinuti(TimeOfDay ora) {
    return ora.hour * 60 + ora.minute;
  }

  // =========================================================
  // SELEZIONE ORARIO
  // =========================================================

  Future<TimeOfDay?> _selezionaOra(
    BuildContext context,
    TimeOfDay iniziale,
  ) async {
    return showTimePicker(
      context: context,
      initialTime: iniziale,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  // =========================================================
  // AGGIUNGI TURNO
  // =========================================================

  Future<void> _aggiungiTurno(String giorno) async {
    if (orari[giorno]!.length >= 2) {
      return;
    }

    final apertura = await _selezionaOra(
      context,
      const TimeOfDay(hour: 8, minute: 0),
    );

    if (apertura == null || !mounted) {
      return;
    }

    final chiusura = await _selezionaOra(
      context,
      const TimeOfDay(hour: 13, minute: 0),
    );

    if (chiusura == null || !mounted) {
      return;
    }

    if (!_orarioValido(apertura, chiusura)) {
      _mostraErrore(
        'L\'orario di chiusura deve essere successivo '
        'all\'orario di apertura.',
      );
      return;
    }

    await widget.database.salvaOrario(
      mensaId: widget.mensaId,
      giorno: giorno,
      aperturaMinuti: _timeOfDayToMinuti(apertura),
      chiusuraMinuti: _timeOfDayToMinuti(chiusura),
    );
  }

  // =========================================================
  // MODIFICA TURNO
  // =========================================================

  Future<void> _modificaTurno(String giorno, int indice) async {
    final turno = orari[giorno]![indice];

    if (turno.id == null) {
      return;
    }

    final apertura = await _selezionaOra(context, turno.apertura);

    if (apertura == null || !mounted) {
      return;
    }

    final chiusura = await _selezionaOra(context, turno.chiusura);

    if (chiusura == null || !mounted) {
      return;
    }

    if (!_orarioValido(apertura, chiusura)) {
      _mostraErrore(
        'L\'orario di chiusura deve essere successivo '
        'all\'orario di apertura.',
      );
      return;
    }

    await widget.database.modificaOrario(
      id: turno.id!,
      aperturaMinuti: _timeOfDayToMinuti(apertura),
      chiusuraMinuti: _timeOfDayToMinuti(chiusura),
    );
  }

  // =========================================================
  // ELIMINA TURNO
  // =========================================================

  Future<void> _eliminaTurno(String giorno, int indice) async {
    final turno = orari[giorno]![indice];

    if (turno.id == null) {
      return;
    }

    await widget.database.eliminaOrario(turno.id!);
  }

  // =========================================================
  // CONTROLLO ORARIO
  // =========================================================

  bool _orarioValido(TimeOfDay apertura, TimeOfDay chiusura) {
    final aperturaMinuti = apertura.hour * 60 + apertura.minute;

    final chiusuraMinuti = chiusura.hour * 60 + chiusura.minute;

    return chiusuraMinuti > aperturaMinuti;
  }

  // =========================================================
  // ERRORE
  // =========================================================

  void _mostraErrore(String messaggio) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(messaggio), backgroundColor: rosso));
  }

  // =========================================================
  // FORMATTA ORARIO
  // =========================================================

  String _formattaOra(TimeOfDay ora) {
    final ore = ora.hour.toString().padLeft(2, '0');
    final minuti = ora.minute.toString().padLeft(2, '0');

    return '$ore:$minuti';
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Orari apertura:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          ...giorni.map((giorno) => _buildGiorno(giorno)),
        ],
      ),
    );
  }

  // =========================================================
  // SINGOLO GIORNO
  // =========================================================

  Widget _buildGiorno(String giorno) {
    final turni = orari[giorno]!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: rosso,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 8),

              Text(
                giorno,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          if (turni.isEmpty)
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Chiuso',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          ...List.generate(turni.length, (index) {
            final turno = turni[index];

            return Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: _buildTurno(giorno, index, turno),
            );
          }),

          if (turni.length < 2)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextButton.icon(
                onPressed: () => _aggiungiTurno(giorno),
                style: TextButton.styleFrom(
                  foregroundColor: rosso,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: const Icon(Icons.add, size: 18),
                label: Text(
                  turni.isEmpty ? 'Aggiungi orario' : 'Aggiungi turno',
                ),
              ),
            ),
        ],
      ),
    );
  }

  // =========================================================
  // SINGOLO TURNO
  // =========================================================

  Widget _buildTurno(String giorno, int indice, _Turno turno) {
    return InkWell(
      onTap: () => _modificaTurno(giorno, indice),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: rosso.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: rosso.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: rosso, size: 21),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                '${_formattaOra(turno.apertura)}'
                '  -  '
                '${_formattaOra(turno.chiusura)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            IconButton(
              tooltip: 'Modifica',
              onPressed: () {
                _modificaTurno(giorno, indice);
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 19,
                color: Colors.grey,
              ),
            ),

            IconButton(
              tooltip: 'Elimina',
              onPressed: () {
                _eliminaTurno(giorno, indice);
              },
              icon: const Icon(Icons.close, size: 20, color: rosso),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================
// MODELLO TURNO
// =========================================================

class _Turno {
  final int? id;
  final TimeOfDay apertura;
  final TimeOfDay chiusura;

  const _Turno({this.id, required this.apertura, required this.chiusura});
}
