import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class AppTheme extends GetxService {
  static final AppTheme _instance = AppTheme._();

  factory AppTheme() => _instance;

  AppTheme._();

  AppColors? colors;
  AppStyles? styles;
  bool isDarkTheme = false;

  bool get isLightTheme => !isDarkTheme;

  ///Colors should be set first!
  void setTheme({required bool isDark}) {
    isDarkTheme = isDark;
    colors = AppColors(isDarkTheme: isDarkTheme);
    styles = AppStyles(isDarkTheme: isDarkTheme);
  }
}

class AppColors {

  static const Color mainColor = Color(0xffd2d2d2);
  static const Color mainDarkThemeColor = Color(0xff303030);
  static const Color secondDarkThemeColor = Color(0xff2F5A6A);
  static const Color secondDarkDisableColor = Color(0xff6783a1);
  static const Color mainTextColor = Color(0xff2E2727);
  static const Color secondColor = Color(0xff09862C);
  static const Color secondDisableColor = Color(0xff76a981);
  static const Color hintTextColor = Color(0xffadadad);
  static const Color shadowDarkThemeColor = Color(0xff4f4f4f);
  static const Color shadowLightDarkThemeColor = Color(0xff777777);
  static const Color errorColor = Color(0xffb64949);
  static const Color whiteColor = Color(0xffffffff);
  static const Color disabledButton = Color(0xff788a73);

  final Color mainBackground;
  final Color textColors;
  final Color textGreenWhiteColors;
  final Color secondColors;
  final Color secondColorsDisable;
  final Color shadowOne;
  final Color shadowTwo;
  final Color checkBoxColor;

  AppColors({required bool isDarkTheme})
      : mainBackground = isDarkTheme ? mainDarkThemeColor : mainColor,
        secondColors = isDarkTheme ? secondDarkThemeColor : secondColor,
        secondColorsDisable = isDarkTheme ? secondDarkDisableColor : secondDisableColor,
        textGreenWhiteColors = isDarkTheme ? whiteColor : secondColor,
        checkBoxColor = isDarkTheme ? whiteColor : secondColor,
        shadowOne = isDarkTheme ? shadowDarkThemeColor : whiteColor,
        shadowTwo = isDarkTheme ? mainTextColor : hintTextColor,
        textColors = isDarkTheme ? mainColor : mainTextColor;
}

class AppStyles {

  static const regularBodyDarkText12 = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black);
  static const regularDarkText16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);
  static const regularDarkTextBold16 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
  static const regularHeading18 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black);
  static const boldHeading22 = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black);
  static const boldHeading28 = TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black);
  static const boldBigHeading30 = TextStyle(fontSize: 30, fontWeight: FontWeight.w500, );
  static const boldBigHeading = TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black);

  static const regularBodyGreyText13 = TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey);
  static const regularBodyGreyText14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey);
  static const regularGreyText16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey);
  static const regularGreyHeading18 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey);
  static const boldGreyHeading22 = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey);

  static const regularBodyWhiteText = TextStyle(fontSize: 8, fontWeight: FontWeight.w400, color: Colors.white);
  static const regularWhiteText14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
  static const regularWhiteText16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white);
  static const regularWhiteHeading18 = TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white);
  static const boldWhiteHeading = TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white);
  static const boldWhite26 = TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white);
  static const boldWhite30 = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);

  static const regularBodyMainText = TextStyle(fontSize: 8, fontWeight: FontWeight.w400, color: AppColors.mainColor);
  static const regularMainText16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondColor);
  static const regularMainHeading = TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.secondColor);
  static const boldMainHeading22 = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.mainColor);
  static const boldMainHeading24 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.mainColor);
  static const boldMainHeading28 = TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.mainColor);

  static const regularErrorText16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.errorColor);

  final TextStyle textStyle14mainColor;
  final TextStyle textStyle16mainColor;
  final TextStyle textStyle14WhiteColor;
  final TextStyle textStyle16WhiteColor;
  final TextStyle textStyle20WhiteColor;
  final TextStyle bold18;
  final TextStyle bold20;
  final TextStyle bold22;
  final TextStyle regular16;
  final TextStyle bold30;
  final TextStyle bold30second;
  final TextStyle hintStyle14;
  final TextStyle hintStyle16;
  final TextStyle grayText16;
  final TextStyle greenWhiteText16;


  AppStyles({required bool isDarkTheme}):
        textStyle14mainColor = headline1BaseStyle14.copyWith(color: isDarkTheme ? AppColors.secondDarkThemeColor : AppColors.secondColor),
        textStyle16mainColor = headline1BaseStyle16.copyWith(color: isDarkTheme ? AppColors.secondDarkThemeColor : AppColors.secondColor),
        textStyle14WhiteColor = headline1BaseStyle14.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.secondDarkThemeColor),
        textStyle16WhiteColor = whiteColor16.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.secondDarkThemeColor),
        textStyle20WhiteColor = whiteColor20.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.secondDarkThemeColor),
        greenWhiteText16 = whiteColor16.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.secondColor),
        regular16 = headline1BaseStyle16.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.mainTextColor),
        bold18 = textBold18.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.mainTextColor),
        bold20 = textBold20.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.mainTextColor),
        bold22 = textBold22.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.mainTextColor),
        bold30 = textBold30.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.mainTextColor),
        bold30second = textBold30.copyWith(color: isDarkTheme ? AppColors.whiteColor : AppColors.secondColor),
        hintStyle14 = hint14.copyWith(color: isDarkTheme ? AppColors.hintTextColor : AppColors.mainTextColor.withOpacity(0.4)),
        hintStyle16 = hint16.copyWith(color: isDarkTheme ? AppColors.hintTextColor : AppColors.mainTextColor.withOpacity(0.4)),
        grayText16 = hint16.copyWith(color: isDarkTheme ? AppColors.hintTextColor : AppColors.shadowLightDarkThemeColor);


  static const headline1BaseStyle14 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static const headline1BaseStyle16 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );
  static const whiteColor16 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static const hint16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const hint14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const textBold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const textBold20 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const textBold22 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const whiteColor20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const textBold30 = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  );


}


