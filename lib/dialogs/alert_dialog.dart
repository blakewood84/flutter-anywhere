import 'dart:async';

import 'package:flutter/material.dart';

typedef DialogOptions<T> = Map<String, T?> Function();

Future<T?> showAlertDialog<T>({
  required BuildContext context,
  required DialogOptions dialogOptions,
  bool? error,
  String? title,
  String? content,
}) {
  final options = dialogOptions();
  return showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          title ?? '',
          style: TextStyle(
            color: error == true ? Colors.red : Colors.black87,
          ),
        ),
        content: content != null
            ? Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              )
            : const SizedBox.shrink(),
        actions: options.entries.map((e) {
          return TextButton(
            style: TextButton.styleFrom(
              foregroundColor: error == true ? Colors.red : Colors.black87,
            ),
            child: Text(e.key),
            onPressed: () => Navigator.of(context).pop(e.value ?? false),
          );
        }).toList(),
      );
    },
  );
}
