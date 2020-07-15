class WeatherData {
  final DateTime date;
  final String name;
  final double temp;
  final String main;
  final double speed;
  final String icon;

  WeatherData({this.date, this.name, this.temp, this.main, this.icon,this.speed});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      main: json['weather'][0]['main'],
      speed: json['wind']['speed'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}