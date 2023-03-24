import 'package:aurora/screens/chat/chat.dart';
import 'package:aurora/screens/health/health.dart';
import 'package:aurora/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:aurora/services/user_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _pageController = PageController(initialPage: 1);
  late List<AnimationController> animationList;
  late AnimationController _homeController;
  late AnimationController _healthController;
  late AnimationController _chatController;
  late final userData;
  int _currentIndex = 1;
  int maxCount = 3;

  /// widget list

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
    animationList[0].animateTo(0.55);
    animationList[1].forward();
    animationList[2].forward();
    userData = UserService().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Widget> bottomBarPages = [
              ChatScreen(userData: snapshot),
              MainScreen(userData: snapshot),
              HealthScreen(userData: snapshot),
            ];
            return Scaffold(
              body: PageView(
                controller: _pageController,
                onPageChanged: (newIndex) {
                  setState(() {
                    _currentIndex = newIndex;
                  });
                  animationList[newIndex].reset();
                  newIndex == 0
                      ? animationList[newIndex].animateTo(0.55)
                      : animationList[newIndex].forward();
                },
                children: List.generate(
                    bottomBarPages.length, (index) => bottomBarPages[index]),
              ),
              extendBody: true,
              bottomNavigationBar: CircleNavBar(
                activeIcons: [
                  Lottie.asset(
                    'images/blog_active.json',
                    controller: animationList[0],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Lottie.asset(
                      'images/home_active.json',
                      controller: animationList[1],
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Lottie.asset(
                    'images/activity_active.json',
                    controller: animationList[2],
                  ),
                ],
                inactiveIcons: [
                  Lottie.asset(
                    'images/blog_inactive.json',
                    controller: animationList[0],
                  ),
                  Lottie.asset(
                    'images/home_inactive.json',
                    controller: animationList[1],
                    width: 40,
                    height: 40,
                  ),
                  Lottie.asset(
                    'images/activity_inactive.json',
                    controller: animationList[2],
                    width: 200,
                    height: 200,
                  ),
                ],
                color: Colors.white,
                circleColor: Colors.white,
                height: 70,
                circleWidth: 70,
                activeIndex: _currentIndex,
                onTap: (newIndex) async {
                  await _pageController.animateToPage(
                    newIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                  animationList[newIndex].reset();
                  newIndex == 0
                      ? animationList[newIndex].animateTo(0.55)
                      : animationList[newIndex].forward();
                },
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                cornerRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
                shadowColor: Colors.orange.shade900,
                circleShadowColor: Colors.orange.shade800,
                elevation: 5,
              ),
            );
          }
        });
  }
}
