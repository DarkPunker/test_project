import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:test_project/providers/navigation_provider.dart';
import 'package:test_project/services/map_service.dart';
import 'package:test_project/utils/router.dart';

void main() async {
  final client = StreamChatClient(
    '8tjcmh5phqyc',
    logLevel: Level.INFO,
  );

  final user = User(id: "1", name: 'raul');
  await client.connectUser(
    user,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsIm5hbWUiOiJqaG9uIiwiaWF0IjoxNTE2MjM5MDIyfQ.CyF4gIjrK8CwoDvSB3gEqEc1d-3PLnxs8K0azRHYfHI',
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavigationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => MapService(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => StreamChat(
          client: client,
          child: child,
        ),
        title: 'Agro',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
