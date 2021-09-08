import 'package:cinemates/model/movie_response.dart';
import 'package:cinemates/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class MovieSearchListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovieSearch(String query) async {
    MovieResponse response = await _repository.getMovieSearch(query);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final movieSearchBloc = MovieSearchListBloc();