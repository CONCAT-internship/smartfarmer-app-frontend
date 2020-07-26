import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/constants/smartfarmer_constants.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';

import 'info_page.dart';

class FarmListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    children: <Widget>[
                      Text(
                        "당신의 농장",
                        style: TextStyle(
                            fontSize: 44,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ),
                Container(
                    height: 500,
                    padding: const EdgeInsets.only(left: 32),
                    child: Swiper(
                      itemCount: Provider.of<MineFarmerData>(context)
                          .data
                          .sensorUUID
                          .length,
                      itemWidth: MediaQuery.of(context).size.width - 2 * 64,
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
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 100,
                                        ),
                                        Text(
                                          //Provider.of<MineFarmerData>(context).data.sensorUUID[index],
                                          "Farm $index",
                                          style: TextStyle(
                                            fontSize: 44,
                                            color: const Color(0xff47455f),
                                            fontWeight: FontWeight.w900,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "멋진 배추밭",
                                          style: TextStyle(
                                            fontSize: 23,
                                            color: primaryTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          height: 32,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => InfoPage(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "밭으로 이동",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: secondaryTextColor,
                                                  fontWeight: FontWeight.w500,
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
                    )),
              ],
            ),
          ),
        ));
  }
}
