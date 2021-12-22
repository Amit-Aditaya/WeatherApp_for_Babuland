import 'package:flutter/material.dart';
import 'package:weather_application/model/network.dart';
import 'package:weather_application/view/weather_details_screen.dart';
import 'package:weather_application/view_model/get_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherApp'),
        centerTitle: true,
        backgroundColor: const Color(0xff00804A),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(itemBuilder: (context, index) {
              var temp =
                  (snapshot.data as dynamic)['list'][index]['main']['temp'];
              var tempInKelvin = double.parse('$temp');
              var tempInCelcius = tempInKelvin - 273.15;
              var tempCelciusString = tempInCelcius.toStringAsFixed(0);

              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeatherDetails(
                              cityList: (snapshot.data as dynamic)['list']
                                  [index])));
                },
                child: ListTile(
                  title: Text(
                    '${(snapshot.data as dynamic)['list'][index]['name']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    '${(snapshot.data as dynamic)['list'][index]['weather'][0]['main']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    '$tempCelciusString° C',
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
              );
            });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
