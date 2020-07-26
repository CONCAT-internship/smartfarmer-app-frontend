import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/constants/smartfarmer_constants.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';

class FarmListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueGradient2,
        body: Container(
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
                    child: Swiper(
                      itemCount: Provider.of<MineFarmerData>(context)
                          .data
                          .sensorUUID
                          .length,
                      itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                      layout: SwiperLayout.STACK,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 100,
                                ),
                                Card(
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                        Provider.of<MineFarmerData>(context).data.sensorUUID[index],
                                        style: TextStyle(
                                          fontSize: 44,
                                          color: const Color(0xff47455f),
                                          fontWeight: FontWeight.w900,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
