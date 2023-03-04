import 'package:today_mate_clean/domain/repositories/app_theme_repository.dart';

class RemoveAppThemeIdUsecase {
  final AppThemeRepository appThemeRepository;
  RemoveAppThemeIdUsecase({
    required this.appThemeRepository,
  });

  Future<void> call() async {
    await appThemeRepository.removeAppThemeId();
  }
}
