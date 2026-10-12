import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project/widgets/immagine_salvata.dart';

class MensaCard extends StatelessWidget {
  final String nomeMensa;
  final String indirizzo;
  final String citta;
  final String comune;
  final String? telefono;
  final bool aperto;
  final VoidCallback? onTap;

  /// Foto della mensa salvata nel database.
  final Uint8List? immagine;

  const MensaCard({
    super.key,
    required this.nomeMensa,
    required this.indirizzo,
    required this.citta,
    required this.comune,
    this.telefono,
    required this.aperto,
    this.onTap,
    this.immagine,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.95),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // FOTO
              ImmagineSalvata(
                bytes: immagine,
                width: 80,
                height: 80,
                cerchio: false,
                icona: Icons.add_a_photo_outlined,
                bordo: Colors.grey[400],
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOME + STATO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            nomeMensa,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: aperto
                                ? Colors.green.withOpacity(0.15)
                                : Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: aperto ? Colors.green : Colors.red,
                            ),
                          ),
                          child: Text(
                            aperto ? 'Aperto' : 'Chiuso',
                            style: TextStyle(
                              color: aperto
                                  ? Colors.green[800]
                                  : Colors.red[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // INDIRIZZO
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Color.fromARGB(255, 145, 53, 53),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '$indirizzo, $comune, $citta',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    // TELEFONO
                    if (telefono != null && telefono!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            telefono!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
