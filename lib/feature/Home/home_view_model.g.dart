// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieViewModel on _MovieViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_MovieViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$trendMovieListAtom =
      Atom(name: '_MovieViewModelBase.trendMovieList', context: context);

  @override
  List<MoviesModel> get trendMovieList {
    _$trendMovieListAtom.reportRead();
    return super.trendMovieList;
  }

  @override
  set trendMovieList(List<MoviesModel> value) {
    _$trendMovieListAtom.reportWrite(value, super.trendMovieList, () {
      super.trendMovieList = value;
    });
  }

  late final _$tvShowListAtom =
      Atom(name: '_MovieViewModelBase.tvShowList', context: context);

  @override
  List<MoviesModel> get tvShowList {
    _$tvShowListAtom.reportRead();
    return super.tvShowList;
  }

  @override
  set tvShowList(List<MoviesModel> value) {
    _$tvShowListAtom.reportWrite(value, super.tvShowList, () {
      super.tvShowList = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_MovieViewModelBase.service', context: context);

  @override
  IMoviesService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(IMoviesService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$showMovieDetailAtom =
      Atom(name: '_MovieViewModelBase.showMovieDetail', context: context);

  @override
  bool get showMovieDetail {
    _$showMovieDetailAtom.reportRead();
    return super.showMovieDetail;
  }

  @override
  set showMovieDetail(bool value) {
    _$showMovieDetailAtom.reportWrite(value, super.showMovieDetail, () {
      super.showMovieDetail = value;
    });
  }

  late final _$fetchDatasAsyncAction =
      AsyncAction('_MovieViewModelBase.fetchDatas', context: context);

  @override
  Future<void> fetchDatas() {
    return _$fetchDatasAsyncAction.run(() => super.fetchDatas());
  }

  late final _$_MovieViewModelBaseActionController =
      ActionController(name: '_MovieViewModelBase', context: context);

  @override
  void toggleDetailType() {
    final _$actionInfo = _$_MovieViewModelBaseActionController.startAction(
        name: '_MovieViewModelBase.toggleDetailType');
    try {
      return super.toggleDetailType();
    } finally {
      _$_MovieViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLoading() {
    final _$actionInfo = _$_MovieViewModelBaseActionController.startAction(
        name: '_MovieViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_MovieViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
trendMovieList: ${trendMovieList},
tvShowList: ${tvShowList},
service: ${service},
showMovieDetail: ${showMovieDetail}
    ''';
  }
}
