import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
@singleton
@injectable
class GlobalStateManager {
  final PublishSubject _stateSubject = PublishSubject();
  Stream get stateStream => _stateSubject.stream;

  GlobalStateManager();

  void updateCaptainList() {
    _stateSubject.add(DateTime.now().toString());
  }
}
