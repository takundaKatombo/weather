import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/colors.dart';
import 'package:weather/models/forecast_weather_model/forecast_weather_model.dart';
import 'package:weather/private.dart';
import 'package:weather/services/api_calls.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.forecast});
  final ForecastWeatherModel forecast;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/towerBridge.png"),
              fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Center(
            //   child: const Text(
            //     'You Dont have Saved Locations',
            //     style: TextStyle(fontSize: 30, fontFamily: 'Poppins'),
            //   ),
            // ),
            //TODO: add a button to go to search page
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.sizeOf(context).width,
              // height: MediaQuery.sizeOf(context).height * 0.01,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  Text(
                    widget.forecast.location?.name ?? "No Data",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Colors.white,
                      // height: 16,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 35,
                    weight: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.015,
            ),
            Text(
              getMonthFromString(
                  monthInput: widget.forecast.location?.localtime.toString() ??
                      "No Data"),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40, fontWeight: FontWeight.w500,
                color: Colors.white,
                // height: 16,
              ),
            ),
            Text(
              "Updated ${widget.forecast.current?.lastUpdated}",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16, fontWeight: FontWeight.w500,
                color: Colors.white,
                // height: 16,
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.015,
            ),
            Image.network(
              "https:${widget.forecast.current!.condition!.icon}",
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
            Text(
              widget.forecast.current!.condition!.text ?? "No Data",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40, fontWeight: FontWeight.w700,
                color: Colors.white,
                // height: 16,
              ),
            ),

            Text(
              "${widget.forecast.current!.tempC.toString()}°C",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 70, fontWeight: FontWeight.w700,
                fontFeatures: [FontFeature.superscripts()],
                color: Colors.white,
                // height: 16,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/iconHumidity.svg",
                      ),
                      Text(
                        "Humidity",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14, fontWeight: FontWeight.w500,
                          color: Colors.white,
                          // height: 16,
                        ),
                      ),
                      Text(
                        "${widget.forecast.current!.humidity.toString()}%",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14, fontWeight: FontWeight.w500,
                          color: Colors.white,
                          // height: 16,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/iconWind.svg",
                      ),
                      Text(
                        "Wind",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14, fontWeight: FontWeight.w500,
                          color: Colors.white,
                          // height: 16,
                        ),
                      ),
                      Text(
                        "${widget.forecast.current!.windKph.toString()} km/h",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14, fontWeight: FontWeight.w500,
                          color: Colors.white,
                          // height: 16,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/iconFeelsLike.svg",
                      ),
                      Text(
                        "Feels Like",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14, fontWeight: FontWeight.w500,
                          color: Colors.white,
                          // height: 16,
                        ),
                      ),
                      Text(
                        "${widget.forecast.current!.feelslikeC.toString()}°",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14, fontWeight: FontWeight.w500,
                          color: Colors.white,
                          // height: 16,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: forecastBackground.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.forecast.forecast!.forecastday![0].date ?? "",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14, fontWeight: FontWeight.w700,
                            // fontFeatures: [FontFeature.superscripts()],
                            color: Colors.white,
                            // height: 16,
                          ),
                        ),
                        Image.network(
                          "https:${widget.forecast.forecast!.forecastday![0].day!.condition!.icon}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          "${widget.forecast.forecast!.forecastday![0].day!.avgtempC}°C",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14, fontWeight: FontWeight.w700,
                            // fontFeatures: [FontFeature.superscripts()],
                            color: Colors.white,
                            // height: 16,
                          ),
                        ),
                        Text(
                          "${widget.forecast.forecast!.forecastday![0].day!.maxwindKph}\nkm/h",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14, fontWeight: FontWeight.w500,
                            color: Colors.white,
                            // height: 16,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          widget.forecast.forecast!.forecastday![1].date ?? "",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14, fontWeight: FontWeight.w700,
                            // fontFeatures: [FontFeature.superscripts()],
                            color: Colors.white,
                            // height: 16,
                          ),
                        ),
                        Image.network(
                          "https:${widget.forecast.forecast!.forecastday![1].day!.condition!.icon}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          "${widget.forecast.forecast!.forecastday![1].day!.avgtempC}°C",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14, fontWeight: FontWeight.w700,
                            // fontFeatures: [FontFeature.superscripts()],
                            color: Colors.white,
                            // height: 16,
                          ),
                        ),
                        Text(
                          "${widget.forecast.forecast!.forecastday![1].day!.maxwindKph}\nkm/h",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14, fontWeight: FontWeight.w500,
                            color: Colors.white,
                            // height: 16,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          widget.forecast.forecast!.forecastday![2].date ?? "",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14, fontWeight: FontWeight.w700,
                            // fontFeatures: [FontFeature.superscripts()],
                            color: Colors.white,
                            // height: 16,
                          ),
                        ),
                        Image.network(
                          "https:${widget.forecast.forecast!.forecastday![2].day!.condition!.icon}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          "${widget.forecast.forecast!.forecastday![2].day!.avgtempC}°C",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14, fontWeight: FontWeight.w700,
                            // fontFeatures: [FontFeature.superscripts()],
                            color: Colors.white,
                            // height: 16,
                          ),
                        ),
                        Text(
                          "${widget.forecast.forecast!.forecastday![2].day!.maxwindKph}\nkm/h",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14, fontWeight: FontWeight.w500,
                            color: Colors.white,
                            // height: 16,
                          ),
                        )
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       snapshot.data!.forecast!.forecastday![3]
                    //               .date ??
                    //           "",
                    //       style: TextStyle(
                    //         fontFamily: 'Roboto',
                    //         fontSize: 14, fontWeight: FontWeight.w700,
                    //         // fontFeatures: [FontFeature.superscripts()],
                    //         color: Colors.white,
                    //         // height: 16,
                    //       ),
                    //     ),
                    //     Image.network(
                    //       "https:${snapshot.data!.forecast!.forecastday![3].day!.condition!.icon}",
                    //       width: 50,
                    //       height: 50,
                    //       fit: BoxFit.fill,
                    //     ),
                    //     Text(
                    //       "${snapshot.data!.forecast!.forecastday![3].day!.avgtempC}°C",
                    //       style: TextStyle(
                    //         fontFamily: 'Roboto',
                    //         fontSize: 14, fontWeight: FontWeight.w700,
                    //         // fontFeatures: [FontFeature.superscripts()],
                    //         color: Colors.white,
                    //         // height: 16,
                    //       ),
                    //     ),
                    //     Text(
                    //       "${snapshot.data!.forecast!.forecastday![3].day!.maxwindKph}\nkm/h",
                    //       style: TextStyle(
                    //         fontFamily: 'Roboto',
                    //         fontSize: 14, fontWeight: FontWeight.w500,
                    //         color: Colors.white,
                    //         // height: 16,
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
            // Spacer(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

// Get Month from datetime string
  getMonthFromString({required String monthInput}) {
    String month = monthInput.substring(5, 7);
    switch (month) {
      case '01':
        return 'January';
      case '02':
        return 'February';
      case '03':
        return 'March';
      case '04':
        return 'April';
      case '05':
        return 'May';
      case '06':
        return 'June';
      case '07':
        return 'July';
      case '08':
        return 'August';
      case '09':
        return 'September';
      case '10':
        return 'October';
      case '11':
        return 'November';
      case '12':
        return 'December';
      default:
        return '';
    }
  }
}
