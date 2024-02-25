import 'package:exohealandroid/constants/color_constants.dart';
import 'package:exohealandroid/getxcontrollers/mainBTController.dart';
import 'package:exohealandroid/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';

import '../../constants/fontconstants.dart';
import '../../constants/image_constants.dart';
class PairDevicePage extends StatelessWidget {
   PairDevicePage({Key? key}) : super(key: key);
  MainBTController mainBTController = Get.put(MainBTController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.sizeOf(context).width;
    double screenheight = MediaQuery.sizeOf(context).height;
    return GetBuilder<MainBTController>(
        initState: (v){
          // mainBTController.allconnectiononInitialize();

        },
        init: MainBTController(),
        builder: (mainbtcontroller){
          return SingleChildScrollView(
            child: Container(
              height: screenheight*0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mainbtcontroller.isscanning
                      ? LoopAnimationBuilder<double>(
                    builder: (context, value, _) {
                      return Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          AnimatedContainer(
                            height: screenwidth * 0.753,
                            width: screenwidth * 0.753,
                            decoration: BoxDecoration(
                                color: value > 3
                                    ? Color(0xff343433).withOpacity(0.47)
                                    : Color(0xff343433).withOpacity(0),
                                shape: BoxShape.circle),
                            duration: Duration(milliseconds: 750),
                          ),
                          AnimatedContainer(
                            height: screenwidth * 0.623,
                            width: screenwidth * 0.623,
                            decoration: BoxDecoration(
                                color: value > 2
                                    ? Color(0xff343433).withOpacity(0.47)
                                    : Color(0xff343433).withOpacity(0),
                                shape: BoxShape.circle),
                            duration: Duration(milliseconds: 750),
                          ),
                          AnimatedContainer(
                            height: screenwidth * 0.463,
                            width: screenwidth * 0.463,
                            decoration: BoxDecoration(
                                color: value > 1
                                    ? Color(0xff343433).withOpacity(0.47)
                                    : Color(0xff343433).withOpacity(0),
                                shape: BoxShape.circle),
                            duration: Duration(milliseconds: 750),
                          ),
                          AnimatedContainer(
                            height: screenwidth * 0.303,
                            width: screenwidth * 0.303,
                            decoration: BoxDecoration(
                                color: Color(0xff343433).withOpacity(0.47),
                                shape: BoxShape.circle),
                            duration: Duration(milliseconds: 750),
                            child: Container(
                              child: Center(
                               /* child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 750),
                                  child: value > 3
                                      ? SvgPicture.asset(
                                    threelinewifi,
                                    width: screenwidth * 0.096,
                                  )
                                      : value > 2
                                      ? SvgPicture.asset(
                                    twolinewifi,
                                    width: screenwidth * 0.096,
                                  )
                                      : value > 1
                                      ? SvgPicture.asset(
                                    onelinewifi,
                                    width:
                                    screenwidth * 0.096,
                                  )
                                      : value > 0
                                      ? SizedBox(
                                    height: 0,
                                  )
                                      : SvgPicture.asset(
                                    threelinewifi,
                                    width: screenwidth *
                                        0.096,
                                  ),
                                ),*/
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    duration: const Duration(seconds: 4),
                    tween: Tween<double>(begin: 0, end: 4),
                  )
                      : Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      AnimatedContainer(
                        height: screenwidth * 0.753,
                        width: screenwidth * 0.753,
                        decoration: BoxDecoration(
                            color: Color(0xff343433).withOpacity(0.47),
                            shape: BoxShape.circle),
                        duration: Duration(milliseconds: 750),
                      ),
                      AnimatedContainer(
                        height: screenwidth * 0.623,
                        width: screenwidth * 0.623,
                        decoration: BoxDecoration(
                            color: Color(0xff343433).withOpacity(0.47),
                            shape: BoxShape.circle),
                        duration: Duration(milliseconds: 750),
                      ),
                      AnimatedContainer(
                        height: screenwidth * 0.463,
                        width: screenwidth * 0.463,
                        decoration: BoxDecoration(
                            color: Color(0xff343433).withOpacity(0.47),
                            shape: BoxShape.circle),
                        duration: Duration(milliseconds: 750),
                      ),
                      AnimatedContainer(
                        height: screenwidth * 0.303,
                        width: screenwidth * 0.303,
                        decoration: BoxDecoration(
                            color: Color(0xff343433).withOpacity(0.47),
                            shape: BoxShape.circle),
                        duration: Duration(milliseconds: 750),
                        child: Container(
                          child: Center(
                            /*child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 750),
                                child: SvgPicture.asset(
                                  threelinewifi,
                                  width: screenwidth * 0.096,
                                )),*/
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenwidth * 0.0623),
                    child: Text(
                      mainbtcontroller.mainscantitle

                      ,
                      style: TextStyle(
                          letterSpacing: -0.1,
                          fontFamily: intersemibold,
                          color: Colors.white,
                          fontSize: screenwidth * 0.0533),
                    ),
                  ),
                  Container(
                    width: screenwidth*0.9,
                    margin: EdgeInsets.only(
                        top: screenwidth * 0.016, bottom: screenwidth * 0.0667),
                    child: Text(
                      "Please ensure that your Exoheal device is connected \nto power supply and Bluetooth is turned on.",
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                          letterSpacing: -0.1,
                          fontFamily: intermedium,
                          color: exohealgrey,
                          fontSize: screenwidth * 0.0303),
                    ),
                  ),

                  /* mainbtcontroller.isscanning?
              Container(
                height: screenwidth,
                child: mainbtcontroller.alldiscovereddevice(context),
              )
                  :
              SizedBox(height: 0,),*/
                  mainbtcontroller.getactivescanbutton(context),
           //   mainbtcontroller.testbuttonrow(context)
              //    mainbtcontroller.progresshistoryslider(context),
           //       mainbtcontroller.profileTabs(context),
          //        mainbtcontroller.recentsessionslist(context),
            //      mainbtcontroller.streakSection(context),
                ],
              ),
            ),
          );
        });
  }
}
