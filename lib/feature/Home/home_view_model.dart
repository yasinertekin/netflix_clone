import 'package:mobx/mobx.dart';
import 'package:netflix_clone/feature/services/movie_service.dart';
import 'package:netflix_clone/product/models/MoviesModel/movies_model.dart';

part 'home_view_model.g.dart';

class MovieViewModel = _MovieViewModelBase with _$MovieViewModel;

abstract class _MovieViewModelBase with Store {
  @observable
  bool isLoading = true;

  @observable
  List<MoviesModel> trendMovieList = [];

  @observable
  List<MoviesModel> tvShowList = [];

  @observable
  IMoviesService service;
  _MovieViewModelBase({
    required this.service,
  }) {
    fetchDatas();
  }

  @observable
  bool showMovieDetail = false; // Varsayılan olarak film detayını göster

  @action
  void toggleDetailType() {
    showMovieDetail = !showMovieDetail; // Kullanıcı her tıklamada gösterilecek veriyi değiştirir
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  Future<void> fetchDatas() async {
    trendMovieList = await service.fetchMovie();
    tvShowList = await service.fetchTvShows();

    changeLoading();
  }
}
