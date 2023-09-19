class OnBoardScreenModel {
  final String image;
  final String title;
  final String description;

  OnBoardScreenModel(this.image, this.title, this.description);
  String get imageWithPath => 'assets/images/onboardscreenimages/$image.jpg';
}

class OnBoardScreenModels {
  static final List<OnBoardScreenModel> onboardScreenItems = [
    OnBoardScreenModel(
      'onboardlaptopimage',
      'Watch on any device you want',
      "On the phone, tablet, computer, TV; Watch on all devices at no extra cost.",
    ),
    OnBoardScreenModel('onboardrocketimage', 'Netflix: Your New Companion',
        "On the plane, on the bus, on the metrobus... Watch what I downloaded from Netflix even if there is no internet!"),
    OnBoardScreenModel(
      'onboardpartyimage',
      'Lots of fun\nNo commitment',
      'Join today, cancel anytime.',
    ),
  ];
}
