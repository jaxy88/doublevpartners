import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldInput extends StatefulWidget {
  final String textLabel;
  final String hintText;
  final Color colorLabel;
  final Color colorPrefixIcon;
  final Color colorBorderSide;
  final IconData icon;
  final TextEditingController ctrl;
  final bool isNumeric;
  final bool isRequired;
  final bool textCapitalization;

  const FieldInput({
    super.key,
    required this.textLabel,
    required this.hintText,
    required this.colorLabel,
    required this.colorPrefixIcon,
    required this.colorBorderSide,
    required this.icon,
    required this.ctrl,
    this.isNumeric = false,
    this.isRequired = false,
    this.textCapitalization = false,
  });

  @override
  State<FieldInput> createState() => _FieldInputState();
}

class _FieldInputState extends State<FieldInput> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.ctrl,
        cursorColor: widget.colorBorderSide,
        textAlign: TextAlign.left,
        keyboardType: widget.isNumeric
            ? TextInputType.number
            : TextInputType.text,
        inputFormatters: widget.isNumeric
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        textCapitalization: widget.textCapitalization
            ? TextCapitalization.words
            : TextCapitalization.none,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
          hintText: widget.hintText,
          labelText: widget.textLabel,
          labelStyle: TextStyle(color: widget.colorLabel, fontSize: 15),
          prefixIcon: Icon(widget.icon, color: widget.colorPrefixIcon),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.colorBorderSide, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          errorText: _errorText,
        ),
        onChanged: (value) {
          if (widget.isRequired) {
            setState(() {
              _errorText = value.trim().isEmpty
                  ? 'Este campo es obligatorio'
                  : null;
            });
          }
        },
      ),
    );
  }
}
