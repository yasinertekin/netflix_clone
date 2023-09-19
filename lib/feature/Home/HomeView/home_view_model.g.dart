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

  late final _$isFavoriteAtom =
      Atom(name: '_MovieViewModelBase.isFavorite', context: context);

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
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

  late final _$favoriteListAtom =
      Atom(name: '_MovieViewModelBase.favoriteList', context: context);

  @override
  List<MoviesModel> get favoriteList {
    _$favoriteListAtom.reportRead();
    return super.favoriteList;
  }

  @override
  set favoriteList(List<MoviesModel> value) {
    _$favoriteListAtom.reportWrite(value, super.favoriteList, () {
      super.favoriteList = value;
    });
  }

  late final _$appBarColorAtom =
      Atom(name: '_MovieViewModelBase.appBarColor', context: context);

  @override
  Color get appBarColor {
    _$appBarColorAtom.reportRead();
    return super.appBarColor;
  }

  @override
  set appBarColor(Color value) {
    _$appBarColorAtom.reportWrite(value, super.appBarColor, () {
      super.appBarColor = value;
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

  late final _$itemsAtom =
      Atom(name: '_MovieViewModelBase.items', context: context);

  @override
  List<MoviesModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<MoviesModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$selectedNameAtom =
      Atom(name: '_MovieViewModelBase.selectedName', context: context);

  @override
  String get selectedName {
    _$selectedNameAtom.reportRead();
    return super.selectedName;
  }

  @override
  set selectedName(String value) {
    _$selectedNameAtom.reportWrite(value, super.selectedName, () {
      super.selectedName = value;
    });
  }

  late final _$cacheManagerAtom =
      Atom(name: '_MovieViewModelBase.cacheManager', context: context);

  @override
  ICacheManager<MoviesModel> get cacheManager {
    _$cacheManagerAtom.reportRead();
    return super.cacheManager;
  }

  @override
  set cacheManager(ICacheManager<MoviesModel> value) {
    _$cacheManagerAtom.reportWrite(value, super.cacheManager, () {
      super.cacheManager = value;
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

  late final _$showMovieAtom =
      Atom(name: '_MovieViewModelBase.showMovie', context: context);

  @override
  bool get showMovie {
    _$showMovieAtom.reportRead();
    return super.showMovie;
  }

  @override
  set showMovie(bool value) {
    _$showMovieAtom.reportWrite(value, super.showMovie, () {
      super.showMovie = value;
    });
  }

  late final _$showTvShowAtom =
      Atom(name: '_MovieViewModelBase.showTvShow', context: context);

  @override
  bool get showTvShow {
    _$showTvShowAtom.reportRead();
    return super.showTvShow;
  }

  @override
  set showTvShow(bool value) {
    _$showTvShowAtom.reportWrite(value, super.showTvShow, () {
      super.showTvShow = value;
    });
  }

  late final _$isScrollingAtom =
      Atom(name: '_MovieViewModelBase.isScrolling', context: context);

  @override
  bool get isScrolling {
    _$isScrollingAtom.reportRead();
    return super.isScrolling;
  }

  @override
  set isScrolling(bool value) {
    _$isScrollingAtom.reportWrite(value, super.isScrolling, () {
      super.isScrolling = value;
    });
  }

  late final _$isHorizantalScRollingAtom =
      Atom(name: '_MovieViewModelBase.isHorizantalScRolling', context: context);

  @override
  bool get isHorizantalScRolling {
    _$isHorizantalScRollingAtom.reportRead();
    return super.isHorizantalScRolling;
  }

  @override
  set isHorizantalScRolling(bool value) {
    _$isHorizantalScRollingAtom.reportWrite(value, super.isHorizantalScRolling,
        () {
      super.isHorizantalScRolling = value;
    });
  }

  late final _$fetchDatasAsyncAction =
      AsyncAction('_MovieViewModelBase.fetchDatas', context: context);

  @override
  Future<void> fetchDatas() {
    return _$fetchDatasAsyncAction.run(() => super.fetchDatas());
  }

  late final _$addItemsAsyncAction =
      AsyncAction('_MovieViewModelBase.addItems', context: context);

  @override
  Future<void> addItems(List<MoviesModel> items) {
    return _$addItemsAsyncAction.run(() => super.addItems(items));
  }

  late final _$removeItemAsyncAction =
      AsyncAction('_MovieViewModelBase.removeItem', context: context);

  @override
  Future<void> removeItem(String key) {
    return _$removeItemAsyncAction.run(() => super.removeItem(key));
  }

  late final _$putItemAsyncAction =
      AsyncAction('_MovieViewModelBase.putItem', context: context);

  @override
  Future<void> putItem(String key, MoviesModel item) {
    return _$putItemAsyncAction.run(() => super.putItem(key, item));
  }

  late final _$putItemsAsyncAction =
      AsyncAction('_MovieViewModelBase.putItems', context: context);

  @override
  Future<void> putItems(List<MoviesModel> items) {
    return _$putItemsAsyncAction.run(() => super.putItems(items));
  }

  late final _$clearAllAsyncAction =
      AsyncAction('_MovieViewModelBase.clearAll', context: context);

  @override
  Future<void> clearAll() {
    return _$clearAllAsyncAction.run(() => super.clearAll());
  }

  late final _$changeAppBarColorAsyncAction =
      AsyncAction('_MovieViewModelBase.changeAppBarColor', context: context);

  @override
  Future<void> changeAppBarColor(Color color) {
    return _$changeAppBarColorAsyncAction
        .run(() => super.changeAppBarColor(color));
  }

  late final _$_MovieViewModelBaseActionController =
      ActionController(name: '_MovieViewModelBase', context: context);

  @override
  void setIsHorizantalScrolling(bool value) {
    final _$actionInfo = _$_MovieViewModelBaseActionController.startAction(
        name: '_MovieViewModelBase.setIsHorizantalScrolling');
    try {
      return super.setIsHorizantalScrolling(value);
    } finally {
      _$_MovieViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsScrolling(bool value) {
    final _$actionInfo = _$_MovieViewModelBaseActionController.startAction(
        name: '_MovieViewModelBase.setIsScrolling');
    try {
      return super.setIsScrolling(value);
    } finally {
      _$_MovieViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsFavorite() {
    final _$actionInfo = _$_MovieViewModelBaseActionController.startAction(
        name: '_MovieViewModelBase.setIsFavorite');
    try {
      return super.setIsFavorite();
    } finally {
      _$_MovieViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void toggleTvShow() {
    final _$actionInfo = _$_MovieViewModelBaseActionController.startAction(
        name: '_MovieViewModelBase.toggleTvShow');
    try {
      return super.toggleTvShow();
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
  List<MoviesModel> getValues() {
    final _$actionInfo = _$_MovieViewModelBaseActionController.startAction(
        name: '_MovieViewModelBase.getValues');
    try {
      return super.getValues();
    } finally {
      _$_MovieViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  MoviesModel? getItem(String key) {
    final _$actionInfo = _$_MovieViewModelBaseActionController.startAction(
        name: '_MovieViewModelBase.getItem');
    try {
      return super.getItem(key);
    } finally {
      _$_MovieViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isFavorite: ${isFavorite},
trendMovieList: ${trendMovieList},
favoriteList: ${favoriteList},
appBarColor: ${appBarColor},
tvShowList: ${tvShowList},
items: ${items},
selectedName: ${selectedName},
cacheManager: ${cacheManager},
service: ${service},
showMovie: ${showMovie},
showTvShow: ${showTvShow},
isScrolling: ${isScrolling},
isHorizantalScRolling: ${isHorizantalScRolling}
    ''';
  }
}
