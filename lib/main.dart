import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scum_poker/app/bloc/user_cubit.dart';
import 'package:scum_poker/app/presentations/splash/splash_screen.dart';
import 'package:scum_poker/app/utilis/app_theme.dart';
import 'package:scum_poker/app/utilis/font_theme.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeBackground(
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => getIt<NameCubit>())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: FontTheme.lightTheme,
          darkTheme: FontTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
