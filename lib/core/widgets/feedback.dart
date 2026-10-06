import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../services/haptics.dart';

/// Pide confirmación antes de una acción. Devuelve true solo si se confirma.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Eliminar',
  bool destructive = true,
}) async {
  if (destructive) unawaited(Haptics.warning());
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
        FilledButton(
          style: destructive
              ? FilledButton.styleFrom(
                  backgroundColor: context.colors.expense,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(96, 44),
                )
              : FilledButton.styleFrom(minimumSize: const Size(96, 44)),
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Mensaje breve, opcionalmente con "Deshacer". Recibe el messenger (y no un
/// context) para poder llamarse después de cerrar una hoja o diálogo.
void showAppSnackBar(ScaffoldMessengerState messenger, String message, {VoidCallback? onUndo}) {
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 4),
        // Con acción, Flutter la dejaría fija hasta tocarla.
        persist: false,
        action: onUndo == null ? null : SnackBarAction(label: 'Deshacer', onPressed: onUndo),
      ),
    );
}
