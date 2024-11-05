import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/appdata/app_assets.dart';
import 'package:weather_app/appdata/global_functions.dart';
import 'package:weather_app/appdata/global_variables.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_long;
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/appdata/global_widget.dart';
import 'package:weather_app/database/my_location_database.dart';
import 'package:weather_app/database/my_location_model.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:weather_app/network/weather_repository.dart';
import 'package:weather_app/views/map/widget/custom_button.dart';

import '../../appdata/app_colors.dart';
import '../../appdata/coordinate_point.dart';

class MapPickScreen extends StatefulWidget {
  const MapPickScreen({super.key, required this.title});

  final String title;

  @override
  State<MapPickScreen> createState() => _MapPickScreenState();
}

class _MapPickScreenState extends State<MapPickScreen> {
  TextEditingController latitudeTextController = TextEditingController();
  TextEditingController longitudeTextController = TextEditingController();

  final MyLocationDatabase db = MyLocationDatabase();
  final WeatherRepository repo = WeatherRepository();

  @override
  void initState() {
    super.initState();
    globalVariable.mapController = MapController();
    initializeMapPosition();
  }

  void initializeMapPosition() async {
    Position? pos = await repo.getCurrentPosition();
    print('pos: ${pos}');
    print('pos: ${await repo.getCurrentPosition()}');
    globalVariable.latitude = pos.latitude;
    globalVariable.longitude = pos.longitude;

    globalVariable.myLocationLat = pos.latitude;
    globalVariable.myLocationLong = pos.longitude;
    setState(() {
      longitudeTextController.text = globalVariable.longitude.toString();
      latitudeTextController.text = globalVariable.latitude.toString();
    });
    globalVariable.mapController.move(
        lat_long.LatLng(globalVariable.latitude, globalVariable.longitude),
        globalVariable.mapZoom);
  }

  void showTextDialog() {
    final formKey = GlobalKey<FormState>();
    if (mounted) {
      TextEditingController textController = TextEditingController();
      showDialog(
          context: context,
          builder: (dialogContext) {
            return StatefulBuilder(builder: (context, setState) {
              return Dialog(
                  backgroundColor: AppColors.primaryColor,
                  child: Form(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 24),
                        child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            SizedBox(height: getScreenHeight() * 0.015),
                            const Text('Add Tag',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondaryColor)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: getScreenHeight() * 0.02),
                                TextField(
                                    controller: textController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.white)),
                                      counterText: "",
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: getScreenHeight() * 0.0225,
                                          horizontal: getScreenWidth() * 0.02),
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      filled: true,
                                      // border: OutlineInputBorder(),
                                      hintText: 'Enter Tag: e.g. `Home`',
                                    ))
                              ],
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomButton(
                                    width: 102,
                                    height: 46,
                                    buttonColor: AppColors.secondaryColor,
                                    buttonText: 'Cancel',
                                    textColor: AppColors.primaryColor,
                                    onTapped: () async {
                                      Navigator.pop(context);
                                    },
                                    setBorderRadius: true),
                                const SizedBox(width: 4),
                                CustomButton(
                                    width: 102,
                                    height: 46,
                                    buttonColor: AppColors.secondaryColor,
                                    buttonText: 'Save',
                                    textColor: AppColors.primaryColor,
                                    onTapped: () async {
                                      db.loadData();
                                      WeatherModel? weatherData =
                                          await repo.getCurrentWeather(
                                              latitude:
                                                  latitudeTextController.text,
                                              longitude:
                                                  longitudeTextController.text);
                                      if (textController.text
                                          .trim()
                                          .isNotEmpty) {
                                        db.myLocations.add(MyLocationModel(
                                            title: textController.text,
                                            latitude:
                                                latitudeTextController.text,
                                            longitude:
                                                longitudeTextController.text,
                                            weatherModel: weatherData!));
                                        db.updateDatabase();
                                        Navigator.pop(context);
                                        // setState(() {
                                        //   showLoading();
                                        // });
                                      } else {
                                        showSnackBar(
                                            context, 'Text cannot be empty');
                                      }
                                    },
                                    setBorderRadius: true),
                              ],
                            ),
                            SizedBox(height: getScreenHeight() * 0.015),
                          ]),
                        ),
                      )));
            });
          });
    }
  }

  void showCoordinatesDialog() {
    final formKey = GlobalKey<FormState>();
    if (mounted) {
      // TextEditingController textController = TextEditingController();
      showDialog(
          context: context,
          builder: (dialogContext) {
            return StatefulBuilder(builder: (context, setState) {
              return Dialog(
                  backgroundColor: AppColors.primaryColor,
                  child: Form(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 24),
                        child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            SizedBox(height: getScreenHeight() * 0.015),
                            const Text('Edit Coordinates',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondaryColor)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: getScreenHeight() * 0.02),
                                TextField(
                                    controller: latitudeTextController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(),
                                    onChanged: (text) {
                                      if (double.tryParse(text) != null) {
                                        if (double.parse(text) < -90 ||
                                            double.parse(text) > 90) {
                                          showSnackBar(context,
                                              'Latitude should be between -90 and 90');
                                        } else {
                                          setState(() {
                                            globalVariable.latitude =
                                                double.parse(text);
                                          });
                                        }
                                      } else {
                                        showSnackBar(context, 'Invalid Input');
                                      }
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.white)),
                                      counterText: "",
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: getScreenHeight() * 0.0225,
                                          horizontal: getScreenWidth() * 0.02),
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      filled: true,
                                      // border: OutlineInputBorder(),
                                      hintText: 'Enter latitude',
                                    )),
                                SizedBox(height: getScreenHeight() * 0.02),
                                TextField(
                                    controller: longitudeTextController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(),
                                    onChanged: (text) {
                                      if (double.tryParse(text) != null) {
                                        if (double.parse(text) < -180 ||
                                            double.parse(text) > 180) {
                                          showSnackBar(context,
                                              'Longitude should be between -180 and 180');
                                        } else {
                                          setState(() {
                                            globalVariable.longitude =
                                                double.parse(text);
                                          });
                                        }
                                      } else {
                                        showSnackBar(context, 'Invalid Input');
                                      }
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.white)),
                                      counterText: "",
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: getScreenHeight() * 0.0225,
                                          horizontal: getScreenWidth() * 0.02),
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      filled: true,
                                      // border: OutlineInputBorder(),
                                      hintText: 'Enter longitude',
                                    )),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomButton(
                                    width: 102,
                                    height: 46,
                                    buttonColor: AppColors.secondaryColor,
                                    buttonText: 'Cancel',
                                    textColor: AppColors.primaryColor,
                                    onTapped: () async {
                                      Navigator.pop(context);
                                    },
                                    setBorderRadius: true),
                                const SizedBox(width: 4),
                                CustomButton(
                                    width: 102,
                                    height: 46,
                                    buttonColor: AppColors.secondaryColor,
                                    buttonText: 'Save',
                                    textColor: AppColors.primaryColor,
                                    onTapped: () {
                                      double newLatitude = double.parse(
                                          latitudeTextController.text);
                                      double newLongitude = double.parse(
                                          longitudeTextController.text);
                                      if (latitudeTextController.text
                                              .trim()
                                              .isNotEmpty &&
                                          longitudeTextController.text
                                              .trim()
                                              .isNotEmpty) {
                                        if (newLatitude > -90 &&
                                            newLatitude < 90 &&
                                            newLongitude > -180 &&
                                            newLongitude < 180) {
                                          Navigator.pop(context);
                                          setState(() {
                                            globalVariable.mapController.move(
                                                lat_long.LatLng(
                                                    globalVariable.latitude,
                                                    globalVariable.longitude),
                                                globalVariable.mapZoom);
                                          });
                                        } else {
                                          showSnackBar(
                                              context, 'Invalid Coordinates');
                                        }
                                      } else {
                                        showSnackBar(
                                            context, 'Text cannot be empty');
                                      }
                                    },
                                    setBorderRadius: true),
                              ],
                            ),
                            SizedBox(height: getScreenHeight() * 0.015),
                          ]),
                        ),
                      )));
            });
          });
    }
  }

  void showLoading() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(builder: (context, setState) {
            return const Dialog(
              child: CustomLoading(),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    print("globalData's latitude: ${globalVariable.latitude}");
    print("globalData's longitude: ${globalVariable.longitude}");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Choose A Location',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          PopupMenuButton<String>(
            color: AppColors.secondaryColor,
            onSelected: (value) {
              if (value == 'edit_coordinates') {
                setState(() {
                  showCoordinatesDialog();
                });
              } else if (value == 'use_current_loc') {
                setState(() {
                  latitudeTextController.text = globalVariable.myLocationLat.toString();
                  longitudeTextController.text = globalVariable.myLocationLong.toString();
                  globalVariable.latitude = globalVariable.myLocationLat;
                  globalVariable.longitude = globalVariable.myLocationLong;
                  globalVariable.mapController.move(
                      lat_long.LatLng(
                          globalVariable.latitude, globalVariable.longitude),
                      globalVariable.mapZoom);
                });
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'edit_coordinates',
                  child: YellowOnBlackText(text: 'Edit Coordinates'),
                ),
                const PopupMenuItem(
                  value: 'use_current_loc',
                  child: YellowOnBlackText(text: 'Use My Current Location'),
                ),
              ];
            },
          ),
        ],
      ),
      // bottomNavigationBar: const BottomActionsWidget(),
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: globalVariable.mapController,
              options: MapOptions(
                  initialCenter: const lat_long.LatLng(0, 0),
                  initialZoom: globalVariable.mapZoom,
                  onTap: (position, latLng) {
                    print("afterTap Latitude: ${latLng.latitude}");
                    print("afterTap Longitude: ${latLng.longitude}");
                    latitudeTextController.text = latLng.latitude.toString();
                    longitudeTextController.text = latLng.longitude.toString();
                    setState(() {
                      globalVariable.latitude = latLng.latitude;
                      globalVariable.longitude = latLng.longitude;
                    });
                  }),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: lat_long.LatLng(
                          globalVariable.latitude, globalVariable.longitude),
                      width: 50,
                      height: 50,
                      child: Image.asset(AppAssets.pinpointSmallRed),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: AppColors.primaryColor,
        onPressed: () => showTextDialog(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
