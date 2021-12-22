import 'package:weather_application/model/network.dart';

Future<dynamic> getData() async {
  Network network = Network(
      'http://api.openweathermap.org/data/2.5/find?lat=23.68&lon=90.35&cnt=50&appid=e384f9ac095b2109c751d95296f8ea76');
  var data = await network.fetchData();
  return data;
}
