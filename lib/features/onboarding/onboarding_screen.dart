import 'package:flutter/material.dart';
import 'package:news_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingController(),
      builder: (context, child) {
        final controller = context.read<OnboardingController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0XFFF5F5F5),
            actions: [
              Consumer<OnboardingController>(
                builder: (context, OnboardingController value, child) {
                  return value.isLastPage
                      ? SizedBox()
                      : TextButton.icon(
                          onPressed: () {},
                          label: const Text(
                            "Skip",
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.onPageChange(index);
                    },
                    itemCount: OnboardingModel.onboardingList.length,
                    itemBuilder: (context, index) {
                      final model = OnboardingModel.onboardingList[index];
                      return Column(
                        children: [
                          Image.asset(model.image),
                          const SizedBox(height: 24),
                          Text(
                            model.title,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0XFF4E4B66),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            model.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0XFF6E7191),
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                        ],
                      );
                    },
                  ),
                ),
                Consumer<OnboardingController>(
                  builder: (context, OnboardingController value, child) {
                    return SmoothPageIndicator(
                      controller: controller.pageController,
                      count: 3,
                      effect: WormEffect(),
                      onDotClicked: (index) {},
                    );

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(
                    //     3,
                    //     (index) => Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 3),
                    //       child: Container(
                    //         width: 16,
                    //         height: 16,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color: value.currentIndex == index
                    //               ? Color(0XFFC53030)
                    //               : Color(0XFFD3D3D3),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                ),

                SizedBox(height: 112),
                Consumer<OnboardingController>(
                  builder: (context, OnboardingController value, child) {
                    return ElevatedButton(
                      onPressed: () {
                        controller.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 52),
                      ),
                      child: Text(value.isLastPage ? 'Get Started ' : 'Next'),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
