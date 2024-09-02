import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/network/models/weather/main.dart';
import 'package:weather_app/network/models/weather/sys.dart';
import 'package:weather_app/network/models/weather/weather.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:weather_app/network/models/weather/wind.dart';
import 'package:weather_app/views/forecast/blocs/forecast_bloc.dart';
import 'package:weather_app/views/home/blocs/home_bloc.dart';
import 'package:weather_app/network/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/views/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'database/my_location_model.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(MyLocationModelAdapter());
  Hive.registerAdapter(WeatherModelAdapter());
  Hive.registerAdapter(WeatherAdapter());
  Hive.registerAdapter(MainAdapter());
  Hive.registerAdapter(SysAdapter());
  Hive.registerAdapter(WindAdapter());
  var box = await Hive.openBox('mylist');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
              create: (_) => HomeBloc(weatherRepository: WeatherRepository())),
          BlocProvider<ForecastBloc>(
              create: (context) =>
                  ForecastBloc(weatherRepository: WeatherRepository())),
        ],
        child: MaterialApp(
          title: 'Flutter Weather App',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ));
  }
}
