import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';
import 'package:trafficy_captain/abstracts/states/state.dart';
import 'package:trafficy_captain/di/di_config.dart';
import 'package:trafficy_captain/generated/l10n.dart';
import 'package:trafficy_captain/module_home/hive/home_hive_helper.dart';
import 'package:trafficy_captain/module_home/request/create_location_request/create_location_request.dart';
import 'package:trafficy_captain/module_home/service/home_service.dart';
import 'package:trafficy_captain/module_home/ui/screen/home_screen.dart';
import 'package:trafficy_captain/utils/helpers/custom_flushbar.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;

  final _subjectState = PublishSubject<States>();

  HomeStateManager(this._homeService);
  void updateLocation(
    HomeScreenState screenState,
    CreateLocationRequest request,
  ) {
    // check for document
    if (getIt<HomeHiveHelper>().getDocumentID() != null) {
      _homeService.updateLocation(request).then((value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: value.error ?? S.current.errorHappened)
              .show(screenState.context);
        }
      });
    } else {
      // check if there is a document online
      _homeService.checkLocation().then((value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: value.error ?? S.current.errorHappened)
              .show(screenState.context);
        } else {
          // check again
          if (getIt<HomeHiveHelper>().getDocumentID() != null) {
            updateLocation(screenState, request);
          } else {
            // create new Location
            _homeService.createLocation(request).then((value) {
              if (value.hasError) {
                CustomFlushBarHelper.createError(
                        title: S.current.warnning,
                        message: value.error ?? S.current.errorHappened)
                    .show(screenState.context);
              }
            });
          }
        }
      });
    }
  }
}
