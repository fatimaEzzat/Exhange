import 'package:bloc/bloc.dart';
import 'package:exchange/cubit/currency_cubit.dart';
import 'package:exchange/presentation/screens/history_Screen.dart';
import 'package:exchange/presentation/screens/home_screen.dart';
import 'package:exchange/presentation/screens/setting_screen.dart';
import 'package:exchange/presentation/screens/splash_screen.dart';
import 'package:exchange/shared/bloc_observer.dart';
import 'package:exchange/shared/network/dio_helper.dart';
import 'package:exchange/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrencyCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Exchange',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: defaultColor,
            textTheme: const TextTheme(
                titleLarge: TextStyle(color: MyColors.mainColor),
                headlineSmall: TextStyle(color: MyColors.mainColor, fontSize: 16.0),
                labelSmall:
                    TextStyle(color: MyColors.smallTextColor, fontSize: 16.0))),
        initialRoute:  SplashScreen.route,
        routes: {
          SplashScreen.route: (context) => const SplashScreen(),
          HomeScreen.route: (context) => const HomeScreen(),
          SettingScreen.route: (context) => const SettingScreen(),
          HistoryScreen.route: (context) => const HistoryScreen(),
        },
        // home: const HomeScreen(),
      ),
    );
  }
}
