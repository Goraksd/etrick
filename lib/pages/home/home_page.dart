import 'package:etrick/models/tab_item.dart';
import 'package:etrick/pages/home/navigation_pages/catalog_page.dart';
import 'package:etrick/pages/home/navigation_pages/home_main_page.dart';
import 'package:etrick/pages/home/navigation_pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'home_app_bar.dart';

final List<TabItem> tabBar = [
  TabItem(
    index: 0,
    title: 'Головна',
    icon: const Icon(Icons.home),
    page: const HomeMainPage(),
  ),
  TabItem(
    index: 1,
    title: 'Каталог',
    icon: const Icon(Icons.list),
    page: const CatalogPage(),
  ),
  TabItem(
    index: 2,
    title: 'Профіль',
    icon: const Icon(Icons.person),
    page: const ProfilePage(),
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    _tabController = TabController(
      length: tabBar.length,
      vsync: this,
      initialIndex: _selectedIndex.value,
    );
    _tabController.addListener(() {
      _selectedIndex.value = _tabController.index;
    });
    super.initState();
  }

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
    _tabController.index = index;
  }

  Widget _buildBottomNavigationBar() {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, value, child) {
        return BottomNavigationBar(
          items: tabBar
              .map(
                (e) => BottomNavigationBarItem(
                  icon: e.icon,
                  label: e.title,
                ),
              )
              .toList(),
          currentIndex: value,
          onTap: _onItemTapped,
        );
      },
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: TabBarView(
        // physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: tabBar.map((e) => e.page).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
