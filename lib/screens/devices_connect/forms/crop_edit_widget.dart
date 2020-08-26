import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/services/firebase_provider.dart';
import 'package:smartfarm/services/scan_data.dart';
import 'package:smartfarm/screens/farm_list/farm_list_page.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:http/http.dart' as http;

class CropEditWidget extends StatefulWidget {
  @override
  _CropEditWidgetState createState() => _CropEditWidgetState();
}

class _CropEditWidgetState extends State<CropEditWidget> {
  void _registerDevice() async {
    FirebaseProvider fp = Provider.of<FirebaseProvider>(context, listen: false);
    final scanData = Provider.of<ScanData>(context, listen: false);
    print(fp.getUser().uid);
    final response = await http.post(
      '$API/RegisterDevice',
      body: jsonEncode(
        {"uid": fp.getUser().uid, "uuid": scanData.deviceUUID},
      ),
      headers: {'Content-Type': "application/json"},
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      _createFarm(uid: fp.getUser().uid, uuid: scanData.deviceUUID);
    }
  }

  void _createFarm({String uid, String uuid}) async {
    final response = await http.post(
      '$API/RegisterRecipe',
      body: jsonEncode(
        {
          "uid": uid,
          "uuid": uuid,
          "recipe": {
            "crop": "basil",
            "farm_name": _farmName.text,
            "temperature_min": int.parse(_minTemperatureCon.text),
            "temperature_max": int.parse(_maxTemperatureCon.text),
            "humidity_min": int.parse(_minHumidityCon.text),
            "humidity_max": int.parse(_maxHumidityCon.text),
            "liquid_temperature": int.parse(_liquidTempCon.text),
            "tray_liquid_level": int.parse(_liquidLevCon.text),
            "light": int.parse(_lightCon.text),
            "light_time": int.parse(_lightTimeCon.text),
            "pH_min": int.parse(_minPHCon.text),
            "pH_max": int.parse(_maxPHCon.text),
            "ec_min": int.parse(_minECCon.text),
            "ec_max": int.parse(_maxECCon.text),
            "planting_distance_min_width":
                int.parse(_minPlantDistanceWidth.text),
            "planting_distance_min_height":
                int.parse(_minPlantDistanceHeight.text),
            "planting_distance_max_width":
                int.parse(_maxPlantDistanceWidth.text),
            "planting_distance_max_height":
                int.parse(_maxPlantDistanceHeight.text)
          }
        },
      ),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FarmListPage()));
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _farmName = TextEditingController();
  TextEditingController _cropCon = TextEditingController(); // 작물 품종
  TextEditingController _minTemperatureCon = TextEditingController(); // 최저 온도
  TextEditingController _maxTemperatureCon = TextEditingController(); // 최고 온도
  TextEditingController _minHumidityCon = TextEditingController(); // 최저 습도
  TextEditingController _maxHumidityCon = TextEditingController(); // 최고 습도
  TextEditingController _minPHCon = TextEditingController(); // 최저 pH
  TextEditingController _maxPHCon = TextEditingController(); // 최고 pH
  TextEditingController _minECCon = TextEditingController(); // 최저 EC
  TextEditingController _maxECCon = TextEditingController(); // 최고 EC
  TextEditingController _liquidTempCon = TextEditingController(); // 수온
  TextEditingController _liquidLevCon = TextEditingController(); // 수위
  TextEditingController _lightCon = TextEditingController(); // 조도
  TextEditingController _lightTimeCon = TextEditingController(); // 일조시간
  TextEditingController _minPlantDistanceWidth = TextEditingController();
  TextEditingController _minPlantDistanceHeight = TextEditingController();
  TextEditingController _maxPlantDistanceWidth = TextEditingController();
  TextEditingController _maxPlantDistanceHeight = TextEditingController();

  @override
  void dispose() {
    _farmName.dispose();
    _cropCon.dispose();
    _minTemperatureCon.dispose();
    _maxTemperatureCon.dispose();
    _minHumidityCon.dispose();
    _maxHumidityCon.dispose();
    _minPHCon.dispose();
    _maxPHCon.dispose();
    _minECCon.dispose();
    _maxECCon.dispose();
    _liquidTempCon.dispose();
    _liquidLevCon.dispose();
    _lightCon.dispose();
    _lightTimeCon.dispose();
    _minPlantDistanceWidth.dispose();
    _minPlantDistanceHeight.dispose();
    _maxPlantDistanceWidth.dispose();
    _maxPlantDistanceHeight.dispose();
    super.dispose();
  }

  Widget buildFarmName({TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        Pattern nickNamePattern = r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣0-9]{2,10}$';
        RegExp nickNameRegex = RegExp(nickNamePattern);
        if (value.isEmpty) {
          return '농장 이름을 입력해주세요.';
        } else if (!nickNameRegex.hasMatch(value)) {
          return '영문 및 특수기호 입력은 제한됩니다.';
        } else {
          return null;
        }
      },
      textAlign: TextAlign.center,
      maxLength: 10,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: fieldLineColor, width: 2.5),
        ),
        hintText: '농장 이름을 입력해주세요',
        hintStyle: TextStyle(
          fontSize: 15.0,
          fontFamily: 'NotoSans-Medium',
          color: tutorialFontColor,
        ),
      ),
      onSaved: (String value) {
        //_farmName = value;
      },
    );
  }

  Widget buildInfo({label, TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return '$label(을)를 입력해주세요..';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp('[0-9]')),
      ],
      decoration: cropTextInputDeco,
    );
  }

  Widget buildDistance({TextEditingController controller}) {
    return Container(
      width: 58,
      height: 30,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          WhitelistingTextInputFormatter(RegExp('[0-9]')),
        ],
        validator: (value) {
          if (value.isEmpty) {
            return '값을 입력해주세요.';
          } else {
            return null;
          }
        },
        decoration: cropTextInputDeco,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _cropCon.text = '바질';
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          farmName,
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 110),
                          child: buildFarmName(controller: _farmName),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DropdownButton(
                              //isExpanded: true,
                              elevation: 12,
                              itemHeight: kMinInteractiveDimension + 10,
                              items: ['바질']
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          value,
                                          style: connectFont,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              value: '바질',
                              onChanged: (value) => setState(() {
                                _cropCon.text = value;
                              }),
                            ),
                            buildInput(
                                label1: '최저 온도',
                                label2: '최고 온도',
                                widget1: buildInfo(
                                    label: '온도',
                                    controller: _minTemperatureCon),
                                widget2: buildInfo(
                                    label: '온도',
                                    controller: _maxTemperatureCon)),
                            buildInput(
                                label1: '최저 습도',
                                label2: '최고 습도',
                                widget1: buildInfo(
                                    label: '습도', controller: _minHumidityCon),
                                widget2: buildInfo(
                                    label: '습도', controller: _maxHumidityCon)),
                            buildInput(
                                label1: ' 최저 pH ',
                                label2: ' 최고 pH ',
                                widget1: buildInfo(
                                    label: 'pH', controller: _minPHCon),
                                widget2: buildInfo(
                                    label: 'pH', controller: _maxPHCon)),
                            buildInput(
                                label1: ' 최저 EC ',
                                label2: ' 최고 EC ',
                                widget1: buildInfo(
                                    label: 'EC', controller: _minECCon),
                                widget2: buildInfo(
                                    label: 'EC', controller: _maxECCon)),
                            buildInput(
                                label1: '    수온     ',
                                label2: '    수위     ',
                                widget1: buildInfo(
                                    label: '수온', controller: _liquidTempCon),
                                widget2: buildInfo(
                                    label: '수위', controller: _liquidLevCon)),
                            buildInput(
                                label1: '    조도     ',
                                label2: '일조 시간',
                                widget1: buildInfo(
                                    label: '조도', controller: _lightCon),
                                widget2: buildInfo(
                                    label: '일조 시간', controller: _lightTimeCon)),
                            Text(
                              '재식 거리',
                              style: connectFont,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                buildShortInput(
                                    widget: buildDistance(
                                        controller: _minPlantDistanceWidth)),
                                Text(' X '),
                                buildShortInput(
                                    widget: buildDistance(
                                        controller: _minPlantDistanceHeight)),
                                Text('    ~    '),
                                buildShortInput(
                                    widget: buildDistance(
                                        controller: _maxPlantDistanceWidth)),
                                Text(' X '),
                                buildShortInput(
                                    widget: buildDistance(
                                        controller: _maxPlantDistanceHeight)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildSaveBtn(),
                        buildSaveBtn(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildSaveBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: MaterialButton(
        minWidth: 120,
        height: 40,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _registerDevice();
          }
        },
        color: Colors.greenAccent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          '저장',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NotoSans-Medium',
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget buildShortInput({Widget widget}) {
    return Container(
      width: 66,
      height: 30,
      child: widget,
    );
  }

  Widget buildInput({label1, label2, Widget widget1, Widget widget2}) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              label1,
              style: connectFont,
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 100,
              height: 30,
              child: widget1,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              label2,
              style: connectFont,
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 100,
              height: 30,
              child: widget2,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
