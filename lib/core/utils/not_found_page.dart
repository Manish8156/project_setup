import 'app_common_imports.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(context.localization?.pageNotFound ?? ''),
      ),
    );
  }
}
