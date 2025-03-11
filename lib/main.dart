import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_newsvigator_app/config/routes/routes.dart';
import 'package:flutter_newsvigator_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_newsvigator_app/features/daily_news/presentation/pages/top_headlines/top_headlines.dart';
import 'config/theme/app_themes.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'di/injection_container.dart';
import 'features/main/presentation/pages/layout/main_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()
        ..add(const GetArticles())
        ..add(const GetAllNews()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const MainLayout(),
      ),
    );
  }
}
