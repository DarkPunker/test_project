import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/navigation_provider.dart';
import 'package:test_project/screens/chat_screen/channel_list_page.dart';
import 'package:test_project/screens/products_screen/products_screen.dart';
import 'package:test_project/widgets/map.dart';
import 'package:go_router/go_router.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late ScrollController _scrollController;
  bool _isBottomBarVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isBottomBarVisible) {
        setState(() {
          _isBottomBarVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isBottomBarVisible) {
        setState(() {
          _isBottomBarVisible = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationViewModel = Provider.of<NavigationViewModel>(context);
    final pages = [
      const MapWidget(),
      ProductsScreen(scrollController: _scrollController),
      const ChannelListPage(),
    ];

    return SafeArea(
      // Envuelve todo en un SafeArea
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Productos',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.indigo,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                context.push('/settings');
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 5, 15, 155),
          child: const Icon(
            Icons.smart_toy,
            color: Colors.white,
          ),
          onPressed: () {
            context.push('/chat_ia');
          },
        ),
        body: IndexedStack(
          index: navigationViewModel.currentIndex,
          children: pages,
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isBottomBarVisible ? 60 : 0.0,
          child: CurvedNavigationBar(
            index: navigationViewModel.currentIndex,
            onTap: navigationViewModel.updateIndex,
            items: const <Widget>[
              Icon(Icons.map, size: 30, color: Colors.white),
              Icon(Icons.person, size: 30, color: Colors.white),
              Icon(Icons.chat, size: 30, color: Colors.white),
            ],
            color: Colors.indigo, // Color del fondo de la barra
            backgroundColor: Colors.transparent, // Fondo transparente
            buttonBackgroundColor:
                Colors.blue, // Color del botón central flotante
            animationCurve: Curves.easeInOut, // Tipo de animación
            animationDuration:
                Duration(milliseconds: 300), // Duración de la animación
          ),
        ),
      ),
    );
  }
}
