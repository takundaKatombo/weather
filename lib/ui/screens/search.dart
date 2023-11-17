import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/colors.dart';
import 'package:weather/models/forecast_weather_model/forecast_weather_model.dart';
import 'package:weather/services/api_calls.dart';
import 'package:weather/ui/screens/home.dart';

class SearchLocations extends StatefulWidget {
  const SearchLocations({super.key});

  @override
  State<SearchLocations> createState() => _SearchLocationsState();
}

class _SearchLocationsState extends State<SearchLocations> {
  List<String> defaultLocations = [
    'Minsk',
    'London',
    'Paris',
    'New York',
    'Berlin'
  ];
  List<ForecastWeatherModel> forecastList = <ForecastWeatherModel>[];
  late Future<List<ForecastWeatherModel>> futureForecastList;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureForecastList = getForecastForDefaultLocations();
  }

  Future<List<ForecastWeatherModel>> getForecastForDefaultLocations() async {
    print(
        "getting forecast for default locations:\n default locations length: ${defaultLocations.length}");
    for (String location in defaultLocations) {
      // Call the function to get the forecast for each location
      // You can replace this with your actual function call
      ForecastWeatherModel forecastData =
          await getForecastData(location: location);
      forecastList.add(forecastData);
    }
    print("forecast list length: ${forecastList.length}");
    print("forecast list : ${forecastList}");
    return forecastList;
  }

  void saveLocation(String location) async {}

  //get forecast for default locations

  @override
  Widget build(BuildContext context) {
    //create a search page with search bar for locations to check weather for and save selected locations to shared preferences

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(gradient: purplrGradient),
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Row(
              children: [
                Text(
                  "Saved Locations",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                Image.asset("assets/images/searchIcon.png"),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: FutureBuilder(
                future: futureForecastList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error}",
                          style: TextStyle(color: Colors.red),
                        );
                      } else if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0; i < forecastList.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0),
                                  child: SavedLocationsCard(
                                    forecast: forecastList[i],
                                  ),
                                ),
                            ],
                          ),
                        );
                      } else {
                        return Text("Snapshot has no data. No Data");
                      }
                    case ConnectionState.none:
                      return Text("Something went wrong");
                    case ConnectionState.active:
                      return Text("No Data");
                    default:
                      return Text("Unknown connection state");
                  }
                },
              ),
            ),
            // SavedLocationsCard(),
            SizedBox(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.08,
              decoration: BoxDecoration(
                color: forecastBackground.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Add new ",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SavedLocationsCard extends StatelessWidget {
  const SavedLocationsCard({
    super.key,
    required this.forecast,
  });

  final ForecastWeatherModel forecast;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyHomePage(forecast: forecast)));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.2,
          decoration: BoxDecoration(
            color: forecastBackground.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  forecast.location?.name ?? "No Data",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
                Text(
                  forecast.current?.condition?.text ?? "No Data",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Humidity ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                      TextSpan(
                        text:
                            forecast.current?.humidity.toString() ?? "No Data",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Wind ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                      TextSpan(
                        text: forecast.current?.windKph.toString() ?? "No Data",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 54,
                  width: 54,
                  child: Image.network(
                    "https:${forecast.current!.condition!.icon}",
                    // width: 100,
                    // height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  "${forecast.current!.tempC.toString()}°C",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 50, fontWeight: FontWeight.w700,
                    fontFeatures: [FontFeature.superscripts()],
                    color: Colors.white,
                    // height: 16,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
