import 'package:cydeva_application/screens/FlashPage/SplashScreen.dart';
import 'package:cydeva_application/screens/HomePage/HomePage.dart';
import 'package:cydeva_application/screens/SignInPage/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: BlocProvider(
        create: (context) => SigninBloc(),
        child: const SplashScreen(),
      ),
    );
  }
}
