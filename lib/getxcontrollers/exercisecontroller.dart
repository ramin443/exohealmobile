import 'package:exohealandroid/getxcontrollers/basecontroller.dart';
import 'package:exohealandroid/screens/exercise/full_lap_exercise.dart';
import 'package:exohealandroid/screens/exercise/individual_exercise.dart';
import 'package:exohealandroid/screens/historyandprogress/history.dart';
import 'package:exohealandroid/screens/historyandprogress/progress.dart';
import 'package:exohealandroid/constants/fontconstants.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/color_constants.dart';
import '../constants/exercise_constants.dart';
import '../datamodels/ExerciseModel.dart';
import '../screens/pairing/mainpair.dart';
import 'mainBTController.dart';
final MainBTController mainBTController = Get.put(MainBTController());
final BaseController baseController = Get.put(BaseController());
class ExerciseController extends GetxController{
  int currentscrollviewindex=0;
  ScrollController exercisescrollviewcontroller=ScrollController();
  List<ExerciseModel> staticexerciselist=[

    ExerciseModel("exohealgreen", "Finger Tip Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Haptic Exercise Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Grabbing Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Mirror Therapy",
        "Make sure you have bluetooth on your device turned on", "8 min"),
  ];
  initscrollcontroller(){
    exercisescrollviewcontroller.addListener(_scrollListener);

  }

  _scrollListener() {
    if(exercisescrollviewcontroller.offset<
        (exercisescrollviewcontroller.position.maxScrollExtent*0.25)){
      currentscrollviewindex=0;
      update();
    }else if( exercisescrollviewcontroller.offset<
            (exercisescrollviewcontroller.position.maxScrollExtent/2)
    ){
      currentscrollviewindex=1;
      update();
    }else if(exercisescrollviewcontroller.offset>
        (exercisescrollviewcontroller.position.maxScrollExtent*0.5)
        && exercisescrollviewcontroller.offset<
            (exercisescrollviewcontroller.position.maxScrollExtent*0.75)
    ){
      currentscrollviewindex=2;
      update();
    }else if(exercisescrollviewcontroller.offset>
        (exercisescrollviewcontroller.position.maxScrollExtent*0.75)){
      currentscrollviewindex=3;
      update();
    }

  }

  Widget AIexerciserow(BuildContext context, List<ExerciseModel> exerciselist){
    double screenwidth = MediaQuery.of(context).size.width;
    return     Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          individualtopRowAIsection(context:context),
          Container(
            height: screenwidth*0.589,
            margin: EdgeInsets.only(top: screenwidth*0.0106),
            child: ListView.builder(
                controller: exercisescrollviewcontroller,
                //     shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: exerciselist.length,
                itemBuilder: (context,index){
                  return Container(
                    height: screenwidth*0.589,
                    width: screenwidth*0.493,
                    padding: EdgeInsets.symmetric(horizontal: screenwidth*0.032,
                        vertical: screenwidth*0.0426),
                    margin: EdgeInsets.only(left:index==0?screenwidth*0.052:
                    0,right: screenwidth*0.0453
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: exohealanotherbggrey,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Container(
                                margin:EdgeInsets.only(top: 3),
                                child: Text(
                                  exerciselist[index].exercisetype.toString(),
                                  style: TextStyle(
                                      fontFamily: intermedium,
                                      fontSize: screenwidth*0.0386,
                                      color:Colors.white),
                                ),
                              ),
                              Container(
                                margin:EdgeInsets.only(top: screenwidth*0.024),
                                child: Text(
                                  exerciselist[index].description.toString(),
                                  maxLines:2,
                                  style: TextStyle(
                                      fontFamily: intermedium,
                                      fontSize: screenwidth*0.0293,
                                      color:Colors.white70),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: screenwidth*0.048),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Container(
                                      child: Icon(FeatherIcons.clock,
                                        size: 20,
                                        color: Colors.white70,),
                                    ),
                                    Container(
                                      margin:EdgeInsets.only(left: screenwidth*0.021),
                                      child: Text(
                                        exerciselist[index].duration.toString(),
                                        style: TextStyle(
                                            fontFamily: intermedium,
                                            fontSize: screenwidth*0.0266,
                                            color:Colors.white70),
                                      ),
                                    ),

                                  ],
                                ),
                              )
                            ]),
                        GestureDetector(
                          onTap: (){
                            if(mainBTController.isExohealConnected){
                              Navigator.push(context, MaterialPageRoute(builder: (context)
                              =>IndividualExercise(exerciseModel: exerciselist[index],)));
                            }else{
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPair()));
                            }

                          },
                          child: Container(
                            width: screenwidth,
                            height: screenwidth*0.0966,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(24)),
                                color: exoheallightgreen
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin:EdgeInsets.only(left: 10),
                                  child: Icon(CupertinoIcons.arrow_right,
                                    color: Colors.transparent,
                                    size: 18,),
                                ),
                                Container(
                                  //        margin:EdgeInsets.only(left: screenwidth*0.021),
                                  child: Text(
                                    "Start",
                                    style: TextStyle(
                                        fontFamily: intermedium,
                                        fontSize: screenwidth*0.0343,
                                        color:exohealdarkmodepagebg),
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.only(right: 10),
                                  child: Icon(CupertinoIcons.arrow_right,
                                    color: exohealdarkmodepagebg,
                                    size: 14,),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.0373,bottom: screenwidth*0.0533),
            width: screenwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(duration: Duration(milliseconds: 150),
                  //             height: 6,width: 6,
                  height: screenwidth*0.016,width: screenwidth*0.016,
                  margin: EdgeInsets.only(
                    //            right: 5
                      right: screenwidth*0.0133
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentscrollviewindex==0?Color(0xffDDDDDD):darkgrey,
                  ),
                ),
                AnimatedContainer(duration: Duration(milliseconds: 150),
                  //               height: 6,width: 6,
                  height: screenwidth*0.016,width: screenwidth*0.016,
                  margin: EdgeInsets.only(right:  screenwidth*0.0133),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:currentscrollviewindex==1?Color(0xffDDDDDD):darkgrey,
                  ),
                ),
                AnimatedContainer(duration: Duration(milliseconds: 150),
                  //                height: 6,width: 6,
                  height: screenwidth*0.016,width: screenwidth*0.016,
                  margin: EdgeInsets.only(right:  screenwidth*0.0133),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:currentscrollviewindex==2?Color(0xffDDDDDD):darkgrey,
                  ),
                ),
                AnimatedContainer(duration: Duration(milliseconds: 150),
//                  height: 6,width: 6,
                  height: screenwidth*0.016,width: screenwidth*0.016,
                  margin: EdgeInsets.only(right:  screenwidth*0.0133),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentscrollviewindex==3?Color(0xffDDDDDD):darkgrey,
                  ),
                ),

              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: screenwidth*0.048,
                horizontal: screenwidth*0.0666),
            child: SvgPicture.asset("assets/images/separation.svg",
              width: screenwidth,),
          ),
        ],
      ),
    );
  }

  Widget exerciserow(BuildContext context, List<ExerciseModel> exerciselist){
    double screenwidth = MediaQuery.of(context).size.width;
    return     Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin:EdgeInsets.only(left: screenwidth*0.052,),
                child: Text(
                  "Exercises",
                  style: TextStyle(
                      fontFamily: intersemibold,
                      fontSize: screenwidth*0.0426,
                      color:Colors.white),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  =>HistoryPage()));
                },
                child: Container(
                  margin:EdgeInsets.only(right: screenwidth*0.052,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "View full history",
                          style: TextStyle(
                              fontFamily: intermedium,
                              fontSize: screenwidth*0.0293,
                              color:exoheallightgreen),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: screenwidth*0.0266),
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          color:exoheallightgreen,
                          size: screenwidth*0.0373,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            height: screenwidth*0.589,
            margin: EdgeInsets.only(top: screenwidth*0.0506),
            child: ListView.builder(
        //     shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: allexercises.length,
                itemBuilder: (context,index){
              return Container(
                height: screenwidth*0.589,
                width: screenwidth*0.493,
                padding: EdgeInsets.symmetric(horizontal: screenwidth*0.032,
                vertical: screenwidth*0.0426),
                margin: EdgeInsets.only(left:index==0?screenwidth*0.052:
                0,right: screenwidth*0.0453
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: exohealanotherbggrey,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                    Container(
                      margin:EdgeInsets.only(top: 3),
                      child: Text(
                        allexercises[index].exercisetype.toString(),
                        style: TextStyle(
                            fontFamily: intermedium,
                            fontSize: screenwidth*0.0386,
                            color:Colors.white),
                      ),
                    ),
                    Container(
                      margin:EdgeInsets.only(top: screenwidth*0.024),
                      child: Text(
                        allexercises[index].description.toString(),
                        maxLines:2,
                        style: TextStyle(
                            fontFamily: intermedium,
                            fontSize: screenwidth*0.0293,
                            color:Colors.white70),
                      ),
                    ),
                Container(
                  margin: EdgeInsets.only(top: screenwidth*0.048),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Container(
                        child: Icon(FeatherIcons.clock,
                        size: 20,
                        color: Colors.white70,),
                      ),
                      Container(
                        margin:EdgeInsets.only(left: screenwidth*0.021),
                        child: Text(
                          allexercises[index].duration.toString(),
                          style: TextStyle(
                              fontFamily: intermedium,
                              fontSize: screenwidth*0.0266,
                              color:Colors.white70),
                        ),
                      ),

                    ],
                  ),
                )
                ]),
                    GestureDetector(
                      onTap: (){
                        if(mainBTController.isExohealConnected){
                          Navigator.push(context, MaterialPageRoute(builder: (context)
                          =>IndividualExercise(exerciseModel: allexercises[index],)));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPair()));
                        }

                      },
                      child: Container(
                        width: screenwidth,
                        height: screenwidth*0.0966,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: exoheallightgreen
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:EdgeInsets.only(left: 10),
                              child: Icon(CupertinoIcons.arrow_right,
                              color: Colors.transparent,
                              size: 18,),
                            ),
                            Container(
                      //        margin:EdgeInsets.only(left: screenwidth*0.021),
                              child: Text(
                                "Start",
                                style: TextStyle(
                                    fontFamily: intermedium,
                                    fontSize: screenwidth*0.0343,
                                    color:exohealdarkmodepagebg),
                              ),
                            ),
                            Container(
                              margin:EdgeInsets.only(right: 10),
                              child: Icon(CupertinoIcons.arrow_right,
                                color: exohealdarkmodepagebg,
                                size: 14,),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.0373,bottom: screenwidth*0.0533),
            width: screenwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(duration: Duration(milliseconds: 150),
     //             height: 6,width: 6,
                  height: screenwidth*0.016,width: screenwidth*0.016,
                  margin: EdgeInsets.only(
          //            right: 5
                    right: screenwidth*0.0133
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentscrollviewindex==0?Color(0xffDDDDDD):darkgrey,
                  ),
                ),
                AnimatedContainer(duration: Duration(milliseconds: 150),
   //               height: 6,width: 6,
                  height: screenwidth*0.016,width: screenwidth*0.016,
                  margin: EdgeInsets.only(right:  screenwidth*0.0133),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:currentscrollviewindex==1?Color(0xffDDDDDD):darkgrey,
                  ),
                ),
                AnimatedContainer(duration: Duration(milliseconds: 150),
  //                height: 6,width: 6,
                  height: screenwidth*0.016,width: screenwidth*0.016,
                  margin: EdgeInsets.only(right:  screenwidth*0.0133),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:currentscrollviewindex==2?Color(0xffDDDDDD):darkgrey,
                  ),
                ),
                AnimatedContainer(duration: Duration(milliseconds: 150),
//                  height: 6,width: 6,
                  height: screenwidth*0.016,width: screenwidth*0.016,
                  margin: EdgeInsets.only(right:  screenwidth*0.0133),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentscrollviewindex==3?Color(0xffDDDDDD):darkgrey,
                  ),
                ),

              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
              FullLapExercise(exerciselist: staticexerciselist,)
              ));
            },
            child: Container(
              width: screenwidth*0.666,
              padding: EdgeInsets.symmetric(
                  vertical: screenwidth*0.0383),
              decoration: BoxDecoration(
                  color: exohealanotherbggrey,
                  borderRadius: BorderRadius.all(Radius.circular(24))
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: screenwidth*0.074),
                      child: Text("Start a Full Lap Exercise",style: TextStyle(
                          fontFamily: intermedium,
                          color: Colors.white,
                          fontSize: screenwidth*0.036
                      ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(CupertinoIcons.arrow_right,
                        size: screenwidth*0.0496,
                        color: Color(0xffECECEC),),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.0266,
            ),
            child: Text("A full lap exercise consists of Haptic Exercise, Figer Tip\n"
                "Exercise,Grabbing Exercise, and Mirror Therapy for 7.5 minutes each.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: interregular,
                color: exohealgrey,
                fontSize: screenwidth*0.0266
            ),),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: screenwidth*0.048,
                horizontal: screenwidth*0.0666),
            child: SvgPicture.asset("assets/images/separation.svg",
              width: screenwidth,),
          ),
        ],
      ),
    );
  }
  Widget progressrow(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
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
                margin:EdgeInsets.only(left: screenwidth*0.052,),
                child: Text(
                  "Progress",
                  style: TextStyle(
                      fontFamily: intersemibold,
                      fontSize: screenwidth*0.0426,
                      color:Colors.white),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  =>ProgressPage()));
                },
                child: Container(
                  margin:EdgeInsets.only(right: screenwidth*0.052,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "View full progress",
                          style: TextStyle(
                              fontFamily: intermedium,
                              fontSize: screenwidth*0.0293,
                              color:exoheallightgreen),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: screenwidth*0.0266),
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          color:exoheallightgreen,
                          size: screenwidth*0.0373,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget barchart(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return     Container(
      margin: EdgeInsets.only(left: screenwidth*0.052,right:screenwidth*0.052,top: 24),
        height: 190,
        width:screenwidth*0.85,
        //maxHeight:200,maxWidth: 500
        child: Center(
            child:
            BarChart(
              BarChartData(
                minY: 0,maxY: 4,
                borderData: FlBorderData(show: false),
                alignment: BarChartAlignment.center,
                titlesData:
                FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTextStyles: (context,value) =>  TextStyle(
                      color:  Colors.white70,
                      fontFamily: interregular,
                      fontSize: 12,
                    ),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 0:
                          getweekdayfromindex(value.toInt());
                          break;
                        case 1:
                          getweekdayfromindex(value.toInt());
                          break;
                        case 2:
                          getweekdayfromindex(value.toInt());
                          break;
                        case 3:
                          getweekdayfromindex(value.toInt());
                          break;
                        case 4:
                          getweekdayfromindex(value.toInt());
                          break;                       /*   return steplist.length==0?'FRI':steplist.length>4?
                          this.steplist[4].weekday.toUpperCase().substring(0,3):
                          remainingdays(this.steplist[steplist.length-1].weekday)[
                          steplist.length==1?3:steplist.length==2?2:steplist.length==3?1:0
                          ].toString().
                          substring(0,3).toUpperCase();*/
                        case 5:
                          getweekdayfromindex(value.toInt());
                          break;
                        case 6:
                          getweekdayfromindex(value.toInt());
                          break;
                      }
                      return '';
                    },
                    margin: 8,
                  ),
                  leftTitles: SideTitles(
                    showTitles: false,
                    getTextStyles: (context,value) =>  TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Sfprothin',        fontSize: 15,
                    ),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 3:
                          return '3H';
                        case 5:
                          return '5H';
                        case 8:
                          return '8H';
                      }
                      return '';
                    },
                    reservedSize: 10,
                    margin: 12,
                  ),
                ),
                barGroups:[
                  for(var i=0;i<=6;i++)
                    BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
              /*                y: i>steplen-1?0.2:steplist.length==0?0.2:this.steplist[i].steps>6000?3.7:
                              (((this.steplist[i].steps).toDouble()/6000)*3.7),*/
                            y:getprogresses(i),
                              colors: [
                              Color(0xffff7e7e)
                              //  this.steplist[i].steps>6000?Color(0xff53f2be):Color(0xffff7e7e),
                              ],width: 26,borderRadius: BorderRadius.all(Radius.circular(10),)
                          ),]),
                  //                     BarChartGroupData(
                  //                      x: 2,
                  // //                  barRods: [
                  //               BarChartRodData(
                  //                y: 6,colors: [Colors.redAccent],width: 8,borderRadius: BorderRadius.all(Radius.circular(12),))])
                ],
              ),
            ))
    );
  }
  double getprogresses(int i){
    switch (i){
      case 0:
        return 1.9;
      case 1:
        return 2.4;
      case 2:
        return 2.4;
      case 3:
        return 1.1;
      case 4:
        return 3.2;
      case 5:
        return 3.6;
      case 6:
        return 3.1;
      default:
        return 3;
    }
  }
  getweekdayfromindex(int i){
    switch (i){
      case 0:
        return "Mon";
      case 1:
        return "Tue";
      case 2:
        return "Wed";
      case 3:
        return "Thu";
      case 4:
        return "Fri";
      case 5:
        return "Sat";
      case 6:
        return "Sun";}
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
              size: screenwidth * 0.159,
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
  Widget individualtopRowAIsection(
      {@required BuildContext? context}){
    double screenwidth=MediaQuery.sizeOf(context!).width;
    return  Container(
      width: screenwidth,
      margin: EdgeInsets.only(bottom: screenwidth*0.028,
          top: screenwidth*0.066),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width:  screenwidth*0.044),

              Icon(FeatherIcons.terminal,
                  size:24,
                  color:exohealpurple),
              Container(
                margin:EdgeInsets.only(left: screenwidth*0.0213),
                child: RichText(
                    text:TextSpan(
                      children: [
                        TextSpan(
                            text:"AI ",
                            style: TextStyle(
                              fontFamily: intersemibold,
                              fontSize: screenwidth*0.044,
                              color:exohealpurple,
                            )),
                        TextSpan(
                          text:"suggested exercises",
                          style: TextStyle(
                              fontFamily: intersemibold,
                              fontSize: screenwidth*0.044,
                              color:Colors.white.withOpacity(0.9)),
                        ),
                      ],
                    )

                ),
              ),
            ],
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
                      "View All",
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
  Widget progressemptystate(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return     Container(
        margin: EdgeInsets.only(left: screenwidth*0.052,right:screenwidth*0.052,top: 24),

        //maxHeight:200,maxWidth: 500
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
//                  top: 14,bottom: 24
                  top: screenwidth*0.0340,bottom: screenwidth*0.0583
              ),
              child: Text("No progress data yet",style: TextStyle(
                  fontFamily: intermedium,
                  color: Colors.redAccent,
                  fontSize: screenwidth*0.0340
              ),),
            ),
            Container(
                height: screenwidth*0.462,
                width:screenwidth*0.85,
                child:
                BarChart(
                  BarChartData(
                    minY: 0,maxY: 4,
                    borderData: FlBorderData(show: false),
                    alignment: BarChartAlignment.center,
                    titlesData:
                    FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTextStyles: (context,value) =>  TextStyle(
                          color:  Colors.white70,
                          fontFamily: interregular,
                          fontSize: 12,
                        ),
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 0:
                              return "";
                            case 1:

                            case 2:

                            case 3:

                            case 4:
                            /*   return steplist.length==0?'FRI':steplist.length>4?
                              this.steplist[4].weekday.toUpperCase().substring(0,3):
                              remainingdays(this.steplist[steplist.length-1].weekday)[
                              steplist.length==1?3:steplist.length==2?2:steplist.length==3?1:0
                              ].toString().
                              substring(0,3).toUpperCase();*/
                            case 5:

                            case 6:
                          }
                          return '';
                        },
                        margin: 8,
                      ),
                      leftTitles: SideTitles(
                        showTitles: false,
                        getTextStyles: (context,value) =>  TextStyle(
                          color: Colors.white70,
                          fontFamily: intermedium,        fontSize: 15,
                        ),
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 3:
                              return '3H';
                            case 5:
                              return '5H';
                            case 8:
                              return '8H';
                          }
                          return '';
                        },
                        reservedSize: 10,
                        margin: 12,
                      ),
                    ),
                    barGroups:[
                      for(var i=0;i<=6;i++)
                        BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                /*                y: i>steplen-1?0.2:steplist.length==0?0.2:this.steplist[i].steps>6000?3.7:
                                  (((this.steplist[i].steps).toDouble()/6000)*3.7),*/
                                  y:getweeklyprogresses(i),
                                  colors: [
                                    Color(0xffD4D4D4)
                                    //  this.steplist[i].steps>6000?Color(0xff53f2be):Color(0xffff7e7e),
                                  ],width: 26,borderRadius: BorderRadius.all(Radius.circular(10),)
                              ),]),
                      //                     BarChartGroupData(
                      //                      x: 2,
                      // //                  barRods: [
                      //               BarChartRodData(
                      //                y: 6,colors: [Colors.redAccent],width: 8,borderRadius: BorderRadius.all(Radius.circular(12),))])
                    ],
                  ),
                )),
          ],
        )
    );
  }
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
                Expanded(child: getprofilerow(context)),
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
  double getweeklyprogresses(int i){
    switch (i){
      case 0:
        return 1.9;
      case 1:
        return 2.4;
      case 2:
        return 2.4;
      case 3:
        return 1.1;
      case 4:
        return 3.2;
      case 5:
        return 3.6;
      case 6:
        return 3.1;
      default:
        return 3;
    }
  }
  }