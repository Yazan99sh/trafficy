// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i32;
import '../module_auth/authoriazation_module.dart' as _i29;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i14;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i12;
import '../module_auth/service/auth_service/auth_service.dart' as _i15;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i18;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i19;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i25;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i26;
import '../module_chat/chat_module.dart' as _i31;
import '../module_chat/manager/chat/chat_manager.dart' as _i22;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i16;
import '../module_chat/service/chat/char_service.dart' as _i23;
import '../module_chat/state_manager/chat_state_manager.dart' as _i24;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i30;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i5;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i6;
import '../module_network/http_client/http_client.dart' as _i10;
import '../module_settings/settings_module.dart' as _i27;
import '../module_settings/ui/settings_page/settings_page.dart' as _i20;
import '../module_splash/splash_module.dart' as _i28;
import '../module_splash/ui/screen/splash_screen.dart' as _i21;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i8;
import '../module_theme/service/theme_service/theme_service.dart' as _i11;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i13;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i9;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i17;
import '../utils/global/global_state_manager.dart' as _i33;
import '../utils/logger/logger.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.ChatHiveHelper>(() => _i4.ChatHiveHelper());
  gh.factory<_i5.LocalizationPreferencesHelper>(
      () => _i5.LocalizationPreferencesHelper());
  gh.factory<_i6.LocalizationService>(
      () => _i6.LocalizationService(get<_i5.LocalizationPreferencesHelper>()));
  gh.factory<_i7.Logger>(() => _i7.Logger());
  gh.factory<_i8.ThemePreferencesHelper>(() => _i8.ThemePreferencesHelper());
  gh.factory<_i9.UploadRepository>(() => _i9.UploadRepository());
  gh.factory<_i10.ApiClient>(() => _i10.ApiClient(get<_i7.Logger>()));
  gh.factory<_i11.AppThemeDataService>(
      () => _i11.AppThemeDataService(get<_i8.ThemePreferencesHelper>()));
  gh.factory<_i12.AuthRepository>(
      () => _i12.AuthRepository(get<_i10.ApiClient>(), get<_i7.Logger>()));
  gh.factory<_i13.UploadManager>(
      () => _i13.UploadManager(get<_i9.UploadRepository>()));
  gh.factory<_i14.AuthManager>(
      () => _i14.AuthManager(get<_i12.AuthRepository>()));
  gh.factory<_i15.AuthService>(() =>
      _i15.AuthService(get<_i3.AuthPrefsHelper>(), get<_i14.AuthManager>()));
  gh.factory<_i16.ChatRepository>(() =>
      _i16.ChatRepository(get<_i10.ApiClient>(), get<_i15.AuthService>()));
  gh.factory<_i17.ImageUploadService>(
      () => _i17.ImageUploadService(get<_i13.UploadManager>()));
  gh.factory<_i18.LoginStateManager>(
      () => _i18.LoginStateManager(get<_i15.AuthService>()));
  gh.factory<_i19.RegisterStateManager>(
      () => _i19.RegisterStateManager(get<_i15.AuthService>()));
  gh.factory<_i20.SettingsScreen>(() => _i20.SettingsScreen(
      get<_i15.AuthService>(),
      get<_i6.LocalizationService>(),
      get<_i11.AppThemeDataService>()));
  gh.factory<_i21.SplashScreen>(
      () => _i21.SplashScreen(get<_i15.AuthService>()));
  gh.factory<_i22.ChatManager>(
      () => _i22.ChatManager(get<_i16.ChatRepository>()));
  gh.factory<_i23.ChatService>(() => _i23.ChatService(get<_i22.ChatManager>()));
  gh.factory<_i24.ChatStateManager>(
      () => _i24.ChatStateManager(get<_i23.ChatService>()));
  gh.factory<_i25.LoginScreen>(
      () => _i25.LoginScreen(get<_i18.LoginStateManager>()));
  gh.factory<_i26.RegisterScreen>(
      () => _i26.RegisterScreen(get<_i19.RegisterStateManager>()));
  gh.factory<_i27.SettingsModule>(
      () => _i27.SettingsModule(get<_i20.SettingsScreen>()));
  gh.factory<_i28.SplashModule>(
      () => _i28.SplashModule(get<_i21.SplashScreen>()));
  gh.factory<_i29.AuthorizationModule>(() => _i29.AuthorizationModule(
      get<_i25.LoginScreen>(), get<_i26.RegisterScreen>()));
  gh.factory<_i30.ChatPage>(() => _i30.ChatPage(
      get<_i24.ChatStateManager>(),
      get<_i17.ImageUploadService>(),
      get<_i15.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i31.ChatModule>(
      () => _i31.ChatModule(get<_i30.ChatPage>(), get<_i15.AuthService>()));
  gh.factory<_i32.MyApp>(() => _i32.MyApp(
      get<_i11.AppThemeDataService>(),
      get<_i6.LocalizationService>(),
      get<_i28.SplashModule>(),
      get<_i29.AuthorizationModule>(),
      get<_i31.ChatModule>(),
      get<_i27.SettingsModule>()));
  gh.singleton<_i33.GlobalStateManager>(_i33.GlobalStateManager());
  return get;
}
