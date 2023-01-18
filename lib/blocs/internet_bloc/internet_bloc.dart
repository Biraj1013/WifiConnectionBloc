import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wificonectivity/blocs/internet_bloc/internet_event.dart';
import 'package:wificonectivity/blocs/internet_bloc/internet_state.dart';

import 'package:connectivity/connectivity.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetBloc() : super(InternetInitialState())
  //inside the super we need to pass the initial value....
  //in this case we pass initailState of wifi
  {
    //inside this function we are able to defined the event nad reletive state

    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));
    //on check the evenet action
    //i.e check whether the event came or not

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  //add for pull the event into the bloc from ui to event
  //emit for push the state from the bloc to ui
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }

  //bloc close as the page close
  //but onConnectivityChanged.listen((result) run in background
  //so we need to closed if the bloc closed

}


//BlocProvider provided the bloc to their child



