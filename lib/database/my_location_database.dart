import 'package:hive_flutter/hive_flutter.dart';
import 'my_location_model.dart';

class MyLocationDatabase {
  List<MyLocationModel> myLocations = [];

  final _myBox = Hive.box('mylist');

  void createInitialData({required MyLocationModel myLocationModel}) {
    myLocations = [myLocationModel];
  }

  void loadData() {
      var rawData = _myBox.get("MYLOCATIONS") as List<dynamic>?;

      if (rawData != null) {
        myLocations = rawData.map((e) => e as MyLocationModel).toList();
      } else {
        myLocations = [];
      }
  }

  void updateDatabase() {
    _myBox.put("MYLOCATIONS", myLocations);
  }
}
