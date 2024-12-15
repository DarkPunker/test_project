import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:async';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:test_project/screens/chat_ia_screen/widgets/chat_controller.dart';
import 'package:go_router/go_router.dart';

class ChatIaScreen extends StatefulWidget {
  const ChatIaScreen({super.key});

  @override
  State<ChatIaScreen> createState() => _ChatIaScreenState();
}

class _ChatIaScreenState extends State<ChatIaScreen> {
  late final GenerativeModel model;
  late final ChatSession chat;
  late final ChatController _chatController;
  final _scrollController = ScrollController();
  bool _isLoading = true;
  Message? _typingMessage;

  @override
  void initState() {
    super.initState();
    _initializeChatController();
    const apiKey = 'AIzaSyD2o7rQucTuzbNDZI3iNT1cmP-D0aFZDOA';
    model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
      generationConfig: GenerationConfig(maxOutputTokens: 100),
    );
    chat = model.startChat();
  }

  Future<Database> initializeDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDir.path, 'chat_messages.db');
    return databaseFactoryIo.openDatabase(dbPath);
  }

  Future<void> _initializeChatController() async {
    final db = await initializeDatabase();
    setState(() {
      _chatController = SembastChatController(db);
      _isLoading = false;
    });

    final existingMessages = _chatController.messages;
    for (final message in existingMessages) {
      _chatController.insert(message);
    }
  }

  void _handleMessageSend(String text) async {
    await _chatController.insert(
      TextMessage(
        id: UniqueKey().toString(),
        author: const User(id: 'me'),
        createdAt: DateTime.now().toUtc(),
        text: text,
      ),
    );
    final content = Content.text(text);
    _sendContent(content);
  }

  void _sendContent(Content content) async {
    try {
      final typingMessage = TextMessage(
        id: UniqueKey().toString(),
        author: const User(id: 'gemini'),
        createdAt: DateTime.now().toUtc(),
        text: 'Escribiendo...',
      );

      setState(() {
        _typingMessage = typingMessage;
      });

      await _chatController.insert(typingMessage);

      final response = chat.sendMessageStream(content);
      var accumulatedText = '';

      await for (final chunk in response) {
        if (chunk.text != null) {
          accumulatedText += chunk.text!;
          if (_typingMessage != null) {
            final newUpdatedMessage =
                typingMessage.copyWith(text: accumulatedText);
            await _chatController.update(_typingMessage!, newUpdatedMessage);
            setState(() {
              _typingMessage = newUpdatedMessage;
            });
          }
        }
      }

      if (_typingMessage != null) {
        await _chatController.remove(_typingMessage!);
      }

      final finalMessage = TextMessage(
        id: UniqueKey().toString(),
        author: const User(id: 'gemini'),
        createdAt: DateTime.now().toUtc(),
        text: accumulatedText,
      );

      await _chatController.insert(finalMessage);

      setState(() {
        _typingMessage = null;
      });
    } on GenerativeAIException catch (error) {
      debugPrint('Generation error $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat con IA',
          style: TextStyle(
            color: Colors.black, // Cambié el color del texto a negro
            fontWeight: FontWeight.bold,
            fontSize: 18, // Puedes ajustar el tamaño según lo desees
          ),
        ),
        backgroundColor: const Color(
            0xFFf5f5f5), // Fondo con un color claro similar al de la lista
        centerTitle: true, // Centra el título
        elevation: 0, // Quita la sombra para un diseño más limpio
        actions: [
          IconButton(
            icon: const Icon(
                Icons.info_outline), // Añadí otro botón en la esquina derecha
            onPressed: () {
              context.push('/viewer');
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Chat(
              chatController: _chatController,
              scrollController: _scrollController,
              user: const User(id: 'me'),
              builders: Builders(
                textMessageBuilder: (context, message) {
                  if (message.id == _typingMessage?.id) {
                    return const ListTile(
                      title: Text(
                        "Escribiendo...",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else if (message.author.id == 'gemini') {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.person_2_outlined,
                              color: Color.fromARGB(255, 44, 46, 47),
                            ),
                          ),
                          Flexible(
                            child: FlyerChatTextMessage(
                              message: message,
                              padding: const EdgeInsets.symmetric(vertical: 0),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return FlyerChatTextMessage(message: message);
                  }
                },
              ),
              onMessageSend: _handleMessageSend,
            ),
    );
  }
}
