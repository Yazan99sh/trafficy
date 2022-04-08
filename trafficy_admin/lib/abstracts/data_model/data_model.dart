class DataModel {
  bool _empty = false;

  String? _error;

  DataModel();

  DataModel.empty() {
    _empty = true;
  }

  DataModel.withError(this._error);

  DataModel.withData();

  bool get hasError => _error != null;

  String? get error => _error;

  bool get isEmpty => _empty;
}
