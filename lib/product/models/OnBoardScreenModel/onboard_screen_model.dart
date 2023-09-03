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
      'İstediğiniz \nCihazda İzleyin',
      "Telefonda, tablette, bilgisayarda TV'de; ekstra ücret ödemeden tüm cihazlarda izleyin.",
    ),
    OnBoardScreenModel('onboardrocketimage', 'Netflix: Yeni \nYol Arkadaşın',
        "Uçakta, otobüste, metrobüste... \nİnternet olmasa da Netflixten \nindirdiklerini izle!"),
    OnBoardScreenModel(
      'onboardpartyimage',
      'Eğlence çok \nTaahhüt yok',
      'Bugün katılın, istediğiniz zaman \niptal edin.',
    ),
  ];
}
