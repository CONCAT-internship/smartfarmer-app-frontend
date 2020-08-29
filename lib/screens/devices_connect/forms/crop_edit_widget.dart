import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/services/api/register_device.dart';
import 'package:smartfarm/services/firebase_provider.dart';
import 'package:smartfarm/services/scan_data.dart';
import 'package:smartfarm/screens/farm_list/farm_list_page.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/utils/snack_bar.dart';

class CropEditWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CropEditWidget({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _CropEditWidgetState createState() => _CropEditWidgetState();
}

class _CropEditWidgetState extends State<CropEditWidget> {
  bool isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    widget.scaffoldKey.currentState
      ..hideCurrentSnackBar();
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
                                leftLabel: '최저 온도',
                                rightLabel: '최고 온도',
                                leftTF: buildInfo(
                                    label: '온도',
                                    controller: _minTemperatureCon),
                                rightTF: buildInfo(
                                    label: '온도',
                                    controller: _maxTemperatureCon)),
                            buildInput(
                                leftLabel: '최저 습도',
                                rightLabel: '최고 습도',
                                leftTF: buildInfo(
                                    label: '습도', controller: _minHumidityCon),
                                rightTF: buildInfo(
                                    label: '습도', controller: _maxHumidityCon)),
                            buildInput(
                                leftLabel: ' 최저 pH ',
                                rightLabel: ' 최고 pH ',
                                leftTF: buildInfo(
                                    label: 'pH', controller: _minPHCon),
                                rightTF: buildInfo(
                                    label: 'pH', controller: _maxPHCon)),
                            buildInput(
                                leftLabel: ' 최저 EC ',
                                rightLabel: ' 최고 EC ',
                                leftTF: buildInfo(
                                    label: 'EC', controller: _minECCon),
                                rightTF: buildInfo(
                                    label: 'EC', controller: _maxECCon)),
                            buildInput(
                                leftLabel: '    수온     ',
                                rightLabel: '    수위     ',
                                leftTF: buildInfo(
                                    label: '수온', controller: _liquidTempCon),
                                rightTF: buildInfo(
                                    label: '수위', controller: _liquidLevCon)),
                            buildInput(
                                leftLabel: '    조도     ',
                                rightLabel: '일조 시간',
                                leftTF: buildInfo(
                                    label: '조도', controller: _lightCon),
                                rightTF: buildInfo(
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
                        buildSaveBtn(widget.scaffoldKey),
                        defaultBtn(widget.scaffoldKey),
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

  Widget buildFarmName({TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        Pattern nickNamePattern = r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,10}$';
        RegExp nickNameRegex = RegExp(nickNamePattern);
        if (value.isEmpty) {
          return '농장 이름을 입력해주세요.';
        } else if (!nickNameRegex.hasMatch(value)) {
          return '한글로 입력해주세요.';
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
        WhitelistingTextInputFormatter(RegExp(r'(^\d*\.?\d*)')),
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
          WhitelistingTextInputFormatter(RegExp(r'(^\d*\.?\d*)')),
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

  Padding buildSaveBtn(GlobalKey<ScaffoldState> key) {
    final fp = Provider.of<FirebaseProvider>(context, listen: false);
    final scanData = Provider.of<ScanData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: MaterialButton(
        minWidth: 120,
        height: 40,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            key.currentState
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                duration: Duration(seconds: 10),
                content: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("   농장과 연결 중입니다.")
                  ],
                ),
              ));

            final uid = fp.getUser().uid; // 현재 로그인 한 사용자 uid
            final uuid = scanData.deviceUUID; // scanner_widget에서 스캔한 QR코드 값

            final result =
                await registerFarm.registerDevice(uid: uid, uuid: uuid);
            if (!result.error) {
              _createFarm(uid: uid, uuid: uuid);
            } else {
              alertSnackbar(context, result.errorMessage);
            }
          } else {
            alertSnackbar(context, '입력란을 제대로 작성해주세요.');
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

  Padding defaultBtn(GlobalKey<ScaffoldState> key) {
    final fp = Provider.of<FirebaseProvider>(context, listen: false);
    final scanData = Provider.of<ScanData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: MaterialButton(
        minWidth: 120,
        height: 40,
        onPressed: () async {
            key.currentState
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("   농장과 연결 중입니다.")
                ],
              ),
            ));

          final uid = fp.getUser().uid; // 현재 로그인 한 사용자 uid
          final uuid = scanData.deviceUUID; // scanner_widget에서 스캔한 QR코드 값

          final result =
              await registerFarm.registerDevice(uid: uid, uuid: uuid);
          if (!result.error) {
            _defaultCreateFarm(uid: uid, uuid: uuid);
          } else {
            alertSnackbar(context, result.errorMessage);
          }

          if(!isLoading){
            key.currentState.hideCurrentSnackBar();
          }
        },
        color: infoBoxHumidityColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          '기본값',
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

  Widget buildInput({leftLabel, rightLabel, Widget leftTF, Widget rightTF}) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              leftLabel,
              style: connectFont,
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 100,
              height: 30,
              child: leftTF,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              rightLabel,
              style: connectFont,
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 100,
              height: 30,
              child: rightTF,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
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
            "temperature_min": num.parse(_minTemperatureCon.text),
            "temperature_max": num.parse(_maxTemperatureCon.text),
            "humidity_min": num.parse(_minHumidityCon.text),
            "humidity_max": num.parse(_maxHumidityCon.text),
            "liquid_temperature": num.parse(_liquidTempCon.text),
            "tray_liquid_level": num.parse(_liquidLevCon.text),
            "light": num.parse(_lightCon.text),
            "light_time": num.parse(_lightTimeCon.text),
            "pH_min": num.parse(_minPHCon.text),
            "pH_max": num.parse(_maxPHCon.text),
            "ec_min": num.parse(_minECCon.text),
            "ec_max": num.parse(_maxECCon.text),
            "planting_distance_min_width":
                num.parse(_minPlantDistanceWidth.text),
            "planting_distance_min_height":
                num.parse(_minPlantDistanceHeight.text),
            "planting_distance_max_width":
                num.parse(_maxPlantDistanceWidth.text),
            "planting_distance_max_height":
                num.parse(_maxPlantDistanceHeight.text)
          }
        },
      ),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => FarmListPage()), (Route<dynamic> route) => false);
      final scanData = Provider.of<ScanData>(context, listen: false);
      scanData.setDeviceUUID('');
      scanData.setScan(false);
    }
  }

  void _defaultCreateFarm({String uid, String uuid}) async {
    isLoading = true;
    final response = await http.post(
      '$API/RegisterRecipe',
      body: jsonEncode(
        {
          "uid": uid,
          "uuid": uuid,
          "recipe": {
            "crop": "basil",
            "farm_name": '농장',
            "temperature_min": 25,
            "temperature_max": 30,
            "humidity_min": 50,
            "humidity_max": 60,
            "liquid_temperature": 20,
            "tray_liquid_level": 10,
            "light": 70,
            "light_time": 16,
            "pH_min": 6.0,
            "pH_max": 6.5,
            "ec_min": 1.0,
            "ec_max": 1.5,
            "planting_distance_min_width": 20,
            "planting_distance_min_height": 20,
            "planting_distance_max_width": 25,
            "planting_distance_max_height": 25
          }
        },
      ),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200) {
      isLoading = false;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FarmListPage()));
      final scanData = Provider.of<ScanData>(context, listen: false);
      scanData.setDeviceUUID('');
      scanData.setScan(false);
    }
  }
}
