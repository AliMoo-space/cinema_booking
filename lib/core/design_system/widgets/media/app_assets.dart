class AppAssets {
  static const _iconsPath = 'assets/icons/';
  // static const _lottiePath = 'assets/lottie/';

  //icons
  static const String appIcon = '${_iconsPath}app_icon.png';
  static const String appLogo = '${_iconsPath}app_logo.png';

  //images
}

String getImagePath(String imageName) => 'assets/images/$imageName.jpg';
