import 'package:today_mate_clean/domain/usecases/app_theme/get_theme_id_usecase.dart';
import 'package:today_mate_clean/domain/usecases/app_theme/remove_theme_usecase.dart';
import 'package:today_mate_clean/domain/usecases/app_theme/set_theme_id_usecase.dart';

class AppThemesUsecases {
  final GetAppThemeIdUsecase getAppThemeIdUsecase;
  final SetAppThemeIdUsecase setAppThemeIdUsecase;
  final RemoveAppThemeIdUsecase removeAppThemeIdUsecase;
  AppThemesUsecases({
    required this.getAppThemeIdUsecase,
    required this.setAppThemeIdUsecase,
    required this.removeAppThemeIdUsecase,
  });
}
