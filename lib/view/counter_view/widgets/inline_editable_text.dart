

import 'package:flutter/material.dart';

class InlineEditableText extends StatefulWidget {
  final String initialText;
  final Function(String) onChanged;
  final TextStyle textStyle;

  const InlineEditableText({
    super.key,
    required this.initialText,
    required this.onChanged,
    required this.textStyle,
  });

  @override
  _InlineEditableTextState createState() => _InlineEditableTextState();
}

class _InlineEditableTextState extends State<InlineEditableText> {
  late TextEditingController _controller;
  bool _isEditing = false;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isEditing = false;
        });
        widget.onChanged(_controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
        _focusNode.requestFocus();
      },
      child: _isEditing
          ? TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: widget.textStyle,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onSubmitted: (value) {
          widget.onChanged(value);
          setState(() {
            _isEditing = false;
          });
        },
      )
          : Text(
        _controller.text,
        style: widget.textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}