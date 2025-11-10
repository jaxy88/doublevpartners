import 'package:doublevpartners/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FieldInputBirthdate extends StatefulWidget {
  final String textLabel;
  final Color colorLabel;
  final Color colorPrefixIcon;
  final Color colorBorderSide;
  final IconData icon;
  final TextEditingController ctrl;
  final bool isRequired;

  const FieldInputBirthdate({
    super.key,
    required this.textLabel,
    required this.colorLabel,
    required this.colorPrefixIcon,
    required this.colorBorderSide,
    required this.icon,
    required this.ctrl,
    this.isRequired = false,
  });

  @override
  State<FieldInputBirthdate> createState() => _FieldInputDateBirdState();
}

class _FieldInputDateBirdState extends State<FieldInputBirthdate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        readOnly: true,
        controller: widget.ctrl,
        textAlign: TextAlign.left,
        validator: (value) {
          if (widget.isRequired && (value == null || value.trim().isEmpty)) {
            return 'El campo ${widget.textLabel.toLowerCase()} es requerido';
          }
          return null;
        },
        cursorColor: widget.colorBorderSide,
        onTap: () async {
          DateTime initialDate;
          try {
            initialDate = DateFormat("dd/MM/yyyy").parse(widget.ctrl.text);
          } catch (e) {
            initialDate = DateTime.now();
          }

          final selectedDate = await showDatePicker(
            locale: const Locale("es"),
            helpText: helpText,
            cancelText: cancelText,
            confirmText: confirmText,
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: colorPrimary,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(foregroundColor: colorPrimary),
                  ),
                ),
                child: child!,
              );
            },
          );

          if (selectedDate != null) {
            setState(() {
              widget.ctrl.text = DateFormat("dd/MM/yyyy").format(selectedDate);
            });
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
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
        ),
      ),
    );
  }
}
