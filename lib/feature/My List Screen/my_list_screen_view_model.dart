import 'package:mobx/mobx.dart';
part 'my_list_screen_view_model.g.dart';

class MyListScreenViewModel = _MyListScreenViewModelBase with _$MyListScreenViewModel;

abstract class _MyListScreenViewModelBase with Store {
  @observable
  bool isEditing = false;

  @action
  void setIsEditing() {
    isEditing = !isEditing;
  }
}
