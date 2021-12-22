import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherDetails extends StatefulWidget {
  var cityList;
  WeatherDetails({Key? key, required this.cityList}) : super(key: key);
  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = Set();
    Completer<GoogleMapController> _controller = Completer();
    var latitude = widget.cityList['coord']['lat'];
    double lat = double.parse('$latitude');
    var longitude = widget.cityList['coord']['lon'];
    double long = double.parse('$longitude');
    LatLng _center = LatLng(lat, long);
    markers.add(Marker(
      markerId: const MarkerId(''),
      position: _center,
      icon: BitmapDescriptor.defaultMarker,
    ));
    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    String maxTemp = _getMaxTemp();
    String minTemp = _getMintemp();
    String tempCelcius = _getTempInCelcius();

    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherApp'),
        centerTitle: true,
        backgroundColor: const Color(0xff00804A),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 350,
            child: GoogleMap(
              markers: markers,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      '${widget.cityList['name']}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${widget.cityList['weather'][0]['description']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Humidity: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${widget.cityList['main']['humidity']}',
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Wind Speed: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${widget.cityList['wind']['speed']}',
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Max Temp: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '$minTemp° c',
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Min Temp: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          //'${cityList['main']['temp_min']}',
                          '$maxTemp° c ',
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      '$tempCelcius° c',
                      style: const TextStyle(fontSize: 34),
                    ),
                    Icon(
                      widget.cityList['weather'][0]['main'] == "Clear"
                          ? Icons.wb_sunny_outlined
                          : widget.cityList['weather'][0]['main'] == "Clouds"
                              ? Icons.cloud
                              : widget.cityList['weather'][0]['main'] == "Rain"
                                  ? FontAwesomeIcons.cloudRain
                                  : Icons.ac_unit,
                      size: 48,
                    )
                  ],
                )),
              )
            ],
          ),
        ],
      ),
    );
  }

  _getMaxTemp() {
    var tempMax = widget.cityList['main']['temp_max'];
    var tempInKelvinMax = double.parse('$tempMax');
    var tempInCelciusMax = tempInKelvinMax - 273.15;
    var tempCelciusStringMax = tempInCelciusMax.toStringAsFixed(0);
    return tempCelciusStringMax;
  }

  _getMintemp() {
    var tempMin = widget.cityList['main']['temp_min'];
    var tempInKelvinMin = double.parse('$tempMin');
    var tempInCelciusMin = tempInKelvinMin - 273.15;
    var tempCelciusStringMin = tempInCelciusMin.toStringAsFixed(0);
    return tempCelciusStringMin;
  }

  _getTempInCelcius() {
    var temp = widget.cityList['main']['temp'];
    var tempInKelvin = double.parse('$temp');
    var tempInCelcius = tempInKelvin - 273.15;
    var tempCelciusString = tempInCelcius.toStringAsFixed(0);
    return tempCelciusString;
  }
}
