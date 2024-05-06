import 'dart:async';
import 'dart:convert';

import 'package:exohealandroid/constants/color_constants.dart';
import 'package:exohealandroid/datamodels/ExerciseModel.dart';
import 'package:exohealandroid/getxcontrollers/fulllapcontroller.dart';
import 'package:exohealandroid/screens/base/base.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../constants/fontconstants.dart';
class MainBTController extends GetxController{
  bool isscanning = false;
  String mainscantitle = "Scan and Connect";
  String btntxt= "Scan and Connect";
  StreamSubscription<BluetoothDiscoveryResult>? discoveryStreamSubscription;
  bool isDiscovering = false;
  List<_DeviceWithAvailability> devices =
  List<_DeviceWithAvailability>.empty(growable: true);
  bool foundDevice=false;
  String disconnectedtext='';
  BluetoothConnection? connection;
  String connectstatustext = 'stat';
  int backspacesCounter = 0;
  String _messageBuffer = '';
  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);
  bool isDisconnecting = false;
  List<_Message> messages = List<_Message>.empty(growable: true);
  static final clientID = 0;
  Duration selectedDuration = Duration(minutes: 5);

  late Timer countdownTimer;
  int remainingSeconds = 0;
  String maintime="0";
  int timetapped=0;
  ScrollController scrollController=ScrollController();
  bool isExohealConnected=false;

  void setconnectedTrue(){
    isExohealConnected=true;
    update();
  }
  void setconnectedFalse(){
    isExohealConnected=false;
    update();
  }
  void setdisconnectedtext(String txt){
    disconnectedtext=txt;
    update();
  }

  void settime(int time){
    timetapped=time;
    maintime='$time m';
    scrollController.animateTo(time/30*scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 350),
        curve: Curves.ease
    );
    update();
  }
  void resetTimer(){
    stopCountdown();
    startCountdown();
  }
  Widget timerwidget(BuildContext context){
    double screenwidth = MediaQuery.sizeOf(context).width;
    return Center(
      child: SingleChildScrollView(

        child: Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: Text(maintime,style: TextStyle(
                  fontFamily: gilroymediumd,
                  color: Colors.black,
//  fontSize: 75
                  fontSize: screenwidth*0.2
              ),textAlign: TextAlign.center,),),
              Container(
                child: Text("min",style: TextStyle(
                    fontFamily: interregular,
                    color: Colors.black.withOpacity(0.6),
                    //       fontSize: 17
                    fontSize: screenwidth*0.0453
                ),textAlign: TextAlign.center,),
              ),
              Container(
                margin: EdgeInsets.only(
                  //         top: 5,bottom: 8.5
                    top: screenwidth*0.0133,bottom: screenwidth*0.0226
                ),
                //      height: 14,width: 14,
                height: screenwidth*0.0373,width: screenwidth*0.0373,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,
                      colors: [Colors.black87,Color(0xffefefef).withOpacity(0.4)]
                  ),              shape: BoxShape.circle,

                ),),
              ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback:  (Rect bounds) {

                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,

                      colors: [Colors.white30, Colors.white30],
                    ).createShader(bounds);
                  },
                  child:
                  Container(
                    margin: EdgeInsets.only(
                      //       bottom: 12.5
                        bottom: screenwidth*0.033
                    ),
                    height: screenwidth*0.3173,
                    width: screenwidth,
                    child: ListView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          //    width: 175,
                          width: screenwidth*0.466,
                        ),
                        for(int i=1;i<=12;i++)
                          Container(
                            margin: EdgeInsets.symmetric(
                              //        horizontal: 12.5
                                horizontal: screenwidth*0.033
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  //    width: 2,height: 83,
                                  width:screenwidth*0.00533,height: screenwidth*0.221,
                                  decoration: BoxDecoration(
                                    color: exoheallightgreen,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    //         horizontal: 25
                                      horizontal: screenwidth*0.0666
                                  ),
                                  //    width: 2,height: 39.5,
                                  width:screenwidth*0.00533,height: screenwidth*0.1053,
                                  decoration: BoxDecoration(
                                    color: exoheallightgreen,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    //        right: 25
                                      right: screenwidth*0.0666
                                  ),
                                  //  width: 2,height: 39.5,
                                  width:screenwidth*0.00533,height: screenwidth*0.1053,
                                  decoration: BoxDecoration(
                                    color: exoheallightgreen,
                                  ),
                                ),
                                Container(
                                  //   width: 2,height: 39.5,
                                  width:screenwidth*0.00533,height: screenwidth*0.1053,

                                  decoration: BoxDecoration(
                                    color: exoheallightgreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Container(
                          //       width:175,
                          width: screenwidth*0.466,
                        ),

                      ],
                    ),
                  )),

              Icon(CupertinoIcons.triangle_fill,
                color: exoheallightgreen,
                //  size: 22,
                size: screenwidth*0.0586,
              ),
              Container(
                margin: EdgeInsets.only(
                  //      top: 35,bottom: 30
                    top: screenwidth*0.0933,bottom: screenwidth*0.08
                ),
                child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                  GestureDetector(
                      onTap: (){
                        timetapped=5;
                        maintime='5m';
                        scrollController.animateTo(5/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease
                        );
                        update();
                      },
                      child:
                      AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        //     height: 48,width: 48,
                        height: screenwidth*0.128,width: screenwidth*0.128,
                        decoration: BoxDecoration(
                            color: timetapped==5?exohealanotherbggrey:Colors.black38,
                            shape: BoxShape.circle
                        ),
                        child: Center(child:Text("5",style: TextStyle(
                            fontFamily: interregular,
                            color:timetapped==5?exoheallightgreen: Colors.white,
                            //       fontSize: 15
                            fontSize: screenwidth*0.04
                        ),)),
                      )),
                  GestureDetector(
                      onTap: (){
                        timetapped=10;
                        maintime='10m';
                        scrollController.animateTo(10/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease
                        );
                      },
                      child:
                      AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        //       height: 48,width: 48,
                        height: screenwidth*0.128,width: screenwidth*0.128,
                        decoration: BoxDecoration(
                            color: timetapped==10?Colors.white:Colors.white30,
                            shape: BoxShape.circle
                        ),
                        child: Center(child:Text("10",style: TextStyle(
                            fontFamily: interregular,
                            color:timetapped==10?exoheallightgreen: Colors.white,
                            //fontSize: 15
                            fontSize: screenwidth*0.04
                        ),)),
                      )),
                  GestureDetector(
                      onTap: (){
                        timetapped=15;
                        maintime='15m';
                        scrollController.animateTo(15/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease
                        );
                        update();
                      },
                      child:
                      AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        //      height: 48,width: 48,
                        height: screenwidth*0.128,width: screenwidth*0.128,
                        decoration: BoxDecoration(
                            color: timetapped==15?Colors.white:Colors.white30,
                            shape: BoxShape.circle
                        ),
                        child: Center(child:Text("15",style: TextStyle(
                            fontFamily: interregular,
                            color: timetapped==15?exoheallightgreen:Colors.white,
                            //        fontSize: 15
                            fontSize: screenwidth*0.04
                        ),)),
                      )),
                  GestureDetector(
                      onTap: (){
                        timetapped=45;
                        scrollController.animateTo(45/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease
                        );
                        maintime='45m';

                        update();
                      },
                      child:
                      AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        //   height: 48,width: 48,
                        height: screenwidth*0.128,width: screenwidth*0.128,
                        decoration: BoxDecoration(
                            color: timetapped==45?Colors.white:Colors.white30,
                            shape: BoxShape.circle
                        ),
                        child: Center(child:Text("45",style: TextStyle(
                            fontFamily: interregular,
                            color: timetapped==45?exoheallightgreen:Colors.white,
                            //ontSize: 15
                            fontSize: screenwidth*0.04
                        ),)),
                      )),
                  GestureDetector(
                      onTap: (){
                        timetapped=90;
                        scrollController.animateTo(89/720*scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 350),
                            curve: Curves.ease
                        );
                        maintime='1h 30m';

                        update();
                      },
                      child:
                      AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        //     height: 48,width: 48,
                        height: screenwidth*0.128,width: screenwidth*0.128,
                        decoration: BoxDecoration(
                            color: timetapped==90?Colors.white:Colors.white30,
                            shape: BoxShape.circle
                        ),
                        child: Center(child:Text("90",style: TextStyle(
                            fontFamily: interregular,
                            color:timetapped==90?exoheallightgreen: Colors.white,
                            //fontSize: 15
                            fontSize: screenwidth*0.04
                        ),)),
                      )),
                ],),
              ),
              GestureDetector(
                  onTap: (){

                  },
                  child:
                  AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    //    height: 110,width: 110,
                    height: screenwidth*0.2933,width: screenwidth*0.2933,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Center(child:Text("SET",style: TextStyle(
                        fontFamily: intersemibold,
                        color:exoheallightgreen,
                        //     fontSize: 46
                        fontSize: screenwidth*0.1026
                    ),)),
                  )),
            ],),
        ),
      ),);
  }
  scrollListener() {
    timetapped=(scrollController.offset/scrollController.position.maxScrollExtent*30).round().toInt();
    maintime=(scrollController.offset/scrollController.position.maxScrollExtent*30).toStringAsFixed(0)+"m";
    if(maintime.substring(0,1)=="-"){

      maintime="0m";
    }else if(maintime.substring(0,2)=="31"|| maintime.substring(0,2)=="32"){
      maintime="30m";
    }
    update();

    print(maintime);
  }
  void setdurationandstartCountdown(BuildContext context){
    selectedDuration=Duration(minutes: timetapped);
    int setdurationinseconds=timetapped*60;
    // startCountdown();
    update();
    Navigator.pop(context);
  }
  void startCountdown() {
    remainingSeconds = selectedDuration.inSeconds;
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
      } else {
        countdownTimer.cancel();
      }
      update();
    });
    update();
  }
  void stopCountdown() {
    countdownTimer.cancel();
    remainingSeconds = 0;
    update();
  }

  void setdiscoveringTrue(){
    isDiscovering = true;
    update();
  }
  void setdiscoveringFalse(){
    isDiscovering = false;
    update();
  }

  void setfoundDeviceTrue(){
    foundDevice = true;
    update();
  }
  void setfoundDeviceFalse(){
    foundDevice = false;
    update();
  }

  void checkifDeviceBonded(){
    if(devices.any((element) => element.device.name=="ExoHeal")){
      setfoundDeviceTrue();
      print("Found exoheal");
    }
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      devices = bondedDevices
          .map(
            (device) => _DeviceWithAvailability(
          device,
          _DeviceAvailability.yes,
        ),
      )
          .toList();
      update();
    });

    if(!foundDevice){
      startDiscovery();
    }

  }

  void startDiscovery() async{
    var bluetoothScanstatus = await Permission.bluetoothScan.status;
    var bluetoothConnectstatus = await Permission.bluetoothConnect.status;
    var bluetoothstatus = await Permission.bluetooth.status;

    if(bluetoothScanstatus.isDenied){
      await Permission.bluetoothScan.request();
    }
    if(bluetoothConnectstatus.isDenied){
      await Permission.bluetoothConnect.request();
    }
    if(bluetoothstatus.isDenied){
      await Permission.bluetooth.request();
    }
    update();
    discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
          Iterator i = devices.iterator;
          while (i.moveNext()) {
            var device = i.current;
            if (device.device == r.device) {
              device.availability = _DeviceAvailability.yes;
              device.rssi = r.rssi;
            }
            if(device.device.name=="ExoHeal"){
              print("Found Exoheal here within start Discovery");
              setfoundDeviceTrue();
            }
          }
          update();
        });

    discoveryStreamSubscription?.onDone(() {
      setdiscoveringFalse();
    });
  }

  List<ExerciseModel> exercises=[
    ExerciseModel("", "Finger Tip Exercise", "_description", "_duration"),
    ExerciseModel("", "Haptic Exercise Tip", "_description", "_duration"),
    ExerciseModel("", "Mirror Therapy", "_description", "_duration"),

  ];
  void setscanningtrue() {
    isscanning = true;
    update();
  }
  void updatebtntxt(){
    if(isscanning){
      btntxt= "Searching nearby...";
    }else{
      btntxt= "Scan and Connect";
    }
    update();
  }
  void checkandsetDevicesNotFoundNearby(){
    if(!foundDevice){
      //cancel animation
      setscanningfalse();
      mainscantitle="No Device Found Nearby";
      btntxt="Try Searching Again";
      update();
    }else{
      setscanningfalse();
      mainscantitle="Exoheal Found";
      btntxt="C O N N E C T";
      update();
    }
  }

  Widget getactivescanbutton(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return isscanning
        ? scanningdevicesbutton(context)
        : scandevicesbutton(context);
  }
  void searchandconnect(){
    print("We're here");
    checkifDeviceBonded();
    Future.delayed(Duration(seconds: 8),checkandsetDevicesNotFoundNearby);
  }
  void checkifNotConnectedthenConnect(bool isConnected){
    if(!isConnected){
      BluetoothConnection.toAddress("00:22:03:01:19:F9").then((_connection) {
        print('Connected to the device');
        connection = _connection;
        setconnectedTrue();
        print(connection!.input);
        connectstatustext = backspacesCounter > 0
            ? _messageBuffer.substring(
            0, _messageBuffer.length - backspacesCounter)
            : _messageBuffer;
        isConnecting = false;
        isDisconnecting = false;
        update();

        connection!.input!.listen(_onDataReceived).onDone(() {
          // Example: Detect which side closed the connection
          // There should be `isDisconnecting` flag to show are we are (locally)
          // in middle of disconnecting process, should be set before calling
          // `dispose`, `finish` or `close`, which all causes to disconnect.
          // If we except the disconnection, `onDone` should be fired as result.
          // If we didn't except this (no flag set), it means closing by remote.
          if (isDisconnecting) {
            setconnectedFalse();
            print('Disconnecting locally!');
            setdisconnectedtext('Disconnecting locally!');
          } else {
            setconnectedFalse();
            print('Disconnected remotely!');
            setdisconnectedtext('Disconnecting remotely !');
          }

        });
      }).catchError((error) {
        print('Cannot connect, exception occured');
        print(error);
      });
    }

  }
  void connectToExoheal(BluetoothDevice bluetoothDevice){
    print("Bluetooth address is:\n");
    print(bluetoothDevice.address);
    BluetoothConnection.toAddress(bluetoothDevice.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setconnectedTrue();
      print(connection!.input);
      connectstatustext = backspacesCounter > 0
          ? _messageBuffer.substring(
          0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer;
      isConnecting = false;
      isDisconnecting = false;
      update();

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          setconnectedFalse();
          print('Disconnecting locally!');
        } else {
          setconnectedFalse();
          print('Disconnected remotely!');

        }

      });
    }).catchError((error) {

      print('Cannot connect, exception occured');
      print(error);
    });
  }
  void sendMessage(String text) async {

    print("were here");
    text = text.trim();
    // textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

        messages.add(_Message(clientID, text));
        update();

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          /*  listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);*/
        });
      } catch (e) {
        // Ignore error, but notify state
        update();
      }
    }
  }
  void checkandsendmessage(String msg){
    if(!isConnected){
      sendMessage(msg);
    }else{
      searchandconnect();
      if(foundDevice){
        BluetoothDevice exohealdevice=devices[0].device;
        for(var dev in devices){
          if(dev.device.name=="ExoHeal"){
            exohealdevice=dev.device;
          }
        }
        connectToExoheal(exohealdevice);
      }
      sendMessage(msg);

    }
  }
  Widget testbuttonrow(BuildContext context){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: (){
              sendMessage("b");
            }, child: Text("Haptic Exercise",
              style: TextStyle(
                  fontFamily: intermedium,
                  color: Colors.white
              ),
            ),),
            ElevatedButton(onPressed: (){
              sendMessage("c");
            }, child: Text("Finger Tip Exercise",
              style: TextStyle(
                  fontFamily: intermedium,
                  color: Colors.white
              ),
            ),),



          ],
        ),
        Row(
          children: [
            ElevatedButton(onPressed: (){

              sendMessage("d");
            }, child: Text("Third Exercise",
              style: TextStyle(
                  fontFamily: intermedium,
                  color: Colors.white
              ),
            ),),

            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Base()));
            }, child: Text("GO to Base ",
              style: TextStyle(
                  fontFamily: intermedium,
                  color: Colors.white
              ),
            ),),
          ],
        ),
      ],
    );
  }
  void callIsConnected(){
    if(isConnected){}
    update();
  }
  Widget scandevicesbutton(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if(foundDevice){
          BluetoothDevice exohealdevice=devices[0].device;
          for(var dev in devices){
            if(dev.device.name=="ExoHeal"){
              exohealdevice=dev.device;
            }
          }
          connectToExoheal(exohealdevice);
          // callIsConnected();
          //  isConnected=isConnected;
          // Navigator.pop(context);
        }else{
          updatebtntxt();
          switchscantitle(context);
          setscanningtrue();
          searchandconnect();
        }

        //  searchandconnect();
        // delayScanStop(); //  print(unconnecteddevicecontainers);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.0426),
        width: screenwidth * 0.549,
        height: screenwidth * 0.104,
        decoration: BoxDecoration(
            color: exohealnewpurple,
            borderRadius: BorderRadius.all(Radius.circular(22))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*  Icon(
              FeatherIcons.eye,
              size: screenwidth * 0.0586,
              color: Colors.white,
            ),*/
            Container(
              //   width: screenwidth * 0.429,
              //    margin: EdgeInsets.only(left: screenwidth*0.050),
              child: Text(
                btntxt,
                textAlign: TextAlign.center,
                maxLines: 1,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    letterSpacing: -0.1,
                    fontFamily: intermedium,
                    color: Colors.white,
                    fontSize: screenwidth * 0.0323),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void setscanningfalse() {
    isscanning = false;
    update();
  }
  void connectManuallywithAddress(BuildContext context){
    BluetoothConnection.toAddress("00:22:03:01:19:F9").then((_connection) {

      print('Connected to the device');
      connection = _connection;
      setconnectedTrue();
      print(connection!.input);
      connectstatustext = backspacesCounter > 0
          ? _messageBuffer.substring(
          0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer;
      isConnecting = false;
      isDisconnecting = false;
      update();

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          setconnectedFalse();
          print('Disconnecting locally!');

        } else {
          setconnectedFalse();

          print('Disconnected remotely!');
        }

      });
    }).catchError((error) {

      print('Cannot connect, exception occured');
      print(error);
    });

  }
  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      messages.add(
        _Message(
          1,
          backspacesCounter > 0
              ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
              : _messageBuffer + dataString.substring(0, index),
        ),
      );
      _messageBuffer = dataString.substring(index);
      update();
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
          0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  Widget scanningdevicesbutton(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        //   changelinestatus();
        switchscantitle(context);
        setscanningfalse();
        //  setdisplaydevicedialogtrue();
      },
      child: Container(
        //   padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.0426),
        width: screenwidth * 0.549,
        height: screenwidth * 0.104,
        decoration: BoxDecoration(
            color: exohealnewpurple,
            borderRadius: BorderRadius.all(Radius.circular(22))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.eye,
              size: screenwidth * 0.0586,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.0426),
              // margin: EdgeInsets.only(top: screenwidth*0.016,bottom: screenwidth*0.0567),
              child: Text(
                "Cancel Scan",

                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: -0.1,
                    fontFamily: intermedium,
                    color: Colors.white,
                    fontSize: screenwidth * 0.0323),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void switchscantitle(BuildContext context) {
    if (mainscantitle == "Scan and Connect") {
      mainscantitle = "Nearby Devices";
    } else {
      mainscantitle = "Scan and Connect";
    }
    update();
  }
  Widget pagebackRrow(BuildContext context) {
    double screenwidth = MediaQuery.sizeOf(context!).width;
    return Container(
      width: screenwidth,
      child:
      Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /*IconButton(
                  onPressed: () {
                    //Navigator.pop(context);
                    checkactiveconnectivity();
                    print(allconnecteddevices);
                  },
                  icon: Icon(
                    CupertinoIcons.cloud,
                    color: Color(0xffD5D7D6),
                    size: screenwidth * 0.106,
                  )),*/
              IconButton(
                  onPressed: () {
                    print("Bonded Device list here");
                    for(var dev in devices){
                      print(dev.device.name);
                    }
                    //   baseController.setindex(0);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Color(0xffD5D7D6),
                    size: screenwidth * 0.106,
                  )),
              SizedBox(width: screenwidth*0.0583,)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*IconButton(
                  onPressed: () {
                    //Navigator.pop(context);
                    checkactiveconnectivity();
                    print(allconnecteddevices);
                  },
                  icon: Icon(
                    CupertinoIcons.cloud,
                    color: Color(0xffD5D7D6),
                    size: screenwidth * 0.106,
                  )),*/
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text("Exoheal",
                  style: TextStyle(
                      fontFamily: proximanovaregular,
                      color: exoheallightgreen,
                      fontSize: screenwidth*0.0583
                  ),),
              )
            ],
          ),


        ],
      ),
    );
  }
  Widget progresshistoryslider(BuildContext context){
    double screenwidth=MediaQuery.sizeOf(context).width;
    return Container(
      child: Stack(
        children: [
          Container(
            width: 180,height: 180,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: 180,height: 180,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 12,color: Color(0xffC1C7D2).withOpacity(0.23))
                    ),
                  ),
                  SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        size: 180,
                        customColors: CustomSliderColors(
                            trackColor: Color(0xffC1C7D2).withOpacity(0),
                            progressBarColor:exoheallightgreen
                        ),
                        customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            trackWidth: 12,
                            progressBarWidth: 12)

                    ),
                    min: 0,
                    max: 100,
                    initialValue: 28,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 180,height: 180,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,height: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 12,color: Color(0xffC1C7D2).withOpacity(0.23))
                    ),
                  ),
                  SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        size: 120,
                        customColors: CustomSliderColors(
                            trackColor: Color(0xffC1C7D2).withOpacity(0),
                            progressBarColor:exohealpurple
                        ),
                        customWidths: CustomSliderWidths(  trackWidth: 12,
                            handlerSize: 0,
                            progressBarWidth: 12)

                    ),
                    min: 0,
                    max: 100,
                    initialValue: 28,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 180,height: 180,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: 60,height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 12,color: Color(0xffC1C7D2).withOpacity(0.23))
                    ),
                  ),
                  SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        size: 60,
                        customColors: CustomSliderColors(
                            trackColor: Color(0xffC1C7D2).withOpacity(0.0),
                            progressBarColor:exohealightred
                        ),
                        customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            trackWidth: 12,
                            progressBarWidth: 12
                        )

                    ),
                    min: 0,
                    max: 100,
                    initialValue: 28,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget streakSection(BuildContext? context){
    double screenwidth=MediaQuery.sizeOf(context!).width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          individualtopRow(context: context, title: "Your Streaks Today", tapsection: "View All"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenwidth*0.04,
                  ),
                  Transform.scale(
                      scale: 0.9,
                      child: progresshistoryslider(context)),
                ],
              ),

            ],
          )
        ],
      ),
    );
  }
  Widget individualtopRow(
      {@required BuildContext? context, @required String? title, @required String? tapsection}){
    double screenwidth=MediaQuery.sizeOf(context!).width;
    return  Container(
      width: screenwidth,
      margin: EdgeInsets.only(bottom: screenwidth*0.028,
          top: screenwidth*0.066),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin:EdgeInsets.only(left: screenwidth*0.0713),
            child: Text(
              title!,
              style: TextStyle(
                  fontFamily: intersemibold,
                  fontSize: screenwidth*0.044,
                  color:Colors.white70),
            ),
          ),
          GestureDetector(
            onTap: (){
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      tapsection!,
                      style: TextStyle(
                          fontFamily: intermedium,
                          fontSize: screenwidth*0.0293,
                          color:exoheallightgreen),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenwidth*0.0166,
                      right: screenwidth*0.035,
                    ),
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color:exohealgreen,
                      size: screenwidth*0.0373,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget recentsessionslist(BuildContext context){
    double screenwidth=MediaQuery.sizeOf(context).width;
    return
      Column(
        children: [
          individualtopRow(context: context, title:  "Recent sessions", tapsection: "View All"),
          Container(
            height: screenwidth*0.315,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: exercises.length,
                itemBuilder: (context,index){
                  return individualExercise(context, exercises[index],index);
                }),
          ),
        ],
      );
  }
  Widget individualExercise(BuildContext context,ExerciseModel exerciseModel,int index){
    double screenwidth=MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: screenwidth*0.56,
        height: screenwidth*0.315,
        margin: EdgeInsets.only(right: screenwidth*0.024,left: index==0? screenwidth*0.044:0,),
        padding: EdgeInsets.only(left: screenwidth*0.0346,top:  screenwidth*0.0346,
            bottom:  screenwidth*0.0346),
        decoration: BoxDecoration(
            color: exohealanotherbggrey,
            borderRadius: BorderRadius.all(Radius.circular(6))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    exerciseModel.exercisetype!,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: intersemibold,
                        color: Colors.white,
                        fontSize: screenwidth * 0.0403),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenwidth*0.0183),
                  child: Text(
                    "Make sure you have bluetooth on your device turned on",
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: intermedium,
                        color: exohealgrey,
                        fontSize: screenwidth*0.0267),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(FeatherIcons.clock,
                  size: 20,
                  color: Colors.white,),
                Container(
                  margin: EdgeInsets.only(left: screenwidth*0.0183),
                  child: Text(
                    "8 min",
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: intermedium,
                        color: Colors.white,
                        fontSize: screenwidth*0.0267),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget profileTabs(BuildContext context){
    double screenwidth=MediaQuery.sizeOf(context).width;
    return Container(
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            width: screenwidth*0.685,
            height: screenwidth*0.13,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(28)),
              color: exohealanotherbggrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: (){},
                    child: Container(
                      margin: EdgeInsets.only(left: screenwidth*0.03),
                      child: Text(
                        "Record",
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: sfproroundedsemibold,
                            color: exoheallightgreen,
                            fontSize: screenwidth*0.045),
                      ),
                    )),
                ElevatedButton(

                    onPressed: (){},
                    child: Container(
                      margin: EdgeInsets.only(right: screenwidth*0.03),
                      child: Text(
                        "Record",
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: sfproroundedsemibold,
                            color: exoheallightgreen,
                            fontSize: screenwidth*0.045),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget pagebackRow(BuildContext context) {
    double screenwidth = MediaQuery.sizeOf(context!).width;
    return Container(
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /*IconButton(
              onPressed: () {
                //Navigator.pop(context);
                checkactiveconnectivity();
                print(allconnecteddevices);
              },
              icon: Icon(
                CupertinoIcons.cloud,
                color: Color(0xffD5D7D6),
                size: screenwidth * 0.106,
              )),*/
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Color(0xffD5D7D6),
                size: screenwidth * 0.106,
              )),
          SizedBox(
            width: screenwidth*0.04,
          )
        ],
      ),
    );
  }


}
class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}
enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}