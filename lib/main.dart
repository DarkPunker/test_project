import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:test_project/database/boxes.dart';
import 'package:test_project/database/cliente.dart';
import 'package:test_project/database/tienda.dart';
import 'package:test_project/database/usuario.dart';
import 'package:test_project/providers/auth_provider.dart';
import 'package:test_project/providers/navigation_provider.dart';
import 'package:test_project/utils/router.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final client = StreamChatClient(
    '8tjcmh5phqyc',
    logLevel: Level.INFO,
  );

  final user = User(id: "1", name: 'raul');
  await client.connectUser(
    user,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsIm5hbWUiOiJqaG9uIiwiaWF0IjoxNTE2MjM5MDIyfQ.CyF4gIjrK8CwoDvSB3gEqEc1d-3PLnxs8K0azRHYfHI',
  );
  await Hive.initFlutter();
  Hive.registerAdapter(UsuarioAdapter());
  Hive.registerAdapter(ClienteAdapter());
  Hive.registerAdapter(TiendaAdapter());
  boxUsuario = await Hive.openBox<Usuario>('usuarioBox');
  boxcliente = await Hive.openBox<Cliente>('clienteBox');
  boxTienda = await Hive.openBox<Tienda>('tiendaeBox');
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
          create: (_) => AuthProvider(),
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
