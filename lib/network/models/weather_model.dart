class WeatherModel {
  late final List<Weather> weather;
  late final Main main;
  late final Sys sys;
  late final String name;

  WeatherModel({
    required this.weather,
    required this.main,
    required this.sys,
    required this.name,
  });

  WeatherModel.fromJson(Map<String, dynamic> json){
    weather = List.from(json['weather']).map((e)=>Weather.fromJson(e)).toList();
    main = Main.fromJson(json['main']);
    sys = Sys.fromJson(json['sys']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['weather'] = weather.map((e)=>e.toJson()).toList();
    _data['main'] = main.toJson();
    _data['sys'] = sys.toJson();
    _data['name'] = name;
    return _data;
  }
}

class Weather {
  late final String main;
  late final String description;
  late final String icon;

  Weather({
    required this.main,
    required this.description,
    required this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json){
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['main'] = main;
    _data['description'] = description;
    _data['icon'] = icon;
    return _data;
  }
}

class Main {
  late final double temp;
  late final int humidity;

  Main({
    required this.temp,
    required this.humidity,
  });

  Main.fromJson(Map<String, dynamic> json){
    temp = json['temp'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['temp'] = temp;
    _data['humidity'] = humidity;
    return _data;
  }
}

class Sys {
  late final String country;

  Sys({
    required this.country,
  });

  Sys.fromJson(Map<String, dynamic> json){
    country = json['country'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['country'] = country;
    return _data;
  }
}
