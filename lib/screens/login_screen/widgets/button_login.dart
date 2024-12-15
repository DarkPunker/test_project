import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utils/responsive.dart';

class ButtonWidgetLogin extends StatefulWidget {
  final String text;
  final Function()? onPressed;
  const ButtonWidgetLogin({super.key, this.onPressed, required this.text});

  @override
  State<ButtonWidgetLogin> createState() => _ButtonWidgetLoginState();
}

class _ButtonWidgetLoginState extends State<ButtonWidgetLogin> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.only(top: responsive.hp(2)),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Colors.white), // Color de fondo
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Radio del borde
                side: const BorderSide(width: 1.5), // Color y grosor del borde
              ),
            ),
          ),
          onPressed: widget.onPressed,
          child: Padding(
            padding: EdgeInsets.only(
                top: responsive.isTablet ? responsive.hp(1) : 2,
                bottom: responsive.isTablet ? responsive.hp(1) : 2),
            child: Text(
              widget.text,
              softWrap: false,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: responsive.isTablet
                      ? responsive.dp(1.3)
                      : responsive.dp(1.7)),
            ),
          ),
        ),
      ),
    );
  }
}
