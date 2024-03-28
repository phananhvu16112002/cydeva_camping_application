import 'package:cydeva_application/screens/SignInPage/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late SigninBloc _signinBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signinBloc = BlocProvider.of<SigninBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: BlocBuilder<SigninBloc, SigninState>(
            bloc: _signinBloc,
            builder: (context, state) {
              return Center(child: Image.asset('assets/images/guide2.png'));
            },
          ),
        ),
      ),
    );
  }
}
