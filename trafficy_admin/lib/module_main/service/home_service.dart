import 'package:injectable/injectable.dart';

import 'package:trafficy_admin/module_main/repository/home_repository.dart';

@injectable
class HomeService {
  final HomeRepository _homeRepository;
  HomeService(
    this._homeRepository,
  );
}
