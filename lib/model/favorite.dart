class Favorite {
  int _movieId;
  String _title;
  String _poster;

  Favorite(this._movieId, this._title, this._poster);

  String get poster => _poster;

  set poster(String value) {
    _poster = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get movieId => _movieId;

  set movieId(int value) {
    _movieId = value;
  }
}
