import '../utils/app_common_imports.dart';

extension WidgetExt on Widget {
  Widget horizontalSpacing({double? horizontal, bool? isSliver}) => (isSliver ?? false)
      ? SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? Dimens.w16,
          ),
          sliver: this,
        )
      : Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? Dimens.w16,
          ),
          child: this,
        );

  Widget verticalSpacing({double? vertical, bool? isSliver}) => (isSliver ?? false)
      ? SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: vertical ?? Dimens.h16,
          ),
          sliver: this,
        )
      : Padding(
          padding: EdgeInsets.symmetric(
            vertical: vertical ?? Dimens.h16,
          ),
          child: this,
        );
}
