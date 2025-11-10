import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/common/widgets/custom_elevated_buttom.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_routes.dart';
import 'package:movies/core/app_styles.dart';
import 'package:movies/features/on_boarding_screen/model/on_boarding_data.dart';
import 'package:movies/l10n/app_localizations.dart';


class PageViewItemWidget extends StatelessWidget {

  final OnBoardingData onBoardingData;
  final PageController pageController;
  int index;
  PageViewItemWidget({
    super.key,
    required this.onBoardingData,
    required this.index,
    required this.pageController
  });
 
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(onBoardingData.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            children: [
              const Spacer(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.04,
                ),
                decoration: BoxDecoration(
                  color: index == 0 ? null : AppColors.nearBlack,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      onBoardingData.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: index == 0 ? 36.sp : 24.sp,
                        fontWeight: index == 0 ?FontWeight.w500 : FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      onBoardingData.description ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: index == 0 ? AppColors.white60Color :Colors.white, fontSize: 20.sp ,),
                    ),
                    SizedBox(
                      height: onBoardingData.description == ""
                          ? size.height * 0.001
                          : 24.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (index == 0)
                          CustomElevatedButtom(
                            onPressed: () {
                               pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            text: AppLocalizations.of(context)!.explore_now,
                            textStyle: AppStyles.semiBold20NearBlack,
                          ),

                          if (index != 0 && index != (OnBoardingData.getOnBoardingList(context).length - 1))
                          CustomElevatedButtom(
                            onPressed: () {
                               pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            text: AppLocalizations.of(context)!.next,
                            textStyle: AppStyles.semiBold20NearBlack,
                          ),

                        SizedBox(height: size.height * 0.02),

                        if (index == (OnBoardingData.getOnBoardingList(context).length - 1))
                          CustomElevatedButtom(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
                            },
                            text: AppLocalizations.of(context)!.finish,
                            textStyle: AppStyles.semiBold20NearBlack,
                          ),
                        if (index == (OnBoardingData.getOnBoardingList(context).length - 1))
                          SizedBox(height: size.height * 0.02),

                        if (index != 0 && index != 1)
                          CustomElevatedButtom(
                            backgroundColor: AppColors.transparentColor,
                            borderColor: AppColors.yellow,

                            onPressed: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            text: AppLocalizations.of(context)!.back,
                            textStyle: AppStyles.semiBold20Yellow,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
