import 'package:flutter/material.dart';
import 'package:smartfarm/constants/smartfarmer_constants.dart';
import 'package:clippy_flutter/clippy_flutter.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Arc(
          height: 30.0,
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [blueGradient1, blueGradient2],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '김태훈님',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/ogu.png'),
                      radius: 20.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14.0,
              ),
              Text(
                "당신의 농장은 관리되고 있습니다",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                height: 160.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _InfoCard('온도', temp, 'Temperature', '1350'),
                    _InfoCard('습도', humidity, 'Humidity', '1190'),
                    _InfoCard('조도', sun, 'Roughness', '782'),
//                    _InfoCard('Slack', slack, 'Business', '1350'),
                  ],
                ),
              ),
            ],
          ),
        ),
        //_graphBox(),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final name;
  final image;
  final subTitle;
  final upvotes;

  _InfoCard(this.name, this.image, this.subTitle, this.upvotes);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        height: 160.0,
        width: 140.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: buttonColor.withOpacity(0.8),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0,),
            Container(
              width: 60.0,
              height: 60.0,
              child: Image.asset(image),
            ),
            SizedBox(height: 4.0,),
            Text(
              name,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 2.0,),
            Text(
              subTitle,
              style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12.0),
            ),
            SizedBox(height: 4.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: buttonColor,
                ),

                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.arrow_upward, color: Colors.green, size: 14.0,),
                      Text(upvotes, style: TextStyle(color: Colors.white, fontSize: 12.0),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}