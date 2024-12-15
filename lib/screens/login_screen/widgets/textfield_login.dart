import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utils/responsive.dart';

class TextformFieldWidgetLogin extends StatefulWidget {
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool borderEnable;
  final double fontSize;
  final void Function(String text)? onChanged;
  final String? Function(String? text)? validator;
  final void Function()? submitt;
  final Widget? icon;
  final FocusNode? usernameFocusNode;
  final FocusNode? passwordFocusNode;
  const TextformFieldWidgetLogin(
      {super.key,
      required this.label,
      this.icon,
      this.keyboardType,
      this.obscureText = false,
      this.borderEnable = true,
      this.fontSize = 17,
      this.onChanged,
      this.validator,
      this.passwordFocusNode,
      this.usernameFocusNode,
      this.submitt});

  @override
  State<TextformFieldWidgetLogin> createState() =>
      _TextformFieldWidgetLoginState();
}

class _TextformFieldWidgetLoginState extends State<TextformFieldWidgetLogin> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget
        .obscureText; // Set this to true if you want the text to be hidden initially
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        cursorColor: const Color.fromARGB(255, 44, 44, 44),
        style: GoogleFonts.montserrat(
            color: const Color.fromARGB(241, 20, 20, 20),
            fontSize:
                responsive.isTablet ? responsive.dp(1.2) : responsive.dp(1.5),
            fontWeight: FontWeight.w500),
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        validator: widget.validator,
        focusNode: widget.label.contains("Usuario")
            ? widget.usernameFocusNode
            : widget.passwordFocusNode,
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(237, 251, 205, 1),
            errorStyle: GoogleFonts.montserrat(
                color: const Color.fromARGB(255, 228, 34, 9),
                fontSize:
                    responsive.isTablet ? responsive.dp(0.7) : responsive.dp(1),
                fontWeight: FontWeight.w500),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            labelText: widget.label,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            floatingLabelStyle: GoogleFonts.montserrat(
                color: const Color.fromRGBO(107, 115, 91, 1),
                fontSize: responsive.isTablet
                    ? responsive.dp(0.7)
                    : responsive.dp(1.5),
                fontWeight: FontWeight.w500),
            labelStyle: GoogleFonts.montserrat(
                color: const Color.fromRGBO(107, 115, 91, 1),
                fontSize: responsive.isTablet
                    ? responsive.dp(0.9)
                    : responsive.dp(1.5),
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
