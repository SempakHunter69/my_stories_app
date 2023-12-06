import 'package:flutter/material.dart';
import 'package:my_stories_app/common/strings.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    required this.goLogin,
  });

  final Function() goLogin;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();
  final selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: illustration.length,
                controller: pageController,
                physics: (selectedIndex.value == illustration.length - 1)
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return PageLayout(
                    illustration: illustration[index],
                    title: titleOnBoard[index],
                    description: descriptionOnBoard[index],
                  );
                },
                onPageChanged: (value) {
                  selectedIndex.value = value;
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  child: Wrap(
                    spacing: 8,
                    children: List.generate(
                      illustration.length,
                      (index) {
                        return AnimatedContainer(
                          duration: const Duration(microseconds: 300),
                          height: 8,
                          width: index == value ? 24 : 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: index == value
                                ? primaryYellow
                                : primaryDark.withOpacity(0.5),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, value, child) {
                  if (value == illustration.length - 1) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.goLogin();
                        },
                        child: const Text('Get Started',
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          pageController.jumpToPage(illustration.length - 1);
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: primaryDark),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final nextIndex = selectedIndex.value + 1;
                          if (nextIndex < illustration.length) {
                            pageController.animateToPage(
                              nextIndex,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: const Text('Next',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
