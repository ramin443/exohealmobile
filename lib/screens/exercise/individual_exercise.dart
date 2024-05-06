import 'dart:math';

import 'package:exohealandroid/constants/color_constants.dart';
import 'package:exohealandroid/getxcontrollers/mainBTController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/fontconstants.dart';
import '../../datamodels/ExerciseModel.dart';
import '../../getxcontrollers/fulllapcontroller.dart';

class IndividualExercise extends StatelessWidget {
  final ExerciseModel? exerciseModel;

  IndividualExercise({this.exerciseModel});

  final FullLapController fullLapController = Get.put(FullLapController());
  final MainBTController mainBTController = Get.put(MainBTController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return GetBuilder<MainBTController>(
      init: MainBTController(),
      builder: (mainbtcontroller) {
        return GetBuilder<FullLapController>(
            initState: (v) {
              mainbtcontroller.scrollController.addListener(mainbtcontroller.scrollListener);
              mainbtcontroller.checkifNotConnectedthenConnect(mainbtcontroller.isExohealConnected);
              fullLapController.clearData();
              fullLapController.setinitialdocreport();
              fullLapController.stopTimer();
              fullLapController.setmessageboxfalse();
              fullLapController.initstat();
            },
            init: FullLapController(),
            builder: (fulllapcontroller) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(

                  backgroundColor: Colors.white,
                  elevation: 0,
                  actions: [
                    IconButton(
                        onPressed: () {
                          print(mainbtcontroller.isConnected);
                          mainbtcontroller.connectManuallywithAddress(context);
//                      Connect manually here
                          //homecontroller.listendevices();
                          //   homecontroller.tryazure();
                          // homecontroller.scanbluetoothdevices();
                        },
                        icon: const Icon(
                          CupertinoIcons.command,
                          size: 24,
                          color: Colors.black54,
                        ))
                  ],
                  leading: IconButton(
                      onPressed: () {
                      //  fulllapcontroller.shutgraph();
                        fulllapcontroller.setmirrortherapyfalse();
                        fulllapcontroller.settimerfalse();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.arrow_left,
                        size: 20,
                        color: Colors.black54,
                      )),
                  centerTitle: true,
                  title:
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: screenwidth*0.05),
                        child: Text(
                          exerciseModel!.exercisetype.toString(),
                          style: TextStyle(
                              fontFamily: intersemibold,
                              fontSize: screenwidth * 0.042,
                              color: Colors.black87),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: screenwidth*0.018),
                        child: mainbtcontroller.isExohealConnected?Text(

                          "Connected",style: TextStyle(
                            fontFamily: intermedium,
                            color: exoheallightgreen,
                            fontSize: screenwidth*0.0313
                        ),):
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text(

                              "Not Connected",style: TextStyle(
                                fontFamily: intermedium,
                                color: exohealightred ,
                                fontSize: screenwidth*0.0313
                            ),),

                          ],
                        ),
                      )
                    ],
                  ),

                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: screenwidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        fulllapcontroller.exercisedetail(context, exerciseModel!),

                        fulllapcontroller.mirrortherapyanim(context),
                        fulllapcontroller.timerprogressindicator(context),
                        fulllapcontroller.timercontrolbuttons(context,exerciseModel!),

//                        fulllapcontroller.exercisenotstartedstate(context,exerciseModel!),
                      /*  fulllapcontroller.istimercomplete
                            ? fulllapcontroller.exercisecompletedstate(context)
                            : fulllapcontroller.exerciserunningstate(context, exerciseModel!),*/
                        //  fulllapcontroller.exerciserunning(context),
                        /*           fulllapcontroller.loading?
                        fulllapcontroller.connectingcolumn(context):
                    fulllapcontroller.notconnectedcolumn(context)*/
                      ],
                    ),
                  ),
                ),
              );
            });
      }
    );
  }
}
