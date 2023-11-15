import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/colors.dart';
import 'package:weather/models/forecast_weather_model/forecast_weather_model.dart';
import 'package:weather/services/api_calls.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<ForecastWeatherModel> forecast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forecast = getForecastData(location: 'London');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/towerBridge.png"),
              fit: BoxFit.fill),
        ),
        child: FutureBuilder(
            future: forecast,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return SnackBar(
                    content: Text(
                      snapshot.error.toString(),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Column(
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
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.sizeOf(context).width,
                        // height: MediaQuery.sizeOf(context).height * 0.01,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.02,
                            ),
                            Text(
                              snapshot.data?.location?.name ?? "No Data",
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                color: Colors.white,
                                // height: 16,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
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
                            monthInput:
                                snapshot.data?.location?.localtime.toString() ??
                                    "No Data"),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 40, fontWeight: FontWeight.w500,
                          color: Colors.white,
                          // height: 16,
                        ),
                      ),
                      Text(
                        "Updated ${snapshot.data?.current?.lastUpdated}",
                        style: const TextStyle(
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
                        "https:${snapshot.data!.current!.condition!.icon}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        snapshot.data!.current!.condition!.text ?? "No Data",
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 40, fontWeight: FontWeight.w700,
                          color: Colors.white,
                          // height: 16,
                        ),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: snapshot.data!.current!.tempC.toString(),
                      //         style: TextStyle(
                      //           fontFamily: 'Roboto',
                      //           fontSize: 86, fontWeight: FontWeight.w700,
                      //           color: Colors.white,
                      //           // height: 16,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: 'O',
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: 30,
                      //           fontFeatures: [FontFeature.superscripts()],
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: 'C',
                      //         style: TextStyle(
                      //           fontFamily: 'Roboto',
                      //           fontSize: 86, fontWeight: FontWeight.w700,
                      //           fontFeatures: [FontFeature.superscripts()],
                      //           color: Colors.white,
                      //           // height: 16,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Text(
                        "${snapshot.data!.current!.tempC.toString()}°C",
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 70, fontWeight: FontWeight.w700,
                          fontFeatures: [FontFeature.superscripts()],
                          color: Colors.white,
                          // height: 16,
                        ),
                      ),
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
                                const Text(
                                  "Humidity",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14, fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    // height: 16,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!.current!.humidity.toString()}%",
                                  style: const TextStyle(
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
                                const Text(
                                  "Wind",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14, fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    // height: 16,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!.current!.windKph.toString()} km/h",
                                  style: const TextStyle(
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
                                const Text(
                                  "Feels Like",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14, fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    // height: 16,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!.current!.feelslikeC.toString()}°",
                                  style: const TextStyle(
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
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
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
                                    snapshot.data!.forecast!.forecastday![0]
                                            .date ??
                                        "",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14, fontWeight: FontWeight.w700,
                                      // fontFeatures: [FontFeature.superscripts()],
                                      color: Colors.white,
                                      // height: 16,
                                    ),
                                  ),
                                  Image.network(
                                    "https:${snapshot.data!.forecast!.forecastday![0].day!.condition!.icon}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    "${snapshot.data!.forecast!.forecastday![0].day!.avgtempC}°C",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14, fontWeight: FontWeight.w700,
                                      // fontFeatures: [FontFeature.superscripts()],
                                      color: Colors.white,
                                      // height: 16,
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data!.forecast!.forecastday![0].day!.maxwindKph}\nkm/h",
                                    style: const TextStyle(
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
                                    snapshot.data!.forecast!.forecastday![1]
                                            .date ??
                                        "",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14, fontWeight: FontWeight.w700,
                                      // fontFeatures: [FontFeature.superscripts()],
                                      color: Colors.white,
                                      // height: 16,
                                    ),
                                  ),
                                  Image.network(
                                    "https:${snapshot.data!.forecast!.forecastday![1].day!.condition!.icon}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    "${snapshot.data!.forecast!.forecastday![1].day!.avgtempC}°C",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14, fontWeight: FontWeight.w700,
                                      // fontFeatures: [FontFeature.superscripts()],
                                      color: Colors.white,
                                      // height: 16,
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data!.forecast!.forecastday![1].day!.maxwindKph}\nkm/h",
                                    style: const TextStyle(
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
                                    snapshot.data!.forecast!.forecastday![2]
                                            .date ??
                                        "",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14, fontWeight: FontWeight.w700,
                                      // fontFeatures: [FontFeature.superscripts()],
                                      color: Colors.white,
                                      // height: 16,
                                    ),
                                  ),
                                  Image.network(
                                    "https:${snapshot.data!.forecast!.forecastday![2].day!.condition!.icon}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    "${snapshot.data!.forecast!.forecastday![2].day!.avgtempC}°C",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14, fontWeight: FontWeight.w700,
                                      // fontFeatures: [FontFeature.superscripts()],
                                      color: Colors.white,
                                      // height: 16,
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data!.forecast!.forecastday![2].day!.maxwindKph}\nkm/h",
                                    style: const TextStyle(
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
                      const Spacer(),
                    ],
                  );
                }
              }
              {
                return const Center(child: CircularProgressIndicator());
              }
            }),
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

  getDayFromString({required String dayInput}) {
    // String day = dayInput.substring(8, 10);
  }
}
