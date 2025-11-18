import 'package:flutter/services.dart';

class HashtagTextInputFormatter implements TextInputFormatter {
  static final RegExp _splitter = RegExp(r'[,\s]+');
  static final RegExp _allowed = RegExp(r'[^\p{L}\p{N}_]+', unicode: true);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final bool endsWithSeparator =
        newValue.text.isNotEmpty && RegExp(r'[\s,]$').hasMatch(newValue.text);
    final String raw = newValue.text.replaceAll(_splitter, ' ').trimLeft();
    if (raw.isEmpty) {
      return newValue.copyWith(text: "", selection: const TextSelection.collapsed(offset: 0));
    }

    final parts = raw.split(' ').where((e) => e.isNotEmpty).toList();
    String formatted = parts
        .map((p) {
          final cleaned = p.replaceAll('#', '');
          final normalized = cleaned.replaceAll(_allowed, '');
          return normalized.isEmpty ? null : '#$normalized';
        })
        .whereType<String>()
        .join(' ');

    if (endsWithSeparator) {
      formatted = "$formatted ";
    }

    final int caret = formatted.length;
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: caret),
      composing: TextRange.empty,
    );
  }
}