import 'package:flutter/material.dart';
import 'package:movies/features/on_boarding_screen/model/on_boarding_data.dart';
import 'package:movies/features/on_boarding_screen/prestentation/widgets/page_view_item_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
final onboardingList = OnBoardingData.getOnBoardingList(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              var data = onboardingList[index];
              return PageViewItemWidget(onBoardingData: data, index: index, pageController: _pageController);
            },
            itemCount: onboardingList.length,
          )
        ]
      ),
    );
  }
}