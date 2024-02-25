import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/color_constants.dart';
import '../constants/fontconstants.dart';
class ProgressController extends GetxController{

  List<BarChartGroupData> barChartGroupData = [
    BarChartGroupData(x: 1, barRods: [
      BarChartRodData(y: 10, colors: [Color(0xff43dde6), Color(0xff43dde6)]),
    ]),
    BarChartGroupData(x: 2, barRods: [
      BarChartRodData(y: 8.5, colors: [Color(0xff43dde6), Color(0xff43dde6)]),
    ]),
    BarChartGroupData(x: 3, barRods: [
      BarChartRodData(y: 12.6, colors: [Color(0xff43dde6), Color(0xff43dde6)]),
    ]),
    BarChartGroupData(x: 4, barRods: [
      BarChartRodData(y: 11.4, colors: [Color(0xff43dde6), Color(0xff43dde6)]),
    ]),
    BarChartGroupData(x: 5, barRods: [
      BarChartRodData(y: 7.5, colors: [Color(0xff43dde6), Color(0xff43dde6)]),
    ]),
    BarChartGroupData(x: 6, barRods: [
      BarChartRodData(y: 14, colors: [Color(0xff43dde6), Color(0xff43dde6)]),
    ]),
    BarChartGroupData(x: 7, barRods: [
      BarChartRodData(y: 12.2, colors: [Color(0xff43dde6), Color(0xff43dde6)]),
    ]),
  ];
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
                        text: "Last session: Mirror Therapy Completed on\n"
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
  Widget weeklybarchart(BuildContext context){
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
                              y:getweeklyprogresses(i),
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

  Widget monthlybarchart(BuildContext context){
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
                    showTitles: false,
                    reservedSize: 20,
                    getTextStyles: (context,value) =>  TextStyle(
                      color:  Colors.white70,
                      fontFamily: interregular,
                      fontSize: 8,
                    ),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 0:

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
                    reservedSize: 0,
                    margin: 0,
                  ),
                ),
                barGroups:[
                  for(var i=0;i<=30;i++)
                    BarChartGroupData(
                        x: i,
                        barsSpace: 2,
                        barRods: [
                          BarChartRodData(
                            /*                y: i>steplen-1?0.2:steplist.length==0?0.2:this.steplist[i].steps>6000?3.7:
                              (((this.steplist[i].steps).toDouble()/6000)*3.7),*/
                              y:(i/7.5).toDouble(),
                              colors: [
                                Color(0xffff7e7e)
                                //  this.steplist[i].steps>6000?Color(0xff53f2be):Color(0xffff7e7e),
                              ],width: 2,borderRadius: BorderRadius.all(Radius.circular(10),)
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
  Widget progressemptystate(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.width;
    return     Container(
      width: screenwidth,
        height: screenheight,
        margin: EdgeInsets.only(left: screenwidth*0.052,right:screenwidth*0.052,top: screenwidth*0.3),

        //maxHeight:200,maxWidth: 500
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                              return "MON";
                            case 1:
                              return "TUE";
                            case 2:
                              return "WED";
                            case 3:
                              return "THU";
                            case 4:
                              return "FRI";
                            /*   return steplist.length==0?'FRI':steplist.length>4?
                              this.steplist[4].weekday.toUpperCase().substring(0,3):
                              remainingdays(this.steplist[steplist.length-1].weekday)[
                              steplist.length==1?3:steplist.length==2?2:steplist.length==3?1:0
                              ].toString().
                              substring(0,3).toUpperCase();*/
                            case 5:
                              return "SAT";
                              case 6:
                                return "SUN";
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
                            case 1:
                              return '3H';
                            case 2:
                              return '5H';
                            case 3:
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
  double getmonthlyprogresses(int i){
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
  Widget barchart(BuildContext context){
    return BarChart(BarChartData(
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context,value) => TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Mon';
              case 2:
                return 'Tues';
              case 3:
                return 'Wed';
              case 4:
                return 'Thu';
              case 5:
                return 'Fri';
              case 6:
                return 'Sat';
              case 7:
                return 'Sun';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          interval: 4,
          showTitles: true,
          getTextStyles: (context,value) =>TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),
          getTitles: (value) {
            if(value.toInt() == 0) return '';
            else return value.toInt().toString();
          },
        ),
      ),
      borderData:
      FlBorderData(
          border: Border.all(
              color: Colors.white,
              width: 0.5
          )
      ),
      alignment: BarChartAlignment.spaceEvenly,
      maxY: 16,
      barGroups: barChartGroupData,
    ));
  }


}