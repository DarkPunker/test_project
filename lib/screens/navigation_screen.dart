import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/navigation_provider.dart';
import 'package:test_project/screens/chat_screen/channel_list_page.dart';
import 'package:test_project/screens/products_screen/products_screen.dart';
import 'package:test_project/widgets/map.dart';
import 'package:go_router/go_router.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationViewModel = Provider.of<NavigationViewModel>(context);
    final pages = [
      const MapWidget(),
      const ProductsScreen(),
      const ChannelListPage(),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.smart_toy),
          onPressed: () {
            context.push('/chat_ia');
          }),
      body: IndexedStack(
        index: navigationViewModel.currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationViewModel.currentIndex,
        onTap: navigationViewModel.updateIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
