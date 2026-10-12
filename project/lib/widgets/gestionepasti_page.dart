import 'package:flutter/material.dart';
import 'package:project/database/database.dart';
import 'package:project/widgets/pasto_item.dart';

class AggiungiPastoItem extends StatelessWidget {
  final VoidCallback onTap;

  const AggiungiPastoItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            splashColor: Colors.white.withOpacity(0.5),
            highlightColor: Colors.white.withOpacity(1),
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 42),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Aggiungi pasto',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class PastoItem extends StatelessWidget {
  final String nome;

  const PastoItem({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Center(
        child: Text(
          nome,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class GestionePastiPage extends StatefulWidget {
  final AppDatabase database;
  final int mensaId;

  const GestionePastiPage({
    super.key,
    required this.database,
    required this.mensaId,
  });

  @override
  State<GestionePastiPage> createState() => _GestionePastiPageState();
}

class _GestionePastiPageState extends State<GestionePastiPage> {
  String categoriaSelezionata = 'PRIMI';
  final List<String> categoriePasti = [
    'PRIMI',
    'SECONDI',
    'CONTORNI',
    'DOLCI',
    'BEVANDE',
  ];

  void apriDialog() {
    mostraDialogAggiungiPasto(
      context: context,
      database: widget.database,
      mensaId: widget.mensaId,
      categoria: categoriaSelezionata,
    );
  }

  Widget buildColonnaPannello(BuildContext context) {
    return Column(
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
        const SizedBox(height: 10),

        // Dropdown Categorie
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
              icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.red),
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

        // Griglia con lettura isolata dal DB
        Expanded(
          child: StreamBuilder<List<PastiData>>(
            stream: widget.database.watchPastiPerCategoria(
              widget.mensaId,
              categoriaSelezionata,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              final pastiSalvati = snapshot.data ?? [];

              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemCount: pastiSalvati.length + 1,
                itemBuilder: (context, index) {
                  if (index == pastiSalvati.length) {
                    return AggiungiPastoItem(onTap: apriDialog);
                  }

                  final pasto = pastiSalvati[index];
                  return PastoItem(nome: pasto.nome);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildColonnaPannello(context),
        ),
      ),
    );
  }
}
