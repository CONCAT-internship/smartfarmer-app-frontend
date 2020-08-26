import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/model/farmer_model/profile_farmer.dart';

import 'package:http/http.dart' as http;
import 'package:smartfarm/services/firebase_provider.dart';
import 'package:smartfarm/services/scan_data.dart';
import 'package:smartfarm/screens/devices_connect/connect_page.dart';
import 'package:smartfarm/screens/farm_dashboard/info_page.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class FarmListPage extends StatelessWidget {
  Future<ProfileFarmer> getProfile(String uid) async {
    try {
      String url = '$API/ProfileFarmer?uid=$uid';
      final http.Response response = await http.get(url);
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      final ProfileFarmer profileFarmer = ProfileFarmer.fromJson(responseData);
      return profileFarmer;
    } catch (err) {
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseProvider fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
        backgroundColor: blueGradient2,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [blueGradient1, blueGradient2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.7],
          )),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "당신의 농장",
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'NotoSans-Medium',
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 500,
                    padding: const EdgeInsets.only(left: 32),
                    child: FutureBuilder(
                      future: getProfile(fp.getUser().uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final farmerProfile = snapshot.data;
                          return Swiper(
                            itemCount: farmerProfile.farmInfo.length,
                            itemWidth:
                                MediaQuery.of(context).size.width - 2 * 64,
                            layout: SwiperLayout.STACK,
                            pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                  activeSize: 20, space: 8),
                            ),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 100,
                                      ),
                                      Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(32.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 140,
                                              ),
                                              Text(
                                                farmerProfile
                                                    .farmInfo[index].farmName,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color:
                                                      const Color(0xff47455f),
                                                  fontFamily: 'NotoSans-Bold',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      Provider.of<ScanData>(
                                                              context,
                                                              listen: false)
                                                          .setDeviceUUID(
                                                              farmerProfile.farmInfo[index].deviceUUID);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              InfoPage(),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "밭으로 이동",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            secondaryTextColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: secondaryTextColor,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Image.asset("assets/images/plant.png"),
                                ],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
