import 'package:e_commerce/pages/cart/cart_history.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/presentation/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _controller;

  List pages = [
    MainFoodPage(),
    Container(
      child: Center(child: Text("Next page")),
    ),
    Container(
      child: Center(child: Text("Next next page")),
    ),
    Container(
      child: Center(child: Text("Next next next page")),
    ),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      Container(
        child: Center(child: Text("Next page")),
      ),
      CartHistory(),
      Container(
        child: Center(child: Text("Next next next page")),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: AppColors.themeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        title: ("History"),
        activeColorPrimary: AppColors.themeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart_outlined),
        title: ("Cart"),
        activeColorPrimary: AppColors.themeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_2_outlined),
        title: ("Profile"),
        activeColorPrimary: AppColors.themeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  // @override
  // Widget build(BuildContext context) {
  // return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       onTap: onTapNav,
  //       selectedItemColor: AppColors.themeColor,
  //       // selectedIconTheme: IconThemeData(fill: 1.0, color: Colors.red),
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       selectedFontSize: 0.0,
  //       unselectedFontSize: 0.0,
  //       currentIndex: _selectedIndex,
  //       unselectedItemColor: AppColors.mainTextColor,
  //       items: const <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.home_outlined),
  //             // backgroundColor: Color.fromARGB(255, 255, 238, 0),
  //             label: 'home'),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.history_rounded),
  //             // backgroundColor: Colors.yellow,
  //             label: 'history'),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.shopping_cart_outlined),
  //             // backgroundColor: Colors.blue,
  //             label: 'profile'),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.person_outline),
  //             // backgroundColor: Colors.blue,
  //             label: 'profile'),
  //       ],
  //     ));
  // }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
