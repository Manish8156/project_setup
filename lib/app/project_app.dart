import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_setup/core/utils/app_common_imports.dart';
import 'package:project_setup/core/utils/not_found_page.dart';

class ProjectApp extends StatefulWidget {
  const ProjectApp({super.key});

  @override
  State<ProjectApp> createState() => _ProjectAppState();
}

class _ProjectAppState extends State<ProjectApp> {
  Locale? selectedAppLocale;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: sl<AppTheme>().lightTheme,
      darkTheme: sl<AppTheme>().darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: selectedAppLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (selectedAppLocale != null &&
            supportedLocales.map((e) => e.languageCode).contains(
                  selectedAppLocale?.languageCode,
                )) {
          return selectedAppLocale;
        } else if (supportedLocales.map((e) => e.languageCode).contains(
              deviceLocale?.languageCode,
            )) {
          return deviceLocale;
        } else {
          return AppConstants.enLocale;
        }
      },
      navigatorKey: AppConstants.navigatorKey,
      scaffoldMessengerKey: AppConstants.scaffoldMessengerKey,
      initialRoute: Routes.initialRoute,
      onGenerateRoute: Routes.appRoutes,
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) {
          return const NotFoundPage();
        },
      ),
    );
  }
}
