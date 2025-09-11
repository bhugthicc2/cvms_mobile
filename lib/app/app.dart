import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cvms_mobile/core/routes/app_router.dart';
import 'package:cvms_mobile/core/theme/app_theme.dart';
import 'package:cvms_mobile/src/features/home/presentation/controllers/home_controller.dart';
import 'package:cvms_mobile/src/features/home/data/repositories/home_repository.dart';
import 'package:cvms_mobile/src/features/home/domain/usecases/get_user_usecase.dart';
import 'package:cvms_mobile/src/features/home/domain/usecases/get_statistics_usecase.dart';
import 'package:cvms_mobile/src/features/home/domain/usecases/logout_usecase.dart';
import 'package:cvms_mobile/src/core/controllers/font_controller.dart';
import 'package:cvms_mobile/src/core/controllers/theme_controller.dart';

class App extends StatelessWidget {
  const App({super.key, this.initialIsDarkMode = false});

  final bool initialIsDarkMode;

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) => HomeController(
                GetUserUseCase(HomeRepositoryImpl()),
                GetStatisticsUseCase(HomeRepositoryImpl()),
                LogoutUseCase(HomeRepositoryImpl()),
              ),
        ),
        ChangeNotifierProvider(
          create: (_) {
            final controller = FontController();
            controller.load();
            return controller;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeController(initialIsDarkMode: initialIsDarkMode),
        ),
      ],
      child: Consumer2<FontController, ThemeController>(
        builder:
            (context, fontController, themeController, _) => MaterialApp(
              title: 'CVMS',
              theme: AppTheme.lightTheme(
                textScaleFactor: fontController.textScaleFactor,
              ),
              darkTheme: AppTheme.darkTheme(
                textScaleFactor: fontController.textScaleFactor,
              ),
              themeMode:
                  themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              onGenerateRoute: AppRouter.onGenerateRoute,
              initialRoute: AppRouter.splash,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                // Also apply MediaQuery textScaleFactor so Text widgets scale
                final media = MediaQuery.of(context);
                return MediaQuery(
                  data: media.copyWith(
                    textScaler: TextScaler.linear(
                      fontController.textScaleFactor,
                    ),
                  ),
                  child: child!,
                );
              },
            ),
      ),
=======
    return MaterialApp(
      title: 'CVMS',
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.signin,
      debugShowCheckedModeBanner: false,
>>>>>>> Stashed changes
    );
  }
}
