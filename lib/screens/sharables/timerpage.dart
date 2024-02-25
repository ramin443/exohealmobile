import 'package:exohealandroid/constants/color_constants.dart';
import 'package:exohealandroid/getxcontrollers/mainBTController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/fontconstants.dart';
class TimerSelectionPage extends StatelessWidget {
  const TimerSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.sizeOf(context).width;
    return GetBuilder<MainBTController>(
      init: MainBTController(),
      initState: (v){

      },
      builder: (mainbtcontroller) {
        return Scaffold(
          backgroundColor: exohealdarkmodepagebg,
          body: Center(
            child: SingleChildScrollView(

              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainbtcontroller.pagebackRow(context),
                    Container(child: Text(mainbtcontroller.maintime,style: TextStyle(
                        fontFamily: gilroymediumd,
                        color: Colors.white,
//  fontSize: 75
                        fontSize: screenwidth*0.2
                    ),textAlign: TextAlign.center,),),
                    Container(
                      child: Text("min",style: TextStyle(
                          fontFamily: interregular,
                          color: Colors.white.withOpacity(0.6),
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
                            colors: [exoheallightgreen,Color(0xffefefef).withOpacity(0.4)]
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
                            controller: mainbtcontroller.scrollController,
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
                              mainbtcontroller.settime(5);


                            },
                            child:
                            AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              //     height: 48,width: 48,
                              height: screenwidth*0.16,width: screenwidth*0.16,
                              decoration: BoxDecoration(
                                  color: mainbtcontroller.timetapped==5?exoheallightgreen:exohealanotherbggrey,
                                  shape: BoxShape.circle
                              ),
                              child: Center(child:Text("5m",style: TextStyle(
                                  fontFamily: intermedium,
                                  color:mainbtcontroller.timetapped==5?exohealanotherbggrey: Colors.white70,
                                  //       fontSize: 15
                                  fontSize: screenwidth*0.036
                              ),)),
                            )),
                        GestureDetector(
                            onTap: (){
                              mainbtcontroller.settime(10);

                            },
                            child:
                            AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              //       height: 48,width: 48,
                              height: screenwidth*0.16,width: screenwidth*0.16,
                              decoration: BoxDecoration(
                                  color: mainbtcontroller.timetapped==10?exoheallightgreen:exohealanotherbggrey,
                                  shape: BoxShape.circle
                              ),
                              child: Center(child:Text("10m",style: TextStyle(
                                  fontFamily: intermedium,
                                  color:mainbtcontroller.timetapped==10?exohealanotherbggrey: Colors.white70,
                                  //fontSize: 15
                                  fontSize: screenwidth*0.036
                              ),)),
                            )),
                        GestureDetector(
                            onTap: (){
                              mainbtcontroller.settime(15);
                            },
                            child:
                            AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              //      height: 48,width: 48,
                              height: screenwidth*0.18,width: screenwidth*0.18,
                              decoration: BoxDecoration(
                                  color: mainbtcontroller.timetapped==15?exoheallightgreen:exohealanotherbggrey,
                                  shape: BoxShape.circle
                              ),
                              child: Center(child:Text("15m",style: TextStyle(
                                  fontFamily: intermedium,
                                  color: mainbtcontroller.timetapped==15?exohealanotherbggrey: Colors.white70,
                                  //        fontSize: 15
                                  fontSize: screenwidth*0.036
                              ),)),
                            )),
                        GestureDetector(
                            onTap: (){
                              mainbtcontroller.settime(20);

                            },
                            child:
                            AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              //   height: 48,width: 48,
                              height: screenwidth*0.16,width: screenwidth*0.16,
                              decoration: BoxDecoration(
                                  color: mainbtcontroller.timetapped==20?exoheallightgreen:exohealanotherbggrey,
                                  shape: BoxShape.circle
                              ),
                              child: Center(child:Text("20m",style: TextStyle(
                                  fontFamily: intermedium,
                                  color: mainbtcontroller.timetapped==20?exohealanotherbggrey: Colors.white70,
                                  //ontSize: 15
                                  fontSize: screenwidth*0.036
                              ),)),
                            )),

                      ],),
                    ),
                    GestureDetector(
                        onTap: (){
                          mainbtcontroller.setdurationandstartCountdown(context);
                        },
                        child:
                        AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          //    height: 110,width: 110,
                          padding: EdgeInsets.symmetric(horizontal: 20,
                          vertical: 14),
                          width: screenwidth*0.5,
                          //height: screenwidth*0.2933,width: screenwidth*0.2933,
                          decoration: BoxDecoration(
                              color: exoheallightgreen,
                          borderRadius: BorderRadius.all(Radius.circular(40))
                          ),
                          child: Center(child:Text("Set Timer",style: TextStyle(
                              fontFamily: intermedium,
                              color:exohealdarkmodepagebg,
                              letterSpacing: -0.1,
                              //     fontSize: 46
                              fontSize: screenwidth*0.04
                          ),)),
                        )),
                  ],),
              ),
            ),)
        );
      }
    );
  }

}
