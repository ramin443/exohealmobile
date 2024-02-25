import 'dart:async';
import 'dart:math';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:exohealandroid/getxcontrollers/mainBTController.dart';
import 'package:exohealandroid/screens/sharables/timerpage.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../constants/color_constants.dart';
import '../constants/fontconstants.dart';
import '../datamodels/ExerciseModel.dart';
import '../screens/gamified elements/new_badge.dart';
import '../screens/sharables/chart.dart';
final MainBTController mainBTController = Get.put(MainBTController());

class FullLapController extends GetxController {
  int currentexercise = 0;
  bool loading = false;
  Artboard? riveArtboard;
  StateMachineController? _controller;
  bool isRunning=false;
  bool istimercomplete=false;
  int docreportstatus=0;
  List<SensorValue> data = []; // array to store the values
  int _windowLen = 30 * 6; // window length to display - 6 seconds
  int _fs = 30; // sampling frequency (fps)
  bool _toggled = false; // toggle button value
  int _bpm = 0; // beats per minute
  double _alpha = 0.3;
  Timer? _timer; // timer for image processing
  double? _avg; //// store the average value during calculation

  void _scanImage() {
    DateTime now = DateTime.now();
    if( duration.inSeconds.isEven){
      //  print("even found");
      int randomnumber=Random().nextInt(2);
      double curpos=randomnumber.toDouble();
      _avg=curpos;
      data.add(SensorValue(now, _avg!));
      update();
    }else{
//      print("odd found");
      int rando=Random().nextInt(3);
      double curpo=7+rando.toDouble();
      _avg=curpo;
      data.add(SensorValue(now, _avg!));
      update();
    }
    /*_avg =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;

    */
    if (data.length >= _windowLen) {
      data.removeAt(0);
      update();
    }

  }
  void clearData() {
    // create array of 128 ~= 255/2
    data.clear();
    int now = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < _windowLen; i++)
      data.insert(
          0,
          SensorValue(
              DateTime.fromMillisecondsSinceEpoch(now - i * 1000 ~/ _fs), 128));
  }

  void _updateBPM() async {
    // Bear in mind that the method used to calculate the BPM is very rudimentar
    // feel free to improve it :)

    // Since this function doesn't need to be so "exact" regarding the time it executes,
    // I only used the a Future.delay to repeat it from time to time.
    // Ofc you can also use a Timer object to time the callback of this function
    List<SensorValue> _values;
    double _avg;
    int _n;
    double _m;
    double _threshold;
    double _bpm;
    int _counter;
    int _previous;
    while (_toggled) {

      _values = List.from(data); // create a copy of the current data array
      _avg = 0;
      _n = _values.length;
      _m = 0;
      _values.forEach((SensorValue value) {
        _avg += value.value / _n;
        if (value.value > _m) _m = value.value;
      });
      _threshold = (_m + _avg) / 2;
      _bpm = 0;
      _counter = 0;
      _previous = 0;
      for (int i = 1; i < _n; i++) {
        if (_values[i - 1].value < _threshold &&
            _values[i].value > _threshold) {
          if (_previous != 0) {
            _counter++;
            _bpm += 60 *
                1000 /
                (_values[i].time.millisecondsSinceEpoch - _previous);
          }
          _previous = _values[i].time.millisecondsSinceEpoch;
        }
      }
      if (_counter > 0) {
        _bpm = _bpm / _counter;
        print(_bpm);
        this._bpm = ((1 - _alpha) * this._bpm + _alpha * _bpm).toInt();
        update();
      }
      await Future.delayed(Duration(
          milliseconds:
          1000 * _windowLen ~/ _fs)); // wait for a new set of _data values

    }
  }
  void toggle() {
    clearData();
    _toggled = true;
    update();
    // after is toggled
    _initTimer();
    _updateBPM();
    update();
  }

  void untoggle() {
    reset();
    _toggled = false;
    timer!.cancel();
    update();
  }
  void _initTimer() {

    _timer = Timer.periodic(Duration(milliseconds: 1000 ~/ _fs), (timer) {
      if (_toggled) {

        _scanImage();
      } else {
        timer.cancel();
      }
    });
  }
  void setinitialdocreport(){
    docreportstatus=0;
    update();
  }
  void setsendingdocreport(){
    docreportstatus=1;
    update();
  }
  void setsentdocreport(){
    docreportstatus=2;
    update();
  }

  void initstat(){
    rootBundle.load('assets/animations/exoheal_final_hand (1).riv').then(
          (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'Imagine final');
        if (controller != null) {
          artboard.addController(controller);
       //   isrunning = controller.findInput('Running');

        }
        riveArtboard = artboard;
        setmirrortherapyfalse();
        update();
      },
    );
  }
  void setmirrortherapytrue() {
  //  isrunning!.value=true;
    update();
  }
  void setmirrortherapyfalse() {
   // isrunning!.value=false;
    update();
  }

  String givefingerindex(int index) {
    switch (index) {
      case 0:
        return "Thumb";
      case 1:
        return "Index";
      case 2:
        return "Middle";
      case 3:
        return "Ring";
      case 4:
        return "Pinky";
      default:
        return "";
    }
  }

  static const countdownDuration = Duration(seconds: 120);
  Duration duration = Duration();
  Timer? timer;
  bool timerstarted = false;
  List<ExerciseModel> staticexerciselist = [
    ExerciseModel("exohealgreen", "Finger Tip Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Haptic Exercise Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Mirror Therapy",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Grabbing Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
  ];
  bool countDown = true;

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  updatet() {
    update();
  }

  setcurrentexerciseindex(int index) {
    currentexercise = index;
    update();
  }

  void reset() {
    if (countDown) {
      duration = countdownDuration;
      update();
    } else {
      duration = Duration();
      update();
    }
  }

  void startTimer(BuildContext context) {
    setmirrortherapytrue();
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime(context));
  }
  void settimerfalse(){
    istimercomplete=false;
    update();
  }
  void settimertrue(){
    shutgraph();
    istimercomplete=true;
    update();
  }
  void addTime(BuildContext context) {
    final addSeconds = countDown ? -1 : 1;
    final seconds = duration.inSeconds + addSeconds;
    if (seconds < 0) {
      setmirrortherapyfalse();
      update();
//      Future.delayed(Duration(seconds: 6),settimertrue);
      istimercomplete=true;
      Navigator.push(context, MaterialPageRoute(
          builder: (context)=>NewBadge()
      ));
      clearData();
      timer?.cancel();
    } else {
      duration = Duration(seconds: seconds);
    }
    update();
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer?.cancel();
    update();
  }

  void setcurrentindex(int index) {
    currentexercise = index;
    update();
  }

  Widget pagerow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        top: screenwidth * 0.096,
      ),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: screenwidth * 0.0746,
            width: screenwidth * 0.0746,
            decoration: BoxDecoration(
              color: currentexercise >= 0 ? exohealgreen : darkgrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                child: Text(
                  "1",
                  style: TextStyle(
                      fontFamily: interregular,
                      fontSize: screenwidth * 0.0293,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 2,
            width: screenwidth * 0.106,
            decoration: BoxDecoration(color: Color(0xffEAEAEA)),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: screenwidth * 0.0746,
            width: screenwidth * 0.0746,
            decoration: BoxDecoration(
              color: currentexercise >= 1 ? exohealgreen : darkgrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                child: Text(
                  "2",
                  style: TextStyle(
                      fontFamily: interregular,
                      fontSize: screenwidth * 0.0293,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 2,
            width: screenwidth * 0.106,
            decoration: BoxDecoration(color: Color(0xffEAEAEA)),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: screenwidth * 0.0746,
            width: screenwidth * 0.0746,
            decoration: BoxDecoration(
              color: currentexercise >= 2 ? exohealgreen : darkgrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                child: Text(
                  "3",
                  style: TextStyle(
                      fontFamily: interregular,
                      fontSize: screenwidth * 0.0293,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 2,
            width: screenwidth * 0.106,
            decoration: BoxDecoration(color: Color(0xffEAEAEA)),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: screenwidth * 0.0746,
            width: screenwidth * 0.0746,
            decoration: BoxDecoration(
              color: currentexercise >= 3 ? exohealgreen : darkgrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                child: Text(
                  "4",
                  style: TextStyle(
                      fontFamily: interregular,
                      fontSize: screenwidth * 0.0293,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget timerprogressindicator(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth * 0.06,
      left: screenwidth*0.112,right: screenwidth*0.112),
      child: ProgressBar(
        timeLabelTextStyle: TextStyle(
          color: Color(0xffA8A8A8),
          fontSize: screenwidth*0.0306,
          fontFamily: intermedium
        ),
        barHeight: 6,
        barCapShape: BarCapShape.round,
        thumbColor: exohealgreen,
        thumbCanPaintOutsideBar: false,
        thumbRadius: 0,
        timeLabelPadding: 12,
        timeLabelLocation: TimeLabelLocation.below,
        total: Duration(seconds: 13),
        progress: duration==Duration(seconds: 0)?
        duration:
        (countdownDuration-duration),
        baseBarColor: Color(0xffEAEAEA),
        progressBarColor: exohealgreen,
      )
    );
  }
  Widget timerslider(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return GetBuilder<MainBTController>(
      init: MainBTController(),
      builder: (mainbtcontroller) {
        return Container(
          margin: EdgeInsets.only(top: screenwidth * 0.08),
          child: SleekCircularSlider(
              min: 0,
              max: mainbtcontroller.selectedDuration.inSeconds.toDouble(),
              initialValue:mainbtcontroller.remainingSeconds==0?
              mainbtcontroller.selectedDuration.inSeconds.toDouble():
              mainbtcontroller.remainingSeconds.toDouble(),
              appearance: CircularSliderAppearance(
                  //      size: screenWidth*screenHeight*0.0005347,
                  size: screenwidth * 0.72,
                  //size: 190,
                  animationEnabled: true,
                  spinnerMode: debugInstrumentationEnabled,
                  customWidths: CustomSliderWidths(
                      handlerSize: 0, trackWidth: 6, progressBarWidth: 6),
                  angleRange: 360,
                  startAngle: 135,
                  infoProperties: InfoProperties(
                      topLabelText:
                      /*twoDigits((mainBTController.remainingSeconds*60).remainder(60)) +
                          ":" +
                          twoDigits(mainBTController.remainingSeconds.remainder(60)),*/
                      mainbtcontroller.remainingSeconds==0
                          ?formatDurationtoMin(Duration(seconds: mainbtcontroller.selectedDuration.inSeconds)):
                      formatDurationtoMin(Duration(seconds: mainbtcontroller.remainingSeconds))
                      ,
                      topLabelStyle: TextStyle(
                          fontFamily: interregular,
                          color: Colors.white,
                          fontSize: screenwidth * 0.106),
                      mainLabelStyle: TextStyle(
                          fontFamily: proximanovaregular,
                          color: Colors.white,
                          fontSize: 0)),
                  customColors: CustomSliderColors(
                      trackColor: exohealanotherbggrey,
                      hideShadow: true,
                      progressBarColors: [
                        exohealgreen,
                        exoheallightgreen,
// Color(0xff00D4BE),
// Color(0xff0017A9)
                      ]))),
        );
      }
    );
  }
  String formatDurationtoMin(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
  Widget exercisedetail(BuildContext context, ExerciseModel exerciseModel) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth * 0.0553),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       /*   Container(
            child: Text(
              exerciseModel.exercisetype.toString(),
              style: TextStyle(
                  fontFamily: intersemibold,
                  fontSize: screenwidth * 0.04,
                  color: Color(0xff404040)),
            ),
          ),*/
          Container(
            margin: EdgeInsets.only(
//                top: screenwidth * 0.032,
                left: screenwidth * 0.1033,
                right: screenwidth * 0.1033),
            child: Text(
              exerciseModel.description.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: interregular,
                  fontSize: screenwidth * 0.0296,
                  color: exohealgrey),
            ),
          ),
        ],
      ),
    );
  }

  bool showmessagebox = false;

  setmessageboxtrue() {
    showmessagebox = true;
    update();
  }

  setmessageboxfalse() {
    showmessagebox = false;
    update();
  }

  Widget messagebox(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      margin: EdgeInsets.only(top: screenwidth * 0.0186),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: screenwidth * 0.074),
            child: Text(
              "Cannot find ExoHeal device nearby",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intermedium,
                  color: Colors.redAccent,
                  fontSize: screenwidth * 0.0293),
            ),
          ),
        ],
      ),
    );
  }

  setloadingfalse() {
    loading = false;
    setmessageboxtrue();
    update();
  }

  Widget notconnectedcolumn(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          notconnectedcircle(context),
          showmessagebox
              ? messagebox(context)
              : Container(
                  margin: EdgeInsets.only(
                    top: screenwidth * 0.032,
                  ),
                  child: Text(
                    "Make sure the bluetooth on your device\n"
                    "remains turned on during the exercise",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: intermedium,
                        fontSize: screenwidth * 0.0266,
                        color: Color(0xff989898)),
                  ),
                ),
          GestureDetector(
            onTap: () {
              loading = true;
              update();
              Future.delayed(Duration(seconds: 5), setloadingfalse);
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealgreen,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        "Connect to ExoHeal",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
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

  Widget connectedcolumn(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          connectedcircle(context),
          Container(
            margin: EdgeInsets.only(
              top: screenwidth * 0.032,
            ),
            child: Text(
              "Make sure the bluetooth on your device\n"
              "remains turned on during the exercise",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intermedium,
                  fontSize: screenwidth * 0.0266,
                  color: Color(0xff989898)),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: screenwidth * 0.096),
              child: timerbuttons(context))
        ],
      ),
    );
  }

  Widget timerrunningcolumn(BuildContext context,ExerciseModel exerciseModel) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       /*   Container(
            margin: EdgeInsets.only(
            ),
            child: Text(
              "Make sure the bluetooth on your device\n"
                  "remains turned on during the exercise",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intermedium,
                  fontSize: screenwidth * 0.0266,
                  color: Color(0xff989898)),
            ),
          ), */
          timerslider(context),
      //    timerprogressindicator(context),
          timercontrolbuttons(context,exerciseModel),
     //    sensorygraph(context),
      /*    GestureDetector(
            onTap: () {
              if (currentexercise == 3) {
                stopTimer();
                setcurrentindex(0);
                Navigator.pop(context);
              } else {
                stopTimer();
                setcurrentexerciseindex(currentexercise + 1);
                reset();
                startTimer();
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealgreen,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        currentexercise == 3
                            ? "End Exercise"
                            : "Skip to Next One",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setmirrortherapyfalse();
              stopTimer();
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealdarkgrey,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        "Stop and Disconnect",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.square,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget connectedcircle(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenwidth * 0.48,
        height: screenwidth * 0.48,
        margin: EdgeInsets.only(top: screenwidth * 0.08),
        child: Stack(children: [
          SvgPicture.asset(
            "assets/images/dualhandhome.svg",
            width: screenwidth * 0.48,
          ),
          Container(
            width: screenwidth * 0.48,
            height: screenwidth * 0.48,
            padding: EdgeInsets.only(bottom: screenwidth * 0.112),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    "Status: Connected",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealgreen,
                        fontSize: screenwidth * 0.0293),
                  ),
                )
              ],
            ),
          )
        ]));
  }

  Widget notconnectedcircle(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenwidth * 0.48,
        height: screenwidth * 0.48,
        margin: EdgeInsets.only(top: screenwidth * 0.08),
        child: Stack(children: [
          SvgPicture.asset(
            "assets/images/robotichandhome.svg",
            width: screenwidth * 0.48,
          ),
          Container(
            width: screenwidth * 0.48,
            height: screenwidth * 0.48,
            padding: EdgeInsets.only(bottom: screenwidth * 0.112),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    "Status: Not Connected",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealdarkgrey,
                        fontSize: screenwidth * 0.0293),
                  ),
                )
              ],
            ),
          )
        ]));
  }

  void timerstarts(BuildContext context) async {
    timerstarted = true;
    startTimer(context);
    stopTimer();
    reset();
    startTimer(context);
    toggle();
    update();
  }
  void shutgraph()async{
   stopTimer();
    untoggle();
    update();
  }
  emptychartdata(){
    data.clear();
    update();
  }

  Widget timercontrolbuttons(BuildContext context,ExerciseModel exerciseModel) {
    double screenwidth = MediaQuery.of(context).size.width;
   // final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return GetBuilder<MainBTController>(
      init: MainBTController(),
      builder: (mainbtcontroller) {
        return Container(
          margin: EdgeInsets.only(
              top: screenwidth*0.1053,
             ),
          width: screenwidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)
                    =>TimerSelectionPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: screenwidth * 0.12,
                  ),
                  height: screenwidth * 0.171,
                  width: screenwidth * 0.171,
                  decoration: BoxDecoration(
                      color: exoheallightgreen, shape: BoxShape.circle),
                  child: Icon(
                   FeatherIcons.clock,
                    size: screenwidth * 0.063,
                    color: Colors.white,
                  ),
                ),
              ),
              mainbtcontroller.remainingSeconds!=0
                  ? GestureDetector(
                      onTap: () {
                        if (mainbtcontroller.remainingSeconds!=0) {
                      //    setmirrortherapyfalse();
                          mainbtcontroller.stopCountdown();
                      //    isRunning=false;

                        } else {}
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: screenwidth * 0.12,
                        ),
                        height: screenwidth * 0.171,
                        width: screenwidth * 0.171,
                        decoration: BoxDecoration(
                            color: exohealdarkgrey, shape: BoxShape.circle),
                        child: Icon(
                          CupertinoIcons.xmark,
                          size: screenwidth * 0.063,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        String msg=getStringforExercise(exerciseModel.exercisetype!);
                        mainbtcontroller.startCountdown();
                        mainbtcontroller.sendMessage("b");
                       // timerstarts(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: screenwidth * 0.12),
                        padding: EdgeInsets.only(left: 3),
                        height: screenwidth * 0.171,
                        width: screenwidth * 0.171,
                        decoration: BoxDecoration(
                            color: exohealdarkgrey, shape: BoxShape.circle),
                        child: Icon(
                          CupertinoIcons.play_fill,
                          size: screenwidth * 0.063,
                          color: Colors.white,
                        ),
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  mainbtcontroller.resetTimer();
//              setmirrortherapyfalse()

                },
                child: Container(
                  height: screenwidth * 0.171,
                  width: screenwidth * 0.171,
                  decoration:
                      BoxDecoration(color: exohealdarkgrey, shape: BoxShape.circle),
                  child: Icon(
                    FeatherIcons.rotateCw,
                    size: screenwidth * 0.063,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  String getStringforExercise(String exercisename){
    switch(exercisename){
      case "Finger Tip Exercise":
        return "b";
      case "Haptic Exercise Exercise":
        return "c";
      case "Grabbing Exercise":
        return "d";
      default:
        return "a";
    }
  }
  Widget connectingcolumn(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
            width: screenwidth * 0.48,
            height: screenwidth * 0.48,
            margin: EdgeInsets.only(top: screenwidth * 0.08),
            child: Stack(children: [
              SvgPicture.asset(
                "assets/images/robotichandhome.svg",
                width: screenwidth * 0.48,
              ),
              Container(
                width: screenwidth * 0.48,
                height: screenwidth * 0.48,
                padding: EdgeInsets.only(bottom: screenwidth * 0.112),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "Status: Not Connected",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: exohealdarkgrey,
                            fontSize: screenwidth * 0.0293),
                      ),
                    )
                  ],
                ),
              )
            ])),
        Container(
          width: screenwidth * 0.616,
          margin: EdgeInsets.only(top: screenwidth * 0.0586),
          padding: EdgeInsets.symmetric(vertical: screenwidth * 0.0203),
          decoration: BoxDecoration(
              color: exohealgreen,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenwidth * 0.074),
                  child: Text(
                    "Searching ExoHeal device",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Colors.white,
                        fontSize: screenwidth * 0.032),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenwidth * 0.048),
                  width: screenwidth * 0.0486,
                  height: screenwidth * 0.0486,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    backgroundColor: Colors.white24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget timerbuttons(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
//      margin: EdgeInsets.only(top: screenwidth * 0.12),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              reset();
              startTimer(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealgreen,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        "Start Exercise",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              stopTimer();
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealdarkgrey,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        "Cancel and return",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.xmark,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget individualbutton(
      BuildContext context, Color color, String buttontext, Icon icon) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth * 0.0373),
      width: screenwidth * 0.616,
      padding: EdgeInsets.only(
          top: screenwidth * 0.0203,
          bottom: screenwidth * 0.0203,
          //    left: screenwidth*0.0373,
          right: screenwidth * 0.0373),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
              child: Icon(
                CupertinoIcons.arrow_right,
                size: screenwidth * 0.0186,
                color: Colors.transparent,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.074),
              child: Text(
                buttontext,
                style: TextStyle(
                    fontFamily: intermedium,
                    color: Colors.white,
                    fontSize: screenwidth * 0.032),
              ),
            ),
            Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
  Widget sendingtodoctor(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return   GestureDetector(
    onTap: () {},
    child: Container(
      width: screenwidth * 0.646,
      padding: EdgeInsets.only(
          top: screenwidth * 0.0203,
          bottom: screenwidth * 0.0203,
          //    left: screenwidth*0.0373,
          right: screenwidth * 0.0373),
      decoration: BoxDecoration(
          color: exohealgreen,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
              child: Icon(
                CupertinoIcons.arrow_right,
                size: screenwidth * 0.0186,
                color: Colors.transparent,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.074),
              child: Text(
                docreportstatus==0?
                    "Send report to doctor":
                docreportstatus==1?
                "Sending report to doctor":
                docreportstatus==2?
                "Report sent to doctor":"Send report to doctor",
                style: TextStyle(
                    fontFamily: intermedium,
                    color: Colors.white,
                    fontSize: screenwidth * 0.032),
              ),
            ),
            docreportstatus==2?
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.048),
              child: Icon(FeatherIcons.checkCircle,
                size: 18,
                color: Colors.white,
              ),
            ):
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.048),
              width: screenwidth * 0.0486,
              height: screenwidth * 0.0486,
              child:
              CircularProgressIndicator(
                strokeWidth: 1,
                backgroundColor: Colors.white24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
  Widget exercisedone(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          docreportstatus==0?
          GestureDetector(
            onTap: () {
              setsendingdocreport();
              Future.delayed(Duration(seconds: 2),setsentdocreport);
            },
            child: Container(
              width: screenwidth * 0.646,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealgreen,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        "Send report to doctor",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ):sendingtodoctor(context),
          Container(
            margin: EdgeInsets.only(top: screenwidth * 0.02),
            child: Text(
              "A copy of the report will be sent to the doctor and will be\n"
              "logged on to your progress report.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: interregular,
                  fontSize: screenwidth * 0.0293,
                  color: exohealgrey),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenwidth * 0.016, bottom: screenwidth * 0.016,
            left: screenwidth*0.066,right: screenwidth*0.066
            ),
            width: screenwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenwidth * 0.0586,
                  height: screenwidth * 0.0586,
                  decoration: BoxDecoration(
                      color: exohealdarkgrey, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "1",
                      style: TextStyle(
                          fontFamily: intermedium,
                          fontSize: screenwidth * 0.0293,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenwidth * 0.016),
                  child: Text(
                    "Sensations recorded",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: intermedium,
                        fontSize: screenwidth * 0.0333,
                        color: exohealdarkgrey),
                  ),
                ),
              ],
            ),
          ),
          fingergraph(context),
  /*        Container(
            margin: EdgeInsets.only(
                top: screenwidth * 0.016, bottom: screenwidth * 0.016,
                left: screenwidth*0.066,right: screenwidth*0.066
            ),
            width: screenwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenwidth * 0.0586,
                  height: screenwidth * 0.0586,
                  decoration: BoxDecoration(
                      color: exohealdarkgrey, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "2",
                      style: TextStyle(
                          fontFamily: intermedium,
                          fontSize: screenwidth * 0.0293,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenwidth * 0.016),
                  child: Text(
                    "Sensory Graph",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: intermedium,
                        fontSize: screenwidth * 0.0333,
                        color: exohealdarkgrey),
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }

  Widget fingergraph(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth * 0.866,
      height: screenwidth * 0.365,
      margin: EdgeInsets.only(top: screenwidth*0.0373,bottom: screenwidth*0.0373),
      padding: EdgeInsets.symmetric(
          vertical: screenwidth * 0.0426, horizontal: screenwidth * 0.0746),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0xffABABAB).withOpacity(0.15),
                blurRadius: 10,
                offset: Offset(0, 0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          fingercolumn(context, 40, 0),
          fingercolumn(context, 50, 1),
          fingercolumn(context, 100, 2),
          fingercolumn(context, 20, 3),
          fingercolumn(context, 60, 4),
        ],
      ),
    );
  }

  Widget fingercolumn(BuildContext context, int sensationsheight, int index) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: screenwidth * 0.0186,
            height: screenwidth * 0.208,
            decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: screenwidth * 0.0186,
                  height: screenwidth * 0.208* (sensationsheight / 100),
                  decoration: BoxDecoration(
                    color: sensationsheight == 100
                        ? Color(0xff4CA852)
                        : Color(0xffF5A491),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenwidth * 0.0313),
            child: Text(
              givefingerindex(index),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intermedium,
                  fontSize: screenwidth * 0.028,
                  color: darkgrey),
            ),
          )
        ],
      ),
    );
  }
  Widget mirrortherapyanim(BuildContext context){
    return Center(
        child: riveArtboard == null
            ? const SizedBox()
            : Container(
          width: 312,
          height: 250,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white12, width: 10)),
          child: Rive(
              alignment: Alignment.center,
              artboard: riveArtboard!),
        ),
      );
  }
  Widget showindivhand(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth*0.0906,
      bottom: screenwidth*0.0666),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/handdone.svg",
            width:screenwidth*0.35,),
        ],
      ),
    );
  }
  Widget showindivhandwithsensations(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth*0.0906,
          bottom: screenwidth*0.0509),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/handdonewithsensations.svg",
            width:screenwidth*0.35,),
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.0266),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: intermedium,
                  color: darkgrey,
                  fontSize: screenwidth*0.0293
                ),
                children: [
                  TextSpan(
                    text: "Mirror Therapy Completed on\n"
                  ),
                  TextSpan(
                      text: DateFormat.yMMMMd('en_US').format(DateTime.now()),
                    style:TextStyle(
                      fontFamily: intersemibold,
                      color: exohealgreen,
                      fontSize: screenwidth*0.0293
                  ),
                  ),
                  TextSpan(
                    text: " at ", style:TextStyle(
                      fontFamily: intersemibold,
                      color: exohealgreen,
                      fontSize: screenwidth*0.0293
                  ),
                  ),
                  TextSpan(
                    text: DateFormat.jm('en_US').format(DateTime.now())+".",
                    style:TextStyle(
                        fontFamily: intersemibold,
                        color: exohealgreen,
                        fontSize: screenwidth*0.0293
                    ),
                  ),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget exerciserunning(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(

    );
  }
  Widget exercisenotstartedstate(BuildContext context,ExerciseModel exerciseModel){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        timercontrolbuttons(context,exerciseModel),
        timerbuttons(context)
        //   exerciserunning(context),
      ],
    );
  }

  Widget exerciserunningstate(BuildContext context,ExerciseModel exerciseModel){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       // mirrortherapyanim(context),
        timerrunningcolumn(context,exerciseModel),

     //   exerciserunning(context),
      ],
    );
  }

  Widget exercisecompletedstate(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       showindivhandwithsensations(context),
        exercisedone(context),
      ],
    );
  }
  Widget sensorygraph(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: screenwidth*0.072,
                top: screenwidth*0.036,
                bottom: screenwidth*0.024),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text("Sensory Graph",style: TextStyle(
                      color: darkgrey,
                      fontFamily: intersemibold,
                      fontSize: screenwidth*0.042
                  )),
                ),
              ],
            ),
          ),
          Stack(
              children:[
                Container(
                  height: screenwidth*0.384,
                  width: screenwidth*0.8666,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: Color(0xffF8F4F0),
                      boxShadow: [BoxShadow(blurRadius: 10,
                          offset: Offset(0,0),color: Colors.black.withOpacity(0.08))]
                  ),
                  child: Chart(
                      data),
                ),
                Container(
                  height: screenwidth*0.384,
                  width: screenwidth*0.8666,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: SvgPicture.asset("assets/images/Vector 274.svg",
                          height: screenwidth*0.384,
                        ),
                      ),
                      Container(
                        child: SvgPicture.asset("assets/images/Vector 274.svg",
                          height: screenwidth*0.384,
                        ),
                      ),
                      Container(
                        child: SvgPicture.asset("assets/images/Vector 274.svg",
                          height: screenwidth*0.384,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: screenwidth*0.384,
                  width: screenwidth*0.8666,
                  padding: EdgeInsets.only(bottom: screenwidth*0.016),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text("0 s",style: TextStyle(
                            color: Color(0xff989898),
                            fontFamily: interregular,
                            fontSize: screenwidth*0.028
                        )),
                      ),
                      Container(
                        child: Text("3.7 s",style: TextStyle(
                            color: Color(0xff989898),
                            fontFamily: interregular,
                            fontSize: screenwidth*0.028
                        )),
                      ),
                      Container(
                        child: Text("7.5 s",style: TextStyle(
                            color: Color(0xff989898),
                            fontFamily: interregular,
                            fontSize: screenwidth*0.028
                        )),
                      ),
                      Container(
                        child: Text("10.7 s",style: TextStyle(
                            color: Color(0xff989898),
                            fontFamily: interregular,
                            fontSize:screenwidth*0.028
                        )),
                      ),
                      Container(
                        child: Text("15 s",style: TextStyle(
                            color: Color(0xff989898),
                            fontFamily: interregular,
                            fontSize: screenwidth*0.028
                        )),
                      ),

                    ],
                  ),
                )
              ]
          ),

          Container(
            margin: EdgeInsets.only(top: screenwidth*0.024),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Time (total: 15 s)",
                    style: TextStyle(
                        fontFamily: intermedium,
                        fontSize: screenwidth*0.0293,
                        color:exohealgreen),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenwidth*0.0266),
                  child: Icon(
                    CupertinoIcons.arrow_right,
                    color:exohealgreen,
                    size: screenwidth*0.0373,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class DurationState {
  const DurationState({this.progress, this.buffered, this.total});
  final Duration? progress;
  final Duration? buffered;
  final Duration? total;
}