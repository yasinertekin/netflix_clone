// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_list_screen_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyListScreenViewModel on _MyListScreenViewModelBase, Store {
  late final _$isEditingAtom =
      Atom(name: '_MyListScreenViewModelBase.isEditing', context: context);

  @override
  bool get isEditing {
    _$isEditingAtom.reportRead();
    return super.isEditing;
  }

  @override
  set isEditing(bool value) {
    _$isEditingAtom.reportWrite(value, super.isEditing, () {
      super.isEditing = value;
    });
  }

  late final _$_MyListScreenViewModelBaseActionController =
      ActionController(name: '_MyListScreenViewModelBase', context: context);

  @override
  void setIsEditing() {
    final _$actionInfo = _$_MyListScreenViewModelBaseActionController
        .startAction(name: '_MyListScreenViewModelBase.setIsEditing');
    try {
      return super.setIsEditing();
    } finally {
      _$_MyListScreenViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEditing: ${isEditing}
    ''';
  }
}
