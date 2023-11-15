import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/colors.dart';

class SearchLocations extends StatelessWidget {
  const SearchLocations({super.key});

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
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.2,
              decoration: BoxDecoration(
                color: forecastBackground.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Dismissible(
                key: UniqueKey(),
                child: Row(children: [
                  Column(
                    children: [
                      Text(
                        "New York",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                      Text(
                        "Sunny",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      Spacer(),
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
                              text: "52%",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
            )
          ],
        ),
      ),
    );
  }
}
