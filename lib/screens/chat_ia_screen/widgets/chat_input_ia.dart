import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

class ChatInputIa extends StatefulWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double? sigmaX;
  final double? sigmaY;
  final EdgeInsetsGeometry? padding;
  final Widget? attachmentIcon;
  final Widget? sendIcon;
  final double? gap;
  final InputBorder? inputBorder;
  final bool? filled;
  final void Function(TextEditingController controller) handleMessageSend;
  const ChatInputIa({
    super.key,
    this.left = 0,
    this.right = 0,
    this.top,
    this.bottom = 0,
    this.sigmaX = 0,
    this.sigmaY = 0,
    this.padding = const EdgeInsets.all(8.0),
    this.attachmentIcon = const Icon(Icons.attachment),
    this.sendIcon = const Icon(Icons.send),
    this.gap = 8,
    this.inputBorder = const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    this.filled = true,
    required this.handleMessageSend,
  });

  @override
  State<ChatInputIa> createState() => _ChatInputIaState();
}

class _ChatInputIaState extends State<ChatInputIa> {
  final GlobalKey _inputKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        context.select((ChatTheme theme) => theme.backgroundColor);
    final inputTheme = context.select((ChatTheme theme) => theme.inputTheme);

    return Positioned(
      left: widget.left,
      right: widget.right,
      top: widget.top,
      bottom: widget.bottom,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.sigmaX ?? 0,
            sigmaY: widget.sigmaY ?? 0,
          ),
          child: Container(
            key: _inputKey,
            color: backgroundColor.withOpacity(0.8),
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Escribe una pregunta',
                        hintStyle: inputTheme.hintStyle,
                        border: widget.inputBorder,
                        filled: widget.filled,
                        fillColor: inputTheme.backgroundColor,
                        hoverColor: Colors.transparent,
                      ),
                      style: inputTheme.textStyle,
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                  SizedBox(width: widget.gap),
                  widget.sendIcon != null
                      ? IconButton(
                          icon: widget.sendIcon!,
                          color: inputTheme.hintStyle?.color,
                          onPressed: () =>
                              widget.handleMessageSend(_textController),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
