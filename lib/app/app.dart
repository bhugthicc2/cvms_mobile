import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cvms_mobile/core/routes/app_router.dart';
import 'package:cvms_mobile/core/theme/app_theme.dart';
import 'package:cvms_mobile/src/features/home/presentation/controllers/home_controller.dart';
import 'package:cvms_mobile/src/features/home/data/repositories/home_repository.dart';
import 'package:cvms_mobile/src/features/home/domain/usecases/get_user_usecase.dart';
import 'package:cvms_mobile/src/features/home/domain/usecases/get_statistics_usecase.dart';
import 'package:cvms_mobile/src/features/home/domain/usecases/logout_usecase.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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
      ],
      child: MaterialApp(
        title: 'CVMS',
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.splash,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
