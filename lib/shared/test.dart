import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 160.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _InfoCard('온도', temp, 'Temperature', '1350'),
                _InfoCard('습도', humidity, 'Humidity', '1190'),
                _InfoCard('조도', sun, 'Roughness', '782'),
              ],
            ),
          ),
        ],





      ),
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