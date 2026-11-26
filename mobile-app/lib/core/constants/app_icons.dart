import 'package:material_ui/material_ui.dart';
import 'package:remixicon/remixicon.dart';

/// Centralized Remix Icon mapping for the entire Hopkid Flutter app.
/// Uses Line icons for default/inactive states and Fill icons for active states.
class AppIcons {
  AppIcons._();

  // Bottom Navigation
  static const IconData homeLine = RemixIcons.home_5_line;
  static const IconData homeFill = RemixIcons.home_5_fill;
  static const IconData categoryLine = RemixIcons.apps_2_line;
  static const IconData categoryFill = RemixIcons.apps_2_fill;
  static const IconData cartLine = RemixIcons.shopping_bag_3_line;
  static const IconData cartFill = RemixIcons.shopping_bag_3_fill;
  static const IconData ordersLine = RemixIcons.file_list_3_line;
  static const IconData ordersFill = RemixIcons.file_list_3_fill;
  static const IconData profileLine = RemixIcons.user_3_line;
  static const IconData profileFill = RemixIcons.user_3_fill;

  // Brand & Decorative
  static const IconData crownFill = RemixIcons.vip_crown_2_fill;
  static const IconData crownLine = RemixIcons.vip_crown_2_line;
  static const IconData sparkleFill = RemixIcons.sparkling_2_fill;
  static const IconData starFill = RemixIcons.star_fill;

  // Navigation & Actions
  static const IconData back = RemixIcons.arrow_left_s_line;
  static const IconData chevronRight = RemixIcons.arrow_right_s_line;
  static const IconData close = RemixIcons.close_line;
  static const IconData search = RemixIcons.search_line;
  static const IconData filter = RemixIcons.equalizer_line;
  static const IconData share = RemixIcons.share_line;
  static const IconData copy = RemixIcons.file_copy_line;
  static const IconData notification = RemixIcons.notification_3_line;
  static const IconData add = RemixIcons.add_line;
  static const IconData subtract = RemixIcons.subtract_line;
  static const IconData delete = RemixIcons.delete_bin_line;

  // Wishlist
  static const IconData heartLine = RemixIcons.heart_3_line;
  static const IconData heartFill = RemixIcons.heart_3_fill;

  // Auth
  static const IconData email = RemixIcons.mail_line;
  static const IconData lock = RemixIcons.lock_line;
  static const IconData eye = RemixIcons.eye_line;
  static const IconData eyeOff = RemixIcons.eye_off_line;
  static const IconData google = RemixIcons.google_fill;
  static const IconData apple = RemixIcons.apple_fill;

  // Services & Status
  static const IconData shipping = RemixIcons.truck_line;
  static const IconData shippingFill = RemixIcons.truck_fill;
  static const IconData returns = RemixIcons.loop_left_line;
  static const IconData shield = RemixIcons.shield_check_line;
  static const IconData award = RemixIcons.award_line;
  static const IconData error = RemixIcons.error_warning_line;
  static const IconData check = RemixIcons.check_line;
  static const IconData checkCircleFill = RemixIcons.checkbox_circle_fill;
  static const IconData circleLine = RemixIcons.checkbox_blank_circle_line;
  static const IconData radioChecked = RemixIcons.radio_button_fill;
  static const IconData radioUnchecked = RemixIcons.checkbox_blank_circle_line;

  // Checkout, Offers & Account
  static const IconData location = RemixIcons.map_pin_line;
  static const IconData coupon = RemixIcons.coupon_3_line;
  static const IconData wallet = RemixIcons.wallet_3_line;
  static const IconData card = RemixIcons.bank_card_line;
  static const IconData bank = RemixIcons.bank_line;
  static const IconData rupee = RemixIcons.money_rupee_circle_line;
  static const IconData support = RemixIcons.customer_service_2_line;
  static const IconData info = RemixIcons.information_line;
  static const IconData logout = RemixIcons.logout_box_r_line;

  // Categories & Products
  static const IconData tshirt = RemixIcons.t_shirt_2_line;
  static const IconData boys = RemixIcons.t_shirt_line;
  static const IconData girls = RemixIcons.heart_3_line;
  static const IconData baby = RemixIcons.bear_smile_line;
  static const IconData toys = RemixIcons.gamepad_line;
  static const IconData ethnic = RemixIcons.sparkling_2_line;
  static const IconData accessories = RemixIcons.gift_2_line;
  static const IconData footwear = RemixIcons.footprint_line;
  static const IconData gear = RemixIcons.emotion_happy_line;

  static IconData forCategory(String key) {
    switch (key) {
      case 'boy':
      case 'boys':
        return boys;
      case 'girl':
      case 'girls':
        return girls;
      case 'baby':
        return baby;
      case 'toys':
        return toys;
      case 'ethnic':
        return ethnic;
      case 'accessories':
        return accessories;
      case 'footwear':
        return footwear;
      case 'gear':
        return gear;
      default:
        return categoryLine;
    }
  }
}
