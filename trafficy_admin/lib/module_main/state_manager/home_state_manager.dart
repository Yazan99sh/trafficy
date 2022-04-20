import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trafficy_admin/abstracts/states/state.dart';
import 'package:trafficy_admin/module_main/service/home_service.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  HomeStateManager(this._homeService);

}
