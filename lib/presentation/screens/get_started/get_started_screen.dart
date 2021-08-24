import 'package:chatbot/data/models/models.dart';
import 'package:chatbot/data/services/storage/storage_service.dart';
import 'package:chatbot/presentation/screens/auth/auth_screen.dart';
import 'package:chatbot/presentation/widgets/widgets.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  int _totalLength = 3;

  int _currentPosition = 0;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _totalLength,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, int index) => _GetStartedWidget(
                    title: Strings.getStartedTitles[index],
                    description: Strings.getStartedDescriptions[index],
                    imgSrc: Strings.getOnboardingImages[index],
                  ),
                  onPageChanged: (int newPage) {
                    setState(() {
                      _currentPosition = newPage;
                    });
                  },
                ),
              ),
              YBox(20),
              _DotsIndicator(
                length: _totalLength,
                currentPosition: _currentPosition,
              ),
              YBox(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        color: lightColors.primary.withOpacity(.3),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: AppButton(
                    title: _currentPosition < _totalLength - 1
                        ? Strings.next
                        : Strings.getStartedNow,
                    textColor: lightColors.white,
                    onPressed: () {
                      const kDuration = Duration(milliseconds: 500);

                      _pageController.nextPage(
                        duration: kDuration,
                        curve: Curves.easeInOut,
                      );

                      if (_currentPosition == _totalLength - 1) {
                        StorageService().saveUserState(
                          userState: UserState(
                            hasOnboarded: true,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AuthScreen(),
                          ),
                        );
                      }
                    },
                    radius: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GetStartedWidget extends StatelessWidget {
  const _GetStartedWidget({
    Key key,
    @required this.imgSrc,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  final String imgSrc;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 350,
            child: SvgPicture.asset(
              imgSrc,
            ),
          ),
          YBox(50),
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              color: lightColors.text,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          YBox(10),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: lightColors.subText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({
    Key key,
    @required this.length,
    @required this.currentPosition,
  }) : super(key: key);

  final int length;
  final int currentPosition;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < length; i++)
          Row(
            children: [
              _dotIndicator(i == currentPosition),
              XBox(5),
            ],
          ),
      ],
    );
  }

  Widget _dotIndicator(bool isCurrentPosition) {
    return AnimatedContainer(
      height: 10,
      duration: Duration(milliseconds: 300),
      width: isCurrentPosition ? 28 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isCurrentPosition
            ? lightColors.primary
            : lightColors.black.withOpacity(.2),
      ),
    );
  }
}
