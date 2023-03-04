import 'package:today_mate_clean/domain/repositories/app_theme_repository.dart';

class SetAppThemeIdUsecase {
  final AppThemeRepository appThemeRepository;
  SetAppThemeIdUsecase({
    required this.appThemeRepository,
  });

  Future<void> call(int id) async {
    await appThemeRepository.setAppThemeId(id);
  }
}
