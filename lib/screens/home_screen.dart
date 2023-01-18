import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wificonectivity/blocs/internet_bloc/internet_bloc.dart';
import 'package:wificonectivity/blocs/internet_bloc/internet_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          //== to check value
          //is to check data type
          if (state is InternetGainedState) {
            return const Text("Connected!");
          } else if (state is InternetLostState) {
            return const Text("Not Connected!");
          } else {
            return const Text("Loading....");
          }
        },
      )),
    );
  }
}
