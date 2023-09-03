import 'package:mobx/mobx.dart';

part 'onboard_screen_provider.g.dart';

// ignore: library_private_types_in_public_api
class OnBoardScreenProvider = _OnBoardScreenProviderBase with _$OnBoardScreenProvider;

abstract class _OnBoardScreenProviderBase with Store {
  @observable
  int selectedIndex = 0;

  @action
  void changeSelectedIndex(int index) {
    selectedIndex = index;
  }
}
