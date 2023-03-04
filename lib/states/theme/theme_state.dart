part of 'theme_cubit.dart';

enum ThemeStateStatus { initial, loading, loaded }

class ThemeState extends Equatable {
  final List<AppTheme> appThemes;
  final AppTheme selectedThems;
  final ThemeStateStatus status;

  const ThemeState({
    required this.appThemes,
    required this.selectedThems,
    required this.status,
  });

  factory ThemeState.initial() {
    return ThemeState(
      status: ThemeStateStatus.initial,
      selectedThems: AppTheme(
          name: "맨디 레드",
          themeData: FlexThemeData.light(scheme: FlexScheme.mandyRed),
          id: 1),
      appThemes: [
        AppTheme(
            name: "맨디 레드",
            themeData: FlexThemeData.light(scheme: FlexScheme.mandyRed),
            id: 1),
        AppTheme(
            name: "아쿠아 블루",
            themeData: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
            id: 2),
        AppTheme(
            name: "바로사",
            themeData: FlexThemeData.light(scheme: FlexScheme.barossa),
            id: 3),
        AppTheme(
            name: "블루 웨일",
            themeData: FlexThemeData.light(scheme: FlexScheme.blueWhale),
            id: 4),
        AppTheme(
            name: "브랜드 블루",
            themeData: FlexThemeData.light(scheme: FlexScheme.brandBlue),
            id: 5),
        AppTheme(
            name: "엠버",
            themeData: FlexThemeData.light(scheme: FlexScheme.amber),
            id: 6),
        AppTheme(
            name: "바하마 블루",
            themeData: FlexThemeData.light(scheme: FlexScheme.bahamaBlue),
            id: 7),
        AppTheme(
            name: "빅 스톤",
            themeData: FlexThemeData.light(scheme: FlexScheme.bigStone),
            id: 8),
        AppTheme(
            name: "블루",
            themeData: FlexThemeData.light(scheme: FlexScheme.blue),
            id: 9),
        AppTheme(
            name: "블루미네",
            themeData: FlexThemeData.light(scheme: FlexScheme.blumineBlue),
            id: 10),
        AppTheme(
            name: "다마스크",
            themeData: FlexThemeData.light(scheme: FlexScheme.damask),
            id: 11),
        AppTheme(
            name: "딥 블루",
            themeData: FlexThemeData.light(scheme: FlexScheme.deepBlue),
            id: 12),
        AppTheme(
            name: "딥 퍼플",
            themeData: FlexThemeData.light(scheme: FlexScheme.deepPurple),
            id: 13),
        AppTheme(
            name: "제노바",
            themeData: FlexThemeData.light(scheme: FlexScheme.dellGenoa),
            id: 14),
        AppTheme(
            name: "클레이",
            themeData: FlexThemeData.light(scheme: FlexScheme.ebonyClay),
            id: 15),
        AppTheme(
            name: "에스프레소",
            themeData: FlexThemeData.light(scheme: FlexScheme.espresso),
            id: 16),
        AppTheme(
            name: "대쉬",
            themeData: FlexThemeData.light(scheme: FlexScheme.flutterDash),
            id: 17),
        AppTheme(
            name: "골드",
            themeData: FlexThemeData.light(scheme: FlexScheme.gold),
            id: 18),
        AppTheme(
            name: "그린",
            themeData: FlexThemeData.light(scheme: FlexScheme.green),
            id: 19),
        AppTheme(
            name: "그레이",
            themeData: FlexThemeData.light(scheme: FlexScheme.greyLaw),
            id: 20),
        AppTheme(
            name: "히피 블루",
            themeData: FlexThemeData.light(scheme: FlexScheme.hippieBlue),
            id: 21),
        AppTheme(
            name: "정글",
            themeData: FlexThemeData.light(scheme: FlexScheme.jungle),
            id: 22),
        AppTheme(
            name: "청록",
            themeData: FlexThemeData.light(scheme: FlexScheme.mallardGreen),
            id: 23),
        AppTheme(
            name: "망고",
            themeData: FlexThemeData.light(scheme: FlexScheme.mango),
            id: 24),
        AppTheme(
            name: "머니",
            themeData: FlexThemeData.light(scheme: FlexScheme.money),
            id: 25),
        AppTheme(
            name: "퍼플 브라운",
            themeData: FlexThemeData.light(scheme: FlexScheme.purpleBrown),
            id: 26),
        AppTheme(
            name: "레드 와인",
            themeData: FlexThemeData.light(scheme: FlexScheme.redWine),
            id: 27),
        AppTheme(
            name: "로즈 우드",
            themeData: FlexThemeData.light(scheme: FlexScheme.rosewood),
            id: 28),
        AppTheme(
            name: "벚꽃",
            themeData: FlexThemeData.light(scheme: FlexScheme.sakura),
            id: 29),
      ],
    );
  }

  @override
  List<Object> get props => [appThemes, selectedThems, status];

  ThemeState copyWith({
    List<AppTheme>? appThemes,
    AppTheme? selectedThems,
    ThemeStateStatus? status,
  }) {
    return ThemeState(
      appThemes: appThemes ?? this.appThemes,
      selectedThems: selectedThems ?? this.selectedThems,
      status: status ?? this.status,
    );
  }
}
