// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app_write_api.dart' as _i3;
import '../app_write_dart_api.dart' as _i4;
import '../hive/arguments/ids_hive_helper.dart' as _i10;
import '../main.dart' as _i61;
import '../module_auth/authoriazation_module.dart' as _i50;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i20;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i21;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i31;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i32;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i44;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i47;
import '../module_captain/captains_module.dart' as _i58;
import '../module_captain/repository/captains_repository.dart' as _i22;
import '../module_captain/sceens/captain_profile_screen.dart' as _i51;
import '../module_captain/sceens/captains_screen.dart' as _i52;
import '../module_captain/service/captains_service.dart' as _i23;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i37;
import '../module_captain/state_manager/captains_state_manager.dart' as _i38;
import '../module_chat/chat_module.dart' as _i59;
import '../module_chat/manager/chat/chat_manager.dart' as _i39;
import '../module_chat/presistance/chat_hive_helper.dart' as _i7;
import '../module_chat/repository/chat/chat_repository.dart' as _i24;
import '../module_chat/service/chat/char_service.dart' as _i40;
import '../module_chat/state_manager/chat_state_manager.dart' as _i41;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i53;
import '../module_clients/clients_module.dart' as _i60;
import '../module_clients/repository/clients_repository.dart' as _i25;
import '../module_clients/sceens/clients_screen.dart' as _i54;
import '../module_clients/service/clients_service.dart' as _i26;
import '../module_clients/state_manager/clients_state_manager.dart' as _i42;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i11;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i12;
import '../module_main/main_module.dart' as _i55;
import '../module_main/repository/home_repository.dart' as _i27;
import '../module_main/sceen/home_screen.dart' as _i43;
import '../module_main/sceen/main_screen.dart' as _i45;
import '../module_main/service/home_service.dart' as _i28;
import '../module_main/state_manager/home_state_manager.dart' as _i29;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_settings/settings_module.dart' as _i48;
import '../module_settings/ui/settings_page/settings_page.dart' as _i33;
import '../module_splash/splash_module.dart' as _i49;
import '../module_splash/ui/screen/block_screen.dart' as _i6;
import '../module_splash/ui/screen/splash_screen.dart' as _i34;
import '../module_statistics/repository/statistics_repository.dart' as _i35;
import '../module_statistics/sceens/preview_screen.dart' as _i56;
import '../module_statistics/service/statisics_service.dart' as _i36;
import '../module_statistics/state_manager/preview_state_manager.dart' as _i46;
import '../module_statistics/statistics_module.dart' as _i57;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i19;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i30;
import '../utils/global/global_state_manager.dart' as _i9;
import '../utils/logger/logger.dart' as _i13;
import '../utils/navigate_system/custom_navigator.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i8.CustomNavigator>(() => _i8.CustomNavigator());
  gh.singleton<_i9.GlobalStateManager>(_i9.GlobalStateManager());
  gh.factory<_i10.IdsHiveHelper>(() => _i10.IdsHiveHelper());
  gh.factory<_i11.LocalizationPreferencesHelper>(
      () => _i11.LocalizationPreferencesHelper());
  gh.factory<_i12.LocalizationService>(() =>
      _i12.LocalizationService(get<_i11.LocalizationPreferencesHelper>()));
  gh.factory<_i13.Logger>(() => _i13.Logger());
  gh.factory<_i14.ThemePreferencesHelper>(() => _i14.ThemePreferencesHelper());
  gh.factory<_i15.UploadRepository>(() => _i15.UploadRepository());
  gh.factory<_i16.ApiClient>(() => _i16.ApiClient(get<_i13.Logger>()));
  gh.factory<_i17.AppThemeDataService>(
      () => _i17.AppThemeDataService(get<_i14.ThemePreferencesHelper>()));
  gh.factory<_i18.AuthRepository>(
      () => _i18.AuthRepository(get<_i16.ApiClient>(), get<_i13.Logger>()));
  gh.factory<_i19.UploadManager>(
      () => _i19.UploadManager(get<_i15.UploadRepository>()));
  gh.factory<_i20.AuthManager>(
      () => _i20.AuthManager(get<_i18.AuthRepository>()));
  gh.factory<_i21.AuthService>(() =>
      _i21.AuthService(get<_i5.AuthPrefsHelper>(), get<_i20.AuthManager>()));
  gh.factory<_i22.CaptainsRepository>(() => _i22.CaptainsRepository(
      get<_i16.ApiClient>(),
      get<_i21.AuthService>(),
      get<_i3.AppwriteApi>(),
      get<_i13.Logger>(),
      get<_i4.AppwriteDartApi>()));
  gh.factory<_i23.CaptainsService>(
      () => _i23.CaptainsService(get<_i22.CaptainsRepository>()));
  gh.factory<_i24.ChatRepository>(() =>
      _i24.ChatRepository(get<_i16.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i25.ClientsRepository>(() => _i25.ClientsRepository(
      get<_i16.ApiClient>(),
      get<_i21.AuthService>(),
      get<_i3.AppwriteApi>(),
      get<_i13.Logger>()));
  gh.factory<_i26.ClientsService>(
      () => _i26.ClientsService(get<_i25.ClientsRepository>()));
  gh.factory<_i27.HomeRepository>(() => _i27.HomeRepository(
      get<_i16.ApiClient>(),
      get<_i21.AuthService>(),
      get<_i3.AppwriteApi>(),
      get<_i13.Logger>(),
      get<_i4.AppwriteDartApi>()));
  gh.factory<_i28.HomeService>(
      () => _i28.HomeService(get<_i27.HomeRepository>()));
  gh.factory<_i29.HomeStateManager>(
      () => _i29.HomeStateManager(get<_i28.HomeService>()));
  gh.factory<_i30.ImageUploadService>(
      () => _i30.ImageUploadService(get<_i19.UploadManager>()));
  gh.factory<_i31.LoginStateManager>(
      () => _i31.LoginStateManager(get<_i21.AuthService>()));
  gh.factory<_i32.RegisterStateManager>(
      () => _i32.RegisterStateManager(get<_i21.AuthService>()));
  gh.factory<_i33.SettingsScreen>(() => _i33.SettingsScreen(
      get<_i21.AuthService>(),
      get<_i12.LocalizationService>(),
      get<_i17.AppThemeDataService>()));
  gh.factory<_i34.SplashScreen>(
      () => _i34.SplashScreen(get<_i21.AuthService>()));
  gh.factory<_i35.StatisticsRepository>(() => _i35.StatisticsRepository(
      get<_i16.ApiClient>(),
      get<_i3.AppwriteApi>(),
      get<_i13.Logger>(),
      get<_i21.AuthService>()));
  gh.factory<_i36.StatisticsService>(
      () => _i36.StatisticsService(get<_i35.StatisticsRepository>()));
  gh.factory<_i37.CaptainProfileStateManager>(() =>
      _i37.CaptainProfileStateManager(
          get<_i28.HomeService>(), get<_i23.CaptainsService>()));
  gh.factory<_i38.CaptainsStateManager>(() => _i38.CaptainsStateManager(
      get<_i28.HomeService>(), get<_i23.CaptainsService>()));
  gh.factory<_i39.ChatManager>(
      () => _i39.ChatManager(get<_i24.ChatRepository>()));
  gh.factory<_i40.ChatService>(() => _i40.ChatService(get<_i39.ChatManager>()));
  gh.factory<_i41.ChatStateManager>(
      () => _i41.ChatStateManager(get<_i40.ChatService>()));
  gh.factory<_i42.ClientsStateManager>(() => _i42.ClientsStateManager(
      get<_i28.HomeService>(), get<_i26.ClientsService>()));
  gh.factory<_i43.HomeScreen>(
      () => _i43.HomeScreen(get<_i29.HomeStateManager>()));
  gh.factory<_i44.LoginScreen>(
      () => _i44.LoginScreen(get<_i31.LoginStateManager>()));
  gh.factory<_i45.MainScreen>(() => _i45.MainScreen(get<_i43.HomeScreen>()));
  gh.factory<_i46.PreviewStateManager>(
      () => _i46.PreviewStateManager(get<_i36.StatisticsService>()));
  gh.factory<_i47.RegisterScreen>(
      () => _i47.RegisterScreen(get<_i32.RegisterStateManager>()));
  gh.factory<_i48.SettingsModule>(
      () => _i48.SettingsModule(get<_i33.SettingsScreen>()));
  gh.factory<_i49.SplashModule>(() =>
      _i49.SplashModule(get<_i34.SplashScreen>(), get<_i6.BlockScreen>()));
  gh.factory<_i50.AuthorizationModule>(() => _i50.AuthorizationModule(
      get<_i44.LoginScreen>(), get<_i47.RegisterScreen>()));
  gh.factory<_i51.CaptainProfileScreen>(
      () => _i51.CaptainProfileScreen(get<_i37.CaptainProfileStateManager>()));
  gh.factory<_i52.CaptainsScreen>(
      () => _i52.CaptainsScreen(get<_i38.CaptainsStateManager>()));
  gh.factory<_i53.ChatPage>(() => _i53.ChatPage(
      get<_i41.ChatStateManager>(),
      get<_i30.ImageUploadService>(),
      get<_i21.AuthService>(),
      get<_i7.ChatHiveHelper>()));
  gh.factory<_i54.ClientsScreen>(
      () => _i54.ClientsScreen(get<_i42.ClientsStateManager>()));
  gh.factory<_i55.MainModule>(
      () => _i55.MainModule(get<_i45.MainScreen>(), get<_i43.HomeScreen>()));
  gh.factory<_i56.PreviewScreen>(
      () => _i56.PreviewScreen(get<_i46.PreviewStateManager>()));
  gh.factory<_i57.StatisticsModule>(
      () => _i57.StatisticsModule(get<_i56.PreviewScreen>()));
  gh.factory<_i58.CaptainsModule>(() => _i58.CaptainsModule(
      get<_i52.CaptainsScreen>(), get<_i51.CaptainProfileScreen>()));
  gh.factory<_i59.ChatModule>(
      () => _i59.ChatModule(get<_i53.ChatPage>(), get<_i21.AuthService>()));
  gh.factory<_i60.ClientsModule>(
      () => _i60.ClientsModule(get<_i54.ClientsScreen>()));
  gh.factory<_i61.MyApp>(() => _i61.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i12.LocalizationService>(),
      get<_i49.SplashModule>(),
      get<_i50.AuthorizationModule>(),
      get<_i59.ChatModule>(),
      get<_i48.SettingsModule>(),
      get<_i55.MainModule>(),
      get<_i58.CaptainsModule>(),
      get<_i60.ClientsModule>(),
      get<_i57.StatisticsModule>()));
  return get;
}
