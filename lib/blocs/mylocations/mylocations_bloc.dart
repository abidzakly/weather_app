import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';

import '../bloc_status.dart';

part 'mylocations_event.dart';
part 'mylocations_state.dart';

class MylocationsBloc extends Bloc<MylocationsEvent, MylocationsState> {
  MylocationsBloc() : super( const MylocationsState()) {
    on<MylocationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
