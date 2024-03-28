import 'package:animations/animations.dart';
import 'package:cydeva_application/models/bottomnav_model.dart';
import 'package:cydeva_application/screens/ChatPage/chatPage.dart';
import 'package:cydeva_application/screens/HistoryPage/historyPage.dart';
import 'package:cydeva_application/screens/HomePage/HomePageBody.dart';
import 'package:cydeva_application/common/Colors/AppColors.dart';
import 'package:cydeva_application/screens/ProfilePage/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  List<BottomNavModel> listBottomNav = [
    BottomNavModel(title: 'Home', svgPath: 'assets/icons/home.svg'),
    BottomNavModel(title: 'Chat', svgPath: 'assets/icons/chat.svg'),
    BottomNavModel(title: 'History', svgPath: 'assets/icons/history.svg'),
    BottomNavModel(title: 'Profile', svgPath: 'assets/icons/profile.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        floatingActionButton: Container(
          width: 60,
          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.primary3),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/floatingactionbutton.svg',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            height: 65,
            itemCount: listBottomNav.length,
            tabBuilder: (index, isActive) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(listBottomNav[index].svgPath,
                          width: 24,
                          height: 24,
                          color: isActive
                              ? AppColors.primary3
                              : AppColors.primaryText)),
                  Text(
                    listBottomNav[index].title,
                    style: TextStyle(
                        color: isActive
                            ? AppColors.primary3
                            : AppColors.primaryText),
                  )
                ],
              );
            },
            activeIndex: _bottomNavIndex,
            notchMargin: 8,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.smoothEdge,
            backgroundColor: AppColors.neutralWhite,
            onTap: onTapHandler),
        body: _buildBody());
  }

  void onTapHandler(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_bottomNavIndex) {
      case 0:
        return _buildPage(const HomePageBody());
      case 1:
        return _buildPage(const ChatPage());
      case 2:
        return _buildPage(const HistoryPage());
      case 3:
        return _buildPage(const ProfilePage());
      default:
        return _buildPage(const HomePageBody());
    }
  }

  Widget _buildPage(Widget page) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: page,
    );
  }
}
