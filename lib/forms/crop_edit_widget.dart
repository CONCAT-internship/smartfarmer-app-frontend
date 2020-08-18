import 'package:flutter/material.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class CropEditWidget extends StatefulWidget {
  @override
  _CropEditWidgetState createState() => _CropEditWidgetState();
}

class _CropEditWidgetState extends State<CropEditWidget> {
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
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
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
                        child: TextFormField(
                          controller: _farmName,
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: fieldLineColor, width: 2.5),
                            ),
                            hintText: '농장 이름을 입력해주세요',
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'NotoSans-Medium',
                              color: tutorialFontColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
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

                            items: ['바질', '야채']
                                .map<DropdownMenuItem<String>>(
                                  (value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: '바질',
                            onChanged: (value) => setState(() {}),
                          ),
//                          makeInput(
//                              label: '작물',
//                              editingController: _cropCon),
                          limitInput(
                              prop: '온도',
                              minControl: _minTemperatureCon,
                              maxControl: _maxTemperatureCon),
                          limitInput(
                              prop: '습도',
                              minControl: _minHumidityCon,
                              maxControl: _maxHumidityCon),
                          limitInput(
                              prop: 'pH  ',
                              minControl: _minPHCon,
                              maxControl: _maxPHCon),
                          limitInput(
                              prop: 'EC   ',
                              minControl: _minECCon,
                              maxControl: _maxECCon),
                          makeInputDuo(
                              prop: '수온',
                              leftCon: _liquidTempCon,
                              prop2: '수위',
                              rightCon: _liquidLevCon),
                          makeInputDuo(
                              prop: '조도',
                              leftCon: _lightCon,
                              prop2: '일조',
                              rightCon: _lightTimeCon),
                          Text(
                            '재식 거리',
                            style: connectFont,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              makeShortInput(
                                  editingController: _minPlantDistanceWidth),
                              Text(' X '),
                              makeShortInput(
                                  editingController: _minPlantDistanceHeight),
                              Text('    ~    '),
                              makeShortInput(
                                  editingController: _maxPlantDistanceWidth),
                              Text(' X '),
                              makeShortInput(
                                  editingController: _maxPlantDistanceHeight),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: MaterialButton(
                      minWidth: 160,
                      height: 40,
                      onPressed: () {},
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeInputDuo(
      {prop,
      prop2,
      TextEditingController leftCon,
      TextEditingController rightCon}) {
    return Row(
      children: <Widget>[
        makeInput(label: prop, editingController: leftCon),
        SizedBox(
          width: 23,
        ),
        makeInput(label: prop2, editingController: rightCon),
      ],
    );
  }

  Widget limitInput({prop, TextEditingController minControl, TextEditingController maxControl}) {
    return Row(
      children: <Widget>[
        makeInput(label: prop, editingController: minControl),
        Text('       ~   '),
        makeInput(label: '', editingController: maxControl),
      ],
    );
  }

  Widget makeShortInput({TextEditingController editingController}) {
    return Container(
      width: 58,
      height: 30,
      child: TextFormField(
        controller: editingController,
        decoration: InputDecoration(
          suffixText: "dd",
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(30),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, TextEditingController editingController}) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              label,
              style: connectFont,
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 100,
              height: 30,
              child: TextFormField(
                controller: editingController,
                decoration: InputDecoration(
                  suffixText: "dd",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
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
