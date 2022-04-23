// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app_write_api.dart' as _i3;
import '../app_write_dart_api.dart' as _i4;
import '../main.dart' as _i47;
import '../module_auth/authoriazation_module.dart' as _i41;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i18;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i16;
import '../module_auth/service/auth_service/auth_service.dart' as _i19;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i28;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i36;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i38;
import '../module_captain/captains_module.dart' as _i45;
import '../module_captain/repository/captains_repository.dart' as _i20;
import '../module_captain/sceens/captains_screen.dart' as _i42;
import '../module_captain/service/captains_service.dart' as _i21;
import '../module_captain/state_manager/captains_state_manager.dart' as _i31;
import '../module_chat/chat_module.dart' as _i46;
import '../module_chat/manager/chat/chat_manager.dart' as _i32;
import '../module_chat/presistance/chat_hive_helper.dart' as _i7;
import '../module_chat/repository/chat/chat_repository.dart' as _i22;
import '../module_chat/service/chat/char_service.dart' as _i33;
import '../module_chat/state_manager/chat_state_manager.dart' as _i34;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i43;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main/main_module.dart' as _i44;
import '../module_main/repository/home_repository.dart' as _i23;
import '../module_main/sceen/home_screen.dart' as _i35;
import '../module_main/sceen/main_screen.dart' as _i37;
import '../module_main/service/home_service.dart' as _i24;
import '../module_main/state_manager/home_state_manager.dart' as _i25;
import '../module_network/http_client/http_client.dart' as _i14;
import '../module_settings/settings_module.dart' as _i39;
import '../module_settings/ui/settings_page/settings_page.dart' as _i29;
import '../module_splash/splash_module.dart' as _i40;
import '../module_splash/ui/screen/block_screen.dart' as _i6;
import '../module_splash/ui/screen/splash_screen.dart' as _i30;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i12;
import '../module_theme/service/theme_service/theme_service.dart' as _i15;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i13;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i26;
import '../utils/global/global_state_manager.dart' as _i8;
import '../utils/logger/logger.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AppwriteApi>(() => _i3.AppwriteApi());
  gh.factory<_i4.AppwriteDartApi>(() => _i4.AppwriteDartApi());
  gh.factory<_i5.AuthPrefsHelper>(() => _i5.AuthPrefsHelper());
  gh.factory<_i6.BlockScreen>(() => _i6.BlockScreen());
  gh.factory<_i7.ChatHiveHelper>(() => _i7.ChatHiveHelper());
  gh.singleton<_i8.GlobalStateManager>(_i8.GlobalStateManager());
  gh.factory<_i9.LocalizationPreferencesHelper>(
      () => _i9.LocalizationPreferencesHelper());
  gh.factory<_i10.LocalizationService>(
      () => _i10.LocalizationService(get<_i9.LocalizationPreferencesHelper>()));
  gh.factory<_i11.Logger>(() => _i11.Logger());
  gh.factory<_i12.ThemePreferencesHelper>(() => _i12.ThemePreferencesHelper());
  gh.factory<_i13.UploadRepository>(() => _i13.UploadRepository());
  gh.factory<_i14.ApiClient>(() => _i14.ApiClient(get<_i11.Logger>()));
  gh.factory<_i15.AppThemeDataService>(
      () => _i15.AppThemeDataService(get<_i12.ThemePreferencesHelper>()));
  gh.factory<_i16.AuthRepository>(
      () => _i16.AuthRepository(get<_i14.ApiClient>(), get<_i11.Logger>()));
  gh.factory<_i17.UploadManager>(
      () => _i17.UploadManager(get<_i13.UploadRepository>()));
  gh.factory<_i18.AuthManager>(
      () => _i18.AuthManager(get<_i16.AuthRepository>()));
  gh.factory<_i19.AuthService>(() =>
      _i19.AuthService(get<_i5.AuthPrefsHelper>(), get<_i18.AuthManager>()));
  gh.factory<_i20.CaptainsRepository>(() => _i20.CaptainsRepository(
      get<_i14.ApiClient>(),
      get<_i19.AuthService>(),
      get<_i3.AppwriteApi>(),
      get<_i11.Logger>()));
  gh.factory<_i21.CaptainsService>(
      () => _i21.CaptainsService(get<_i20.CaptainsRepository>()));
  gh.factory<_i22.ChatRepository>(() =>
      _i22.ChatRepository(get<_i14.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i23.HomeRepository>(() => _i23.HomeRepository(
      get<_i14.ApiClient>(),
      get<_i19.AuthService>(),
      get<_i3.AppwriteApi>(),
      get<_i11.Logger>(),
      get<_i4.AppwriteDartApi>()));
  gh.factory<_i24.HomeService>(
      () => _i24.HomeService(get<_i23.HomeRepository>()));
  gh.factory<_i25.HomeStateManager>(
      () => _i25.HomeStateManager(get<_i24.HomeService>()));
  gh.factory<_i26.ImageUploadService>(
      () => _i26.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i27.LoginStateManager>(
      () => _i27.LoginStateManager(get<_i19.AuthService>()));
  gh.factory<_i28.RegisterStateManager>(
      () => _i28.RegisterStateManager(get<_i19.AuthService>()));
  gh.factory<_i29.SettingsScreen>(() => _i29.SettingsScreen(
      get<_i19.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i15.AppThemeDataService>()));
  gh.factory<_i30.SplashScreen>(
      () => _i30.SplashScreen(get<_i19.AuthService>()));
  gh.factory<_i31.CaptainsStateManager>(() => _i31.CaptainsStateManager(
      get<_i24.HomeService>(), get<_i21.CaptainsService>()));
  gh.factory<_i32.ChatManager>(
      () => _i32.ChatManager(get<_i22.ChatRepository>()));
  gh.factory<_i33.ChatService>(() => _i33.ChatService(get<_i32.ChatManager>()));
  gh.factory<_i34.ChatStateManager>(
      () => _i34.ChatStateManager(get<_i33.ChatService>()));
  gh.factory<_i35.HomeScreen>(
      () => _i35.HomeScreen(get<_i25.HomeStateManager>()));
  gh.factory<_i36.LoginScreen>(
      () => _i36.LoginScreen(get<_i27.LoginStateManager>()));
  gh.factory<_i37.MainScreen>(() => _i37.MainScreen(get<_i35.HomeScreen>()));
  gh.factory<_i38.RegisterScreen>(
      () => _i38.RegisterScreen(get<_i28.RegisterStateManager>()));
  gh.factory<_i39.SettingsModule>(
      () => _i39.SettingsModule(get<_i29.SettingsScreen>()));
  gh.factory<_i40.SplashModule>(() =>
      _i40.SplashModule(get<_i30.SplashScreen>(), get<_i6.BlockScreen>()));
  gh.factory<_i41.AuthorizationModule>(() => _i41.AuthorizationModule(
      get<_i36.LoginScreen>(), get<_i38.RegisterScreen>()));
  gh.factory<_i42.CaptainsScreen>(
      () => _i42.CaptainsScreen(get<_i31.CaptainsStateManager>()));
  gh.factory<_i43.ChatPage>(() => _i43.ChatPage(
      get<_i34.ChatStateManager>(),
      get<_i26.ImageUploadService>(),
      get<_i19.AuthService>(),
      get<_i7.ChatHiveHelper>()));
  gh.factory<_i44.MainModule>(
      () => _i44.MainModule(get<_i37.MainScreen>(), get<_i35.HomeScreen>()));
  gh.factory<_i45.CaptainsModule>(
      () => _i45.CaptainsModule(get<_i42.CaptainsScreen>()));
  gh.factory<_i46.ChatModule>(
      () => _i46.ChatModule(get<_i43.ChatPage>(), get<_i19.AuthService>()));
  gh.factory<_i47.MyApp>(() => _i47.MyApp(
      get<_i15.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i40.SplashModule>(),
      get<_i41.AuthorizationModule>(),
      get<_i46.ChatModule>(),
      get<_i39.SettingsModule>(),
      get<_i44.MainModule>(),
      get<_i45.CaptainsModule>()));
  return get;
}
