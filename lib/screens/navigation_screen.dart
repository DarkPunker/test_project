import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/providers/navigation_provider.dart';
import 'package:test_project/screens/chat_screen/channel_list_page.dart';
import 'package:test_project/screens/products_screen/products_screen.dart';
import 'package:test_project/widgets/map.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late ScrollController _scrollController;
  bool _isScrollingDown =
      false; // Para detectar si el usuario se desplaza hacia abajo

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    // Detectar si el usuario se desplaza hacia abajo o hacia arriba
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrollingDown) {
        setState(() {
          _isScrollingDown = true;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollingDown) {
        setState(() {
          _isScrollingDown = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationViewModel = Provider.of<NavigationViewModel>(context);

    final List<Widget> pages = [
      const MapWidget(),
      ProductsScreen(scrollController: _scrollController),
      const ChannelListPage(),
    ];

    return Scaffold(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 55.0),
        child: AnimatedOpacity(
          opacity: _isScrollingDown ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 5, 15, 155),
            child: const Icon(
              Icons.smart_toy,
              color: Colors.white,
            ),
            onPressed: () {
              context.push('/chat_ia');
            },
          ),
        ),
      ),
      body: PersistentTabView(
        context,
        controller: navigationViewModel.persistentNavBarController,
        screens: pages,
        hideOnScrollSettings: HideOnScrollSettings(
          scrollControllers: [_scrollController],
        ),
        confineToSafeArea: true,
        resizeToAvoidBottomInset: true,
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.map),
            title: "Mapa",
            activeColorPrimary: Colors.indigo,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            title: "Productos",
            activeColorPrimary: Colors.indigo,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.chat),
            title: "Chat",
            activeColorPrimary: Colors.indigo,
            inactiveColorPrimary: Colors.grey,
          ),
        ],
        navBarStyle: NavBarStyle.style3,
      ),
    );
  }
}
