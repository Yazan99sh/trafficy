// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app_write_api.dart' as _i3;
import '../main.dart' as _i40;
import '../module_auth/authoriazation_module.dart' as _i35;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i15;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i13;
import '../module_auth/service/auth_service/auth_service.dart' as _i16;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i22;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i23;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i31;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i32;
import '../module_chat/chat_module.dart' as _i39;
import '../module_chat/manager/chat/chat_manager.dart' as _i27;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i17;
import '../module_chat/service/chat/char_service.dart' as _i28;
import '../module_chat/state_manager/chat_state_manager.dart' as _i29;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i37;
import '../module_home/home_module.dart' as _i38;
import '../module_home/repository/auth/home_repository.dart' as _i18;
import '../module_home/service/home_service.dart' as _i19;
import '../module_home/state_manager/calibraion_state_manager.dart' as _i26;
import '../module_home/state_manager/home_state_manager.dart' as _i20;
import '../module_home/ui/screen/calibration_screen.dart' as _i36;
import '../module_home/ui/screen/home_screen.dart' as _i30;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_network/http_client/http_client.dart' as _i11;
import '../module_settings/settings_module.dart' as _i33;
import '../module_settings/ui/settings_page/settings_page.dart' as _i24;
import '../module_splash/splash_module.dart' as _i34;
import '../module_splash/ui/screen/splash_screen.dart' as _i25;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i9;
import '../module_theme/service/theme_service/theme_service.dart' as _i12;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i14;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i10;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i21;
import '../utils/global/global_state_manager.dart' as _i41;
import '../utils/logger/logger.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AppwriteApi>(() => _i3.AppwriteApi());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.ChatHiveHelper>(() => _i5.ChatHiveHelper());
  gh.factory<_i6.LocalizationPreferencesHelper>(
      () => _i6.LocalizationPreferencesHelper());
  gh.factory<_i7.LocalizationService>(
      () => _i7.LocalizationService(get<_i6.LocalizationPreferencesHelper>()));
  gh.factory<_i8.Logger>(() => _i8.Logger());
  gh.factory<_i9.ThemePreferencesHelper>(() => _i9.ThemePreferencesHelper());
  gh.factory<_i10.UploadRepository>(() => _i10.UploadRepository());
  gh.factory<_i11.ApiClient>(() => _i11.ApiClient(get<_i8.Logger>()));
  gh.factory<_i12.AppThemeDataService>(
      () => _i12.AppThemeDataService(get<_i9.ThemePreferencesHelper>()));
  gh.factory<_i13.AuthRepository>(
      () => _i13.AuthRepository(get<_i11.ApiClient>(), get<_i8.Logger>()));
  gh.factory<_i14.UploadManager>(
      () => _i14.UploadManager(get<_i10.UploadRepository>()));
  gh.factory<_i15.AuthManager>(
      () => _i15.AuthManager(get<_i13.AuthRepository>()));
  gh.factory<_i16.AuthService>(() =>
      _i16.AuthService(get<_i4.AuthPrefsHelper>(), get<_i15.AuthManager>()));
  gh.factory<_i17.ChatRepository>(() =>
      _i17.ChatRepository(get<_i11.ApiClient>(), get<_i16.AuthService>()));
  gh.factory<_i18.HomeRepository>(() => _i18.HomeRepository(
      get<_i11.ApiClient>(),
      get<_i3.AppwriteApi>(),
      get<_i8.Logger>(),
      get<_i16.AuthService>()));
  gh.factory<_i19.HomeService>(
      () => _i19.HomeService(get<_i18.HomeRepository>()));
  gh.factory<_i20.HomeStateManager>(
      () => _i20.HomeStateManager(get<_i19.HomeService>()));
  gh.factory<_i21.ImageUploadService>(
      () => _i21.ImageUploadService(get<_i14.UploadManager>()));
  gh.factory<_i22.LoginStateManager>(
      () => _i22.LoginStateManager(get<_i16.AuthService>()));
  gh.factory<_i23.RegisterStateManager>(
      () => _i23.RegisterStateManager(get<_i16.AuthService>()));
  gh.factory<_i24.SettingsScreen>(() => _i24.SettingsScreen(
      get<_i16.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i12.AppThemeDataService>()));
  gh.factory<_i25.SplashScreen>(
      () => _i25.SplashScreen(get<_i16.AuthService>()));
  gh.factory<_i26.CalibrationStateManager>(
      () => _i26.CalibrationStateManager(get<_i19.HomeService>()));
  gh.factory<_i27.ChatManager>(
      () => _i27.ChatManager(get<_i17.ChatRepository>()));
  gh.factory<_i28.ChatService>(() => _i28.ChatService(get<_i27.ChatManager>()));
  gh.factory<_i29.ChatStateManager>(
      () => _i29.ChatStateManager(get<_i28.ChatService>()));
  gh.factory<_i30.HomeScreen>(
      () => _i30.HomeScreen(get<_i20.HomeStateManager>()));
  gh.factory<_i31.LoginScreen>(
      () => _i31.LoginScreen(get<_i22.LoginStateManager>()));
  gh.factory<_i32.RegisterScreen>(
      () => _i32.RegisterScreen(get<_i23.RegisterStateManager>()));
  gh.factory<_i33.SettingsModule>(
      () => _i33.SettingsModule(get<_i24.SettingsScreen>()));
  gh.factory<_i34.SplashModule>(
      () => _i34.SplashModule(get<_i25.SplashScreen>()));
  gh.factory<_i35.AuthorizationModule>(() => _i35.AuthorizationModule(
      get<_i31.LoginScreen>(), get<_i32.RegisterScreen>()));
  gh.factory<_i36.CalibrationScreen>(
      () => _i36.CalibrationScreen(get<_i26.CalibrationStateManager>()));
  gh.factory<_i37.ChatPage>(() => _i37.ChatPage(
      get<_i29.ChatStateManager>(),
      get<_i21.ImageUploadService>(),
      get<_i16.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i38.HomeModule>(() =>
      _i38.HomeModule(get<_i36.CalibrationScreen>(), get<_i30.HomeScreen>()));
  gh.factory<_i39.ChatModule>(
      () => _i39.ChatModule(get<_i37.ChatPage>(), get<_i16.AuthService>()));
  gh.factory<_i40.MyApp>(() => _i40.MyApp(
      get<_i12.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i34.SplashModule>(),
      get<_i35.AuthorizationModule>(),
      get<_i39.ChatModule>(),
      get<_i33.SettingsModule>(),
      get<_i38.HomeModule>()));
  gh.singleton<_i41.GlobalStateManager>(_i41.GlobalStateManager());
  return get;
}
