import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:test_project/database/boxes.dart';
import 'package:test_project/database/categoria.dart';
import 'package:test_project/database/cliente.dart';
import 'package:test_project/database/ordencompra.dart';
import 'package:test_project/database/producto.dart';
import 'package:test_project/database/tienda.dart';
import 'package:test_project/database/tiendaproducto.dart';
import 'package:test_project/database/usuario.dart';
import 'package:test_project/providers/auth_provider.dart';

import 'package:test_project/providers/navigation_provider.dart';
import 'package:test_project/share_preferences/preferences.dart';
import 'package:test_project/utils/router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';

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
  Hive.registerAdapter(CategoriaAdapter());
  Hive.registerAdapter(ClienteAdapter());
  Hive.registerAdapter(OrdenCompraAdapter());
  Hive.registerAdapter(ProductoAdapter());
  Hive.registerAdapter(TiendaAdapter());
  Hive.registerAdapter(TiendaProductoAdapter());
  Hive.registerAdapter(UsuarioAdapter());

  boxcliente = await Hive.openBox<Cliente>('clienteBox');
  boxTienda = await Hive.openBox<Tienda>('tiendaBox');
  boxUsuario = await Hive.openBox<Usuario>('usuarioBox');
  boxCategoria = await Hive.openBox<Categoria>('categoriaBox');
  boxOrdenCompra = await Hive.openBox<OrdenCompra>('ordenCompraBox');
  boxProducto = await Hive.openBox<Producto>('productoBox');
  boxTiendaProducto = await Hive.openBox<TiendaProducto>('tiendaProductoBox');
  await Preferences.init();
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
        localizationsDelegates: const [
          GlobalStreamChatLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('es', 'CO'),
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale('es', 'ES'), // Spanish (Spain)
          Locale('es', 'CO'), // Spanish (Colombia)
        ],
        builder: (context, child) => StreamChat(
          client: client,
          child: child,
        ),
        title: 'Agro Conecta',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff55b047)),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
