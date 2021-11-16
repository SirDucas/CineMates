class CustomList {
  int _idList;
  String _title;
  String _description;

  CustomList(this._idList, this._title, this._description);

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get idList => _idList;

  set idList(int value) {
    _idList = value;
  }
}