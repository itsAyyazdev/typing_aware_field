library typing_aware_field;

export 'typing_aware_field.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TypingDetector with ChangeNotifier {
  bool _isTyping = false;
  Timer? _typingTimer;
  final Duration _typingTimeout; // Duration for typing timeout

  bool get isTyping => _isTyping;

  // Constructor to accept duration dynamically
  TypingDetector({Duration typingTimeout = const Duration(milliseconds: 1000)})
    : _typingTimeout = typingTimeout;

  void onUserInput() {
    if (!_isTyping) {
      _isTyping = true;
      notifyListeners();
    }
    _resetTimer();
  }

  void _resetTimer() {
    _typingTimer?.cancel();
    _typingTimer = Timer(_typingTimeout, () {
      _isTyping = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }
}

class TypingAwareTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onTyping;
  final InputDecoration? decoration;
  final FormFieldValidator<String>? validator;
  final bool autovalidateMode;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool autocorrect;
  final bool enableSuggestions;
  final EdgeInsetsGeometry? contentPadding;
  final double? cursorWidth;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final bool expands;
  final int? maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final String? initialValue;
  final int timeoutInMilliseconds;

  const TypingAwareTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onTyping,
    this.decoration,
    this.validator,
    this.autovalidateMode = false,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.style,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    this.focusNode,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.contentPadding,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.readOnly = false,
    this.contextMenuBuilder,
    this.initialValue,
    this.timeoutInMilliseconds = 1000,
  }) : super(key: key);

  @override
  _TypingAwareTextFormFieldState createState() =>
      _TypingAwareTextFormFieldState();
}

class _TypingAwareTextFormFieldState extends State<TypingAwareTextFormField> {
  late TypingDetector _typingDetector;

  @override
  void initState() {
    super.initState();
    _typingDetector = TypingDetector(
      typingTimeout: Duration(milliseconds: widget.timeoutInMilliseconds),
    );
    _typingDetector.addListener(() {
      widget.onTyping?.call(_typingDetector.isTyping);
    });
  }

  @override
  void dispose() {
    _typingDetector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (text) {
        _typingDetector.onUserInput();
        widget.onChanged?.call(text);
      },
      decoration:
          widget.decoration ??
          InputDecoration(hintText: widget.hintText ?? 'Type here...'),
      validator: widget.validator,
      autovalidateMode:
          widget.autovalidateMode
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      enabled: widget.enabled,
      style: widget.style,
      textAlign: widget.textAlign,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      cursorWidth: widget.cursorWidth ?? 2.0,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      keyboardAppearance: widget.keyboardAppearance,
      expands: widget.expands,
      maxLength: widget.maxLength,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly,
      contextMenuBuilder: widget.contextMenuBuilder,
      initialValue: widget.initialValue,
    );
  }
}
