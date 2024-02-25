import 'dart:convert';
import 'dart:typed_data';
import 'package:exohealandroid/getxcontrollers/mainBTController.dart';
import 'package:exohealandroid/screens/pairing/mainpair.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../constants/color_constants.dart';
import '../constants/fontconstants.dart';
import '../datamodels/ExerciseModel.dart';
import '../datamodels/HistoryModel.dart';
import '../screens/exercise/full_lap_exercise.dart';
import '../screens/exercise/individual_exercise.dart';
import '../screens/historyandprogress/history.dart';
import '../screens/historyandprogress/progress.dart';
import 'basecontroller.dart';

final BaseController baseController = Get.put(BaseController());
class HomeController extends GetxController{
 // FlutterBlue flutterBlue = FlutterBlue.instance;
  String _data = '';
  bool loading=false;
  bool _scanning = false;
  bool showmessagebox=false;
  List<ExerciseModel> exercises=[
    ExerciseModel("", "Finger Tip Exercise", "_description", "_duration"),
    ExerciseModel("", "Haptic Exercise Tip", "_description", "_duration"),
    ExerciseModel("", "Mirror Therapy", "_description", "_duration"),

  ];
  setmessageboxtrue(){
    showmessagebox=true;
    update();
  }
  setmessageboxfalse(){
    showmessagebox=false;
    //update();
  }

  List<ExerciseModel> staticexerciselist=[
    ExerciseModel("exohealgreen", "Finger Tip Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Haptic Exercise Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Mirror Therapy",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Grabbing Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
  ];
  Widget borderline(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      height: 0.4,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
    );
  }
  Widget drawer(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 18),
            width: screenwidth,
            height: screenwidth*0.4,
            decoration: BoxDecoration(
              color: exohealdarkgrey
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text('ExoHeal',
                    style: TextStyle(
                        fontFamily: proximanovaregular,
                        color: exohealbeige,
                        fontSize: 24

                    ),),
                ),
                getprofilerow(context),
              ],
            ),
          ),
          drawercolumn(context),

        ],
      ),
    );
  }
  Widget drawercolumn(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
            HistoryPage()
            ));
          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    CupertinoIcons.uiwindow_split_2x1,
                    color: exohealdarkgrey,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "History",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Color(0xff333333),
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
        borderline(context),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                ProgressPage()
            ));
          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    FeatherIcons.barChart2,
                    color: exohealdarkgrey,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "Progress",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Color(0xff333333),
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
        borderline(context),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>
            FullLapExercise(exerciselist: staticexerciselist,)
            ));
          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    FeatherIcons.gitMerge,
                    color: exohealdarkgrey,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "Full Lapse Exercise",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Color(0xff333333),
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
        borderline(context),
        InkWell(
          onTap: () {
            baseController.setindex(2);
            Navigator.pop(context);
          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    FeatherIcons.settings,
                    color: exohealdarkgrey,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Color(0xff333333),
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
        borderline(context),
        InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
            });
          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    FeatherIcons.logOut,
                    color: Colors.redAccent,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "Sign Out",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Colors.redAccent,
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
      ],
    );
  }
  Widget getprofilerow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      padding: EdgeInsets.symmetric(
          vertical: screenwidth * 0.0307),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.white54,
//            size: 70,
              size: screenwidth * 0.169,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
//                left: 16
                left: screenwidth * 0.000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
    FirebaseAuth.instance.currentUser!.displayName==null?"ExoHeal user":
                    FirebaseAuth.instance.currentUser!.displayName.toString(),
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealbeige,
                        //        fontSize: 18
                        fontSize: screenwidth * 0.0461),
                  ),
                ),
                Container(
                  child: Text(
                    FirebaseAuth.instance.currentUser!.email==null?
                    "":
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealbeige,
                        //         fontSize: 14.5
                        fontSize: screenwidth * 0.0371),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  List<HistoryModel> staticlist=[
    HistoryModel("Full lapse exercise","exohealgreen" ,"8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now()), "10:30"),
    HistoryModel("Haptic Exercise","exohealbeige", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now()), "08:15"),
    HistoryModel("Finger Tip Exercise","exohealdarkgrey", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(Duration(days: 1))), "12:22"),
    HistoryModel("Grabbing Exercise","exoheallightgrey", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(Duration(days: 1))), "08:15"),

  ];

/*
  scanbluetoothdevices(){
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));
// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
   //     if(r.device.name==)
     //   r.device.connect(autoConnect: true);
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

// Stop scanning
    flutterBlue.stopScan();
  }
  */
  setloadingfalse(){
    loading=false;
    setmessageboxtrue();
    update();
  }
  Widget messagebox(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return     Container(
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
  Color getcolor(String img){
    switch (img){
      case "exohealgreen":
        return exohealgreen;
      case "exohealbeige":
        return exohealbeige;
      case "exohealdarkgrey":
        return exohealdarkgrey;
      case "exoheallightgrey":
        return exoheallightgrey;
    default:
        return exoheallightgrey;
    }
  }
  Widget connectedcircle(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return   Column(
      children: [
        Container(
            width: screenwidth * 0.48,
            height: screenwidth * 0.48,
            margin: EdgeInsets.only(top: screenwidth * 0.08),
            child:
            Stack(
                children:[
                  Image.asset(
                    "assets/images/darkmodeimg/connected.png",
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
                          child: Text("Status: Connected",style: TextStyle(
                              fontFamily: intermedium,
                              color: exoheallightgreen,
                              fontSize: screenwidth*0.0293
                          ),),
                        )
                      ],
                    ),
                  )
                ])
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
           IndividualExercise(exerciseModel:
           ExerciseModel("exohealgreen", "Finger Tip Exercise",
               "Make sure you have bluetooth on your device turned on", "15 sec"),)));
          },
          child: Container(
            width: screenwidth*0.616,
            margin: EdgeInsets.only(top: screenwidth*0.0586),
            padding: EdgeInsets.symmetric(
                vertical: screenwidth*0.0203),
            decoration: BoxDecoration(
                color: exoheallightgreen,
                borderRadius: BorderRadius.all(Radius.circular(6))
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: screenwidth*0.048),
                    child: Icon(CupertinoIcons.arrow_right,
                      size: screenwidth*0.0486,
                      color: Colors.transparent,),
                  ),     Container(
                //    margin: EdgeInsets.only(left: screenwidth*0.074),
                    child: Text("Start Exercises",style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealdarkmodepagebg,
                        fontSize: screenwidth*0.032
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: screenwidth*0.048),
                    child: Icon(CupertinoIcons.arrow_right,
                      size: screenwidth*0.0486,
                      color: exohealdarkmodepagebg,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget connectingcolumn(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return   Column(
      children: [
        Container(
            width: screenwidth * 0.48,
            height: screenwidth * 0.48,
            margin: EdgeInsets.only(top: screenwidth * 0.08),
            child:
            Stack(
                children:[
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
                          child: Text("Status: Not Connected",style: TextStyle(
                              fontFamily: intermedium,
                              color: Colors.white70,
                              fontSize: screenwidth*0.0293
                          ),),
                        )
                      ],
                    ),
                  )
                ])
        ),
        Container(
          width: screenwidth*0.616,
          margin: EdgeInsets.only(top: screenwidth*0.0586),
          padding: EdgeInsets.symmetric(
              vertical: screenwidth*0.0203),
          decoration: BoxDecoration(
              color: exohealgreen,
              borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenwidth*0.074),
                  child: Text("Searching ExoHeal device",style: TextStyle(
                      fontFamily: intermedium,
                      color: Colors.white,
                      fontSize: screenwidth*0.032
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenwidth*0.048),
                  width:  screenwidth*0.0486,
                  height:  screenwidth*0.0486,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    backgroundColor: Colors.white,
                  )
                  ,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget notconnectedcircle(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return   Column(
      children: [
        Container(
            width: screenwidth * 0.48,
            height: screenwidth * 0.48,
            margin: EdgeInsets.only(top: screenwidth * 0.08),
            child:
            Stack(
                children:[
                  Image.asset(
                    "assets/images/darkmodeimg/disconnected.png",
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
                          child: Text("Status: Not Connected",style: TextStyle(
                              fontFamily: intermedium,
                              color: Colors.white70,
                              fontSize: screenwidth*0.0293
                          ),),
                        )
                      ],
                    ),
                  )
                ])
        ),
        GestureDetector(
          onTap: (){
           /* loading=true;
            update();
            Future.delayed(Duration(seconds: 5),setloadingfalse);*/
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPair()));
          },
          child: Container(
            width: screenwidth*0.616,
            margin: EdgeInsets.only(top: screenwidth*0.0586),
            padding: EdgeInsets.symmetric(
                vertical: screenwidth*0.0263),
            decoration: BoxDecoration(
                color: exoheallightgreen,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: screenwidth*0.074),
                    child: Text("Connect to ExoHeal device",style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealdarkmodepagebg,
                        fontSize: screenwidth*0.032
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenwidth*0.048),
                    child: Icon(CupertinoIcons.arrow_right,
                      size: screenwidth*0.0486,
                      color: exohealdarkmodepagebg,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget history_home(BuildContext context, List<HistoryModel> historylist){
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0693),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin:EdgeInsets.only(left: screenwidth*0.008),
                  child: Text(
                    "History",
                    style: TextStyle(
                        fontFamily: intersemibold,
                        fontSize: screenwidth*0.04,
                        color:exohealdarkgrey),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    =>HistoryPage()
                    ));
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "View full history",
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
                )
              ],
            ),
          ),
          FirebaseAuth.instance.currentUser!.email!=testuseremail?
          emptystate(context):
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.0693),
            child: ListView.builder(
              shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: historylist.length>3?4:historylist.length,
                itemBuilder: (context,index){
                return Container(
                  width: screenwidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: screenwidth*0.0293),
                                  height: screenwidth*0.096,width: screenwidth*0.096,
                                  decoration: BoxDecoration(
                                    color: getcolor(historylist[index].image.toString()),
                                    shape: BoxShape.circle
                                  ),
                                ),
                                Container(
                                  height:screenwidth*0.086,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          historylist[index].exercisetype.toString(),
                                          style: TextStyle(
                                              fontFamily: intermedium,
                                              fontSize: screenwidth*0.032,
                                              color:darkgrey),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Duration: "+historylist[index].duration.toString(),
                                          style: TextStyle(
                                              fontFamily: intermedium,
                                              fontSize: screenwidth*0.0293,
                                              color:exoheallightgrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          Container(
                            height:screenwidth*0.086,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  child: Text(
                      historylist[index].date.toString()==
                      DateFormat.yMMMMd('en_US').format(DateTime.now())?
                                    "Today":
                                    historylist[index].date.toString(),
                                    style: TextStyle(
                                        fontFamily: interregular,
                                        fontSize: screenwidth*0.0293,
                                        color:darkgrey),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    historylist[index].time.toString(),
                                    style: TextStyle(
                                        fontFamily: interregular,
                                        fontSize: screenwidth*0.0293,
                                        color:darkgrey),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      index==3?
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)
                              =>HistoryPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: screenwidth*0.032,
                                  bottom: screenwidth*0.0506),
                              width: screenwidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child:  Text(
                                      "View more",
                                      style: TextStyle(
                                          fontFamily: intermedium,
                                          fontSize: screenwidth*0.0293,
                                          color:exohealgreen),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: screenwidth*0.016),
                                    child: Icon(CupertinoIcons.arrow_right,
                                    color: exohealgreen,
                                    size: screenwidth*0.0373,),
                                  )
                                ],
                              ),
                            ),
                          ):
                      Container(
                        margin: EdgeInsets.only(top: screenwidth*0.04,bottom: screenwidth*0.0506),
                        width: screenwidth,
                        height: 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xffECEBEB)
                        ),
                      )
                    ],
                  ),
                );
                }),
          )
        ],
      ),

    );
  }

  Widget emptystate(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: screenwidth*0.0635),
              child: SvgPicture.asset(
                "assets/images/No task empty state.svg",
                width: screenwidth * 0.322,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
//                                top: 21,bottom: 9
                  top: screenwidth * 0.0538,
                  bottom: screenwidth * 0.0230),
              child: Text(
                "No exercise done yet",
                style: TextStyle(
                    fontFamily: intersemibold,
                    color: Colors.black,
                    fontSize: screenwidth*0.0401),
              ),
            ),
            Container(
              child: Text(
                "Connect to your ExoHeal device and start exercising",
                style: TextStyle(
                    fontFamily: intermedium,
                    color: Color(0xffA3A3A3),
                    fontSize:screenwidth*0.0304),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /*
  tryazure()async{
    var storage=AzureStorage.parse("DefaultEndpointsProtocol=https;AccountName=exohealmobile;AccountKey=+h4pGQ2WYV/c8kR9+Bic+k8keWo4YmH6RONNk/0OFBhocAGMkKJ5sf/6/HOtctZ0FVxEBCEPTmsckznxeuBAoA==;EndpointSuffix=core.windows.net");
  await storage.putBlob('/yourcontainer/yourfile.txt',
      body: 'Hello, worlduoooo.');
  }
  getblob()async{

    var storage=AzureStorage.parse("DefaultEndpointsProtocol=https;AccountName=exohealmobile;AccountKey=+h4pGQ2WYV/c8kR9+Bic+k8keWo4YmH6RONNk/0OFBhocAGMkKJ5sf/6/HOtctZ0FVxEBCEPTmsckznxeuBAoA==;EndpointSuffix=core.windows.net");
    final a=await storage.getBlob('/yourcontainer/yourfile.txt',
        );
    Stream b=a.stream;
    }*/
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
                  color:Colors.white.withOpacity(0.9)),
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
  Widget streakSection(BuildContext? context){
    double screenwidth=MediaQuery.sizeOf(context!).width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          individualtopRow(context: context, title: "Your Streaks Today", tapsection: "View All"),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenwidth*0.03,
                  ),
                  Transform.scale(
                      scale: 0.75,
                      child: progresshistoryslider(context)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset("assets/images/darkmodeimg/streaksinfo.png",
                    width: screenwidth*0.494,),
                  )
                ],
              )

            ],
          )
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
                          shadowColor: Colors.transparent,
                            trackColor: Color(0xffC1C7D2).withOpacity(0),
                            progressBarColor:exoheallightgreen
                        ),
                        customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            trackWidth: 12,
                            progressBarWidth: 12)
                        ,
                        infoProperties: InfoProperties(
                          mainLabelStyle:TextStyle(
                              fontSize: 0
                          ),
                          topLabelStyle: TextStyle(
                              fontSize: 0
                          ),
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
                            shadowColor: Colors.transparent,
                            trackColor: Color(0xffC1C7D2).withOpacity(0),
                            progressBarColor:exohealpurple
                        ),
                        customWidths: CustomSliderWidths(  trackWidth: 12,
                            handlerSize: 0,
                            progressBarWidth: 12)
                        ,
                        infoProperties: InfoProperties(
                          mainLabelStyle:TextStyle(
                              fontSize: 0
                          ),
                          topLabelStyle: TextStyle(
                              fontSize: 0
                          ),
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
                            shadowColor: Colors.transparent,
                            trackColor: Color(0xffC1C7D2).withOpacity(0.0),
                            progressBarColor:exohealightred
                        ),
                        customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            trackWidth: 12,
                            progressBarWidth: 12
                        ),
                      infoProperties: InfoProperties(
                          mainLabelStyle:TextStyle(
                            fontSize: 0
                          ),
                        topLabelStyle: TextStyle(
                            fontSize: 0
                        ),
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
  Widget exerciseHistorySection(BuildContext context){
    double screenwidth=MediaQuery.sizeOf(context).width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          individualtopRow(context: context, title: "Exercise History", tapsection: "View Full History"),
          Container(
            width: screenwidth,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("assets/images/darkmodeimg/exercisehistory.png",
                width: screenwidth*0.91,
                ),
              )
            ],),
          )
        ],
      ),
    );
  }
}