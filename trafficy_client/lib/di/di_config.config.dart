// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app_write_api.dart' as _i3;
import '../main.dart' as _i41;
import '../module_auth/authoriazation_module.dart' as _i36;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i16;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i14;
import '../module_auth/service/auth_service/auth_service.dart' as _i17;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i23;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i24;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i32;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i33;
import '../module_chat/chat_module.dart' as _i40;
import '../module_chat/manager/chat/chat_manager.dart' as _i28;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i18;
import '../module_chat/service/chat/char_service.dart' as _i29;
import '../module_chat/state_manager/chat_state_manager.dart' as _i30;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i38;
import '../module_home/home_module.dart' as _i39;
import '../module_home/repository/auth/home_repository.dart' as _i19;
import '../module_home/service/home_service.dart' as _i20;
import '../module_home/state_manager/calibraion_state_manager.dart' as _i27;
import '../module_home/state_manager/home_state_manager.dart' as _i21;
import '../module_home/ui/screen/calibration_screen.dart' as _i37;
import '../module_home/ui/screen/home_screen.dart' as _i31;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_network/http_client/http_client.dart' as _i12;
import '../module_settings/settings_module.dart' as _i34;
import '../module_settings/ui/settings_page/settings_page.dart' as _i25;
import '../module_splash/splash_module.dart' as _i35;
import '../module_splash/ui/screen/block_screen.dart' as _i5;
import '../module_splash/ui/screen/splash_screen.dart' as _i26;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i10;
import '../module_theme/service/theme_service/theme_service.dart' as _i13;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i15;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i11;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i22;
import '../utils/global/global_state_manager.dart' as _i42;
import '../utils/logger/logger.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AppwriteApi>(() => _i3.AppwriteApi());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.BlockScreen>(() => _i5.BlockScreen());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
  gh.factory<_i7.LocalizationPreferencesHelper>(
      () => _i7.LocalizationPreferencesHelper());
  gh.factory<_i8.LocalizationService>(
      () => _i8.LocalizationService(get<_i7.LocalizationPreferencesHelper>()));
  gh.factory<_i9.Logger>(() => _i9.Logger());
  gh.factory<_i10.ThemePreferencesHelper>(() => _i10.ThemePreferencesHelper());
  gh.factory<_i11.UploadRepository>(() => _i11.UploadRepository());
  gh.factory<_i12.ApiClient>(() => _i12.ApiClient(get<_i9.Logger>()));
  gh.factory<_i13.AppThemeDataService>(
      () => _i13.AppThemeDataService(get<_i10.ThemePreferencesHelper>()));
  gh.factory<_i14.AuthRepository>(
      () => _i14.AuthRepository(get<_i12.ApiClient>(), get<_i9.Logger>()));
  gh.factory<_i15.UploadManager>(
      () => _i15.UploadManager(get<_i11.UploadRepository>()));
  gh.factory<_i16.AuthManager>(
      () => _i16.AuthManager(get<_i14.AuthRepository>()));
  gh.factory<_i17.AuthService>(() =>
      _i17.AuthService(get<_i4.AuthPrefsHelper>(), get<_i16.AuthManager>()));
  gh.factory<_i18.ChatRepository>(() =>
      _i18.ChatRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i19.HomeRepository>(() => _i19.HomeRepository(
      get<_i12.ApiClient>(),
      get<_i3.AppwriteApi>(),
      get<_i9.Logger>(),
      get<_i17.AuthService>()));
  gh.factory<_i20.HomeService>(
      () => _i20.HomeService(get<_i19.HomeRepository>()));
  gh.factory<_i21.HomeStateManager>(
      () => _i21.HomeStateManager(get<_i20.HomeService>()));
  gh.factory<_i22.ImageUploadService>(
      () => _i22.ImageUploadService(get<_i15.UploadManager>()));
  gh.factory<_i23.LoginStateManager>(
      () => _i23.LoginStateManager(get<_i17.AuthService>()));
  gh.factory<_i24.RegisterStateManager>(
      () => _i24.RegisterStateManager(get<_i17.AuthService>()));
  gh.factory<_i25.SettingsScreen>(() => _i25.SettingsScreen(
      get<_i17.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i13.AppThemeDataService>()));
  gh.factory<_i26.SplashScreen>(
      () => _i26.SplashScreen(get<_i17.AuthService>()));
  gh.factory<_i27.CalibrationStateManager>(
      () => _i27.CalibrationStateManager(get<_i20.HomeService>()));
  gh.factory<_i28.ChatManager>(
      () => _i28.ChatManager(get<_i18.ChatRepository>()));
  gh.factory<_i29.ChatService>(() => _i29.ChatService(get<_i28.ChatManager>()));
  gh.factory<_i30.ChatStateManager>(
      () => _i30.ChatStateManager(get<_i29.ChatService>()));
  gh.factory<_i31.HomeScreen>(
      () => _i31.HomeScreen(get<_i21.HomeStateManager>()));
  gh.factory<_i32.LoginScreen>(
      () => _i32.LoginScreen(get<_i23.LoginStateManager>()));
  gh.factory<_i33.RegisterScreen>(
      () => _i33.RegisterScreen(get<_i24.RegisterStateManager>()));
  gh.factory<_i34.SettingsModule>(
      () => _i34.SettingsModule(get<_i25.SettingsScreen>()));
  gh.factory<_i35.SplashModule>(() =>
      _i35.SplashModule(get<_i26.SplashScreen>(), get<_i5.BlockScreen>()));
  gh.factory<_i36.AuthorizationModule>(() => _i36.AuthorizationModule(
      get<_i32.LoginScreen>(), get<_i33.RegisterScreen>()));
  gh.factory<_i37.CalibrationScreen>(
      () => _i37.CalibrationScreen(get<_i27.CalibrationStateManager>()));
  gh.factory<_i38.ChatPage>(() => _i38.ChatPage(
      get<_i30.ChatStateManager>(),
      get<_i22.ImageUploadService>(),
      get<_i17.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i39.HomeModule>(() =>
      _i39.HomeModule(get<_i37.CalibrationScreen>(), get<_i31.HomeScreen>()));
  gh.factory<_i40.ChatModule>(
      () => _i40.ChatModule(get<_i38.ChatPage>(), get<_i17.AuthService>()));
  gh.factory<_i41.MyApp>(() => _i41.MyApp(
      get<_i13.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i35.SplashModule>(),
      get<_i36.AuthorizationModule>(),
      get<_i40.ChatModule>(),
      get<_i34.SettingsModule>(),
      get<_i39.HomeModule>()));
  gh.singleton<_i42.GlobalStateManager>(_i42.GlobalStateManager());
  return get;
}
