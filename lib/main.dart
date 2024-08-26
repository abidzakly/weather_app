import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/appdata/app_colors.dart';
import 'package:weather_app/blocs/global_bloc_observer.dart';
import 'package:weather_app/blocs/home/home_bloc.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/network/weather_repository.dart';
import 'package:weather_app/network/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/views/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';


import 'appdata/global_data.dart';
import 'network/weather_repository.dart';

void main() async {
  // Bloc.observer = GlobalBlocObserver();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(WeatherRepository()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ));
  }
}
