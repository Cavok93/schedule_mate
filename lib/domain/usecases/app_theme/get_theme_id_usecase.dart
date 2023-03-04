import 'package:today_mate_clean/domain/repositories/app_theme_repository.dart';

class GetAppThemeIdUsecase {
  final AppThemeRepository appThemeRepository;
  GetAppThemeIdUsecase({
    required this.appThemeRepository,
  });

  Future<int?> call() async {
    return await appThemeRepository.getAppThemeId();
  }
}
