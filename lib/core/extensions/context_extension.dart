import 'package:flutter/cupertino.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextUtil on BuildContext {
  MediaQueryData get info => MediaQuery.of(this);

  double get height => info.size.height;

  double get width => info.size.width;

  AppLocalizations? get localization => AppLocalizations.of(this);
}
