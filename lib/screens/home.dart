import 'package:aurora/screens/chat.dart';
import 'package:aurora/screens/health.dart';
import 'package:aurora/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _pageController = PageController(initialPage: 2);
  late List<AnimationController> animationList;
  late AnimationController _homeController;
  late AnimationController _healthController;
  late AnimationController _chatController;

  int maxCount = 3;

  /// widget list
  final List<Widget> bottomBarPages = [
    const ChatScreen(),
    const MainScreen(),
    const HealthScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _homeController.dispose();
    _healthController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _chatController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _homeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _healthController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationList = [];
    animationList.addAll([_chatController, _homeController, _healthController]);
    animationList[0].animateTo(0.5);
    animationList[1].forward();
    animationList[2].forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        pageController: _pageController,
        color: Colors.white,
        showLabel: false,
        notchColor: Colors.white,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Lottie.asset(
              'images/blog_inactive.json',
              controller: animationList[0],
            ),
            activeItem: Lottie.asset(
              'images/blog_active.json',
              controller: animationList[0],
            ),
            itemLabel: 'Chat Page',
          ),
          BottomBarItem(
            inActiveItem: Lottie.asset(
              'images/home_inactive.json',
              controller: animationList[1],
            ),
            activeItem: Lottie.asset(
              'images/home_active.json',
              controller: animationList[1],
            ),
            itemLabel: 'Home Page',
          ),
          BottomBarItem(
            inActiveItem: Lottie.asset(
              'images/activity_inactive.json',
              controller: animationList[2],
            ),
            activeItem: Lottie.asset(
              'images/activity_active.json',
              controller: animationList[2],
            ),
            itemLabel: 'Health Page',
          ),
        ],
        onTap: (index) async {
          await _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeIn,
          );
          animationList[index].reset();
          index == 0
              ? animationList[index].animateTo(0.5)
              : animationList[index].forward();
        },
      ),
    );
  }
}
