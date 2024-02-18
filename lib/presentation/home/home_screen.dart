import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();

  SideMenuController sideMenu = SideMenuController();

  late List<SideMenuItem> items;

  @override
  void initState() {
    items = [
      SideMenuItem(
        title: 'Dashboard',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.home),
        badgeContent: const Text(
          '1',
          style: TextStyle(color: Colors.white),
        ),
      ),
      SideMenuItem(
        title: 'flights',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.flight),
        badgeContent: const Text(
          '2',
          style: TextStyle(color: Colors.white),
        ),
      ),
      SideMenuItem(
        title: 'books',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.airplane_ticket_outlined),
        badgeContent: const Text(
          '3',
          style: TextStyle(color: Colors.white),
        ),
      ),
      SideMenuItem(
        title: 'Settings',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.settings),
      ),
      const SideMenuItem(
        title: 'Exit',
        onTap: null,
        icon: Icon(Icons.exit_to_app),
      ),
    ];
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            title: Image.asset('assets/images/common/logo_sample.png'),
            footer: const Text('demo'),
            onDisplayModeChanged: (mode) {
              logger.info(mode);
            },
            items: items,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                Container(
                  child: const Center(
                    child: Text('Dashboard'),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text('flights'),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text('books'),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text('Settings'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
