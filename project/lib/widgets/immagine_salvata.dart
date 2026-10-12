import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ============================================================
// SELEZIONE IMMAGINE
// ============================================================

/// Sceglie un'immagine da salvare nel database.
///
/// * da **telefono/tablet** apre la **galleria**;
/// * da **PC (Windows/Linux/macOS)** e da **web** apre la finestra
///   di selezione dei file del dispositivo.
///
/// Restituisce i byte dell'immagine oppure `null` se l'utente annulla.
/// L'immagine viene ridimensionata (max 1600px) e compressa per non
/// appesantire il database.
Future<Uint8List?> scegliImmagine() async {
  final picker = ImagePicker();

  final file = await picker.pickImage(
    source: ImageSource.gallery,
    maxWidth: 1600,
    maxHeight: 1600,
    imageQuality: 85,
  );

  if (file == null) {
    return null;
  }

  return file.readAsBytes();
}

// ============================================================
// IMMAGINE SALVATA NEL DATABASE
// ============================================================

/// Mostra l'immagine salvata nel database adattandola alla
/// grandezza del contenitore (icone comprese): se non c'è
/// mostra l'icona di segnaposto.
class ImmagineSalvata extends StatelessWidget {
  const ImmagineSalvata({
    super.key,
    required this.bytes,
    required this.width,
    this.height,
    this.cerchio = true,
    this.icona = Icons.image_outlined,
    this.fit = BoxFit.cover,
    this.sfondo,
    this.bordo,
    this.coloreIcona,
  });

  /// Byte dell'immagine (null se assente).
  final Uint8List? bytes;

  /// Larghezza del contenitore (come le icone che sostituisce).
  final double width;

  /// Altezza del contenitore (se assente è uguale alla larghezza).
  final double? height;

  /// Forma circolare (come le icone rotonde) oppure rettangolare.
  final bool cerchio;

  /// Icona mostrata quando non c'è un'immagine valida.
  final IconData icona;

  /// Come l'immagine si adatta al contenitore.
  final BoxFit fit;

  /// Colore di sfondo del contenitore.
  final Color? sfondo;

  /// Colore del bordo.
  final Color? bordo;

  /// Colore dell'icona di segnaposto.
  final Color? coloreIcona;

  @override
  Widget build(BuildContext context) {
    final double h = height ?? width;
    final bool haImmagine = bytes != null && bytes!.isNotEmpty;

    final double dimensioneIcona = (width.isFinite && h.isFinite)
        ? (width < h ? width : h) * 0.4
        : 36;

    final BoxDecoration decorazione = BoxDecoration(
      color: sfondo ?? Colors.grey.shade200,
      shape: cerchio ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: cerchio ? null : BorderRadius.circular(10),
      border: Border.all(color: bordo ?? Colors.grey.shade400, width: 1.5),
    );

    final Widget contenuto = haImmagine
        ? Image.memory(
            bytes!,
            fit: fit,
            width: width,
            height: h,
            // Se i byte non sono un'immagine valida si ricade
            // sull'icona di segnaposto.
            errorBuilder: (context, errore, traccia) =>
                _iconaSegnaposto(dimensioneIcona),
          )
        : _iconaSegnaposto(dimensioneIcona);

    return Container(
      width: width,
      height: h,
      decoration: decorazione,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: contenuto,
    );
  }

  Widget _iconaSegnaposto(double dimensioneIcona) =>
      Icon(icona, color: coloreIcona ?? Colors.grey.shade600, size: dimensioneIcona);
}
