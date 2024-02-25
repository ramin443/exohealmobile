import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/fontconstants.dart';
import '../../datamodels/HistoryModel.dart';
import '../../getxcontrollers/historycontroller.dart';
class HistoryPage extends StatelessWidget {
   HistoryPage({Key? key}) : super(key: key);
  List<HistoryModel> historystaticlist=[
    HistoryModel("Mirror Therapy","exohealgreen", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(Duration(days: 2))), "13:11"),
    HistoryModel("Haptic Exercise","exohealbeige", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now()), "08:15"),
    HistoryModel("Finger Tip Exercise","exohealdarkgrey", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(Duration(days: 1))), "12:22"),
    HistoryModel("Grabbing Exercise","exoheallightgrey", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(Duration(days: 1))), "08:15"),

    HistoryModel("Mirror Therapy","exohealgreen", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(Duration(days: 2))), "13:11"),
    HistoryModel("Grabbing Exercise","exohealbeige", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(Duration(days: 2))), "12:08"),
    HistoryModel("Grabbing Exercise","exohealdarkgrey", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(Duration(days: 3))), "11:09"),
    HistoryModel("Grabbing Exercise","exoheallightgrey", "8 min",
        DateFormat.yMMMMd('en_US').format(DateTime.now().subtract(Duration(days: 3))), "16:05")
  ];
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return GetBuilder<HistoryController>(
        init: HistoryController(),
        builder: (historycontroller){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
//                  profilecontroller.putprofiledatablob();
              },
              icon: Icon(
                CupertinoIcons.arrow_left,
                size: 20,
                color: Color(0xff575757),
              )),
          centerTitle: true,
          title: Container(
            child: Text(
              "History",
              style: TextStyle(
                  fontFamily: intermedium,
                  fontSize: 16,
                  color: Color(0xff404040)),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: screenwidth,
            padding: EdgeInsets.only(left: screenwidth*0.0693,right: screenwidth*0.0693,
            bottom: screenwidth*0.2293),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                historycontroller.showindivhandwithsensations(context),
                FirebaseAuth.instance.currentUser!.email!=testuseremail?
                historycontroller.emptystate(context):
                historycontroller.allhistory(context, historystaticlist)
              ],
            ),
          ),
        ),
      );});
    }
  }

