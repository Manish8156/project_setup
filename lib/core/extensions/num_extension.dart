import '../utils/app_common_imports.dart';

extension NumUtil on num {
  Widget get horizontalSpace => SizedBox(width: toDouble());

  Widget get verticalSpace => SizedBox(height: toDouble());

  BorderRadius get circularBorderRadius => BorderRadius.circular(toDouble());
}

extension TextStyleExtension on double {
  /// Call this function with height.
  /// For an example:
  /// height = 32, [fontSize] : 24
  /// Line Height = 1.33 (32/24)
  /// 32.calculateLineHeight(fontSize: 24))
  double? calculateLineHeight({required double fontSize}) => this / fontSize;

  /// Call this function with percentage.
  /// in CSS 1 em = 16 px :=> (0.02 em * 16 px) = 0.32 px
  /// For an example:
  /// percentage = 2, [fontSize] : 24
  /// Letter Spacing = 0.48 ((24 * 2) / 100)
  /// 2.calculateLetterSpacing(fontSize: 24))
  double? calculateLetterSpacing({required double fontSize}) => ((fontSize * this) / 100);
}
