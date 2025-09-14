import 'package:cvms_mobile/core/theme/app_strings.dart';

class TimeGreetingHelper {
  static String greeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 11) {
      return AppStrings.morning;
    } else if (hour >= 11 && hour < 13) {
      return AppStrings.noon;
    } else if (hour >= 13 && hour < 17) {
      return AppStrings.afternoon;
    } else if (hour >= 17 && hour < 21) {
      return AppStrings.evening;
    } else {
      return AppStrings.evening;
    }
  }
}
