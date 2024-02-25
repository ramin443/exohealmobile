import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/color_constants.dart';
import '../../constants/fontconstants.dart';
import '../../getxcontrollers/progresscontroller.dart';
class ProgressPage extends StatelessWidget {
   ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return GetBuilder<ProgressController>(
        init: ProgressController(),
        builder: (progresscontroller){
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
                  "Progress",
                  style: TextStyle(
                      fontFamily: intermedium,
                      fontSize: 16,
                      color: Color(0xff404040)),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body:
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: screenwidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FirebaseAuth.instance.currentUser!.email!=testuseremail?
                    progresscontroller.progressemptystate(context):
                    Container(
                      width: screenwidth,
                      padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0693),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          progresscontroller.showindivhandwithsensations(context),
                          Container(
                            margin: EdgeInsets.only(
                                top: screenwidth * 0.016, bottom: screenwidth * 0.016,

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
                                    "Sensations recorded over time",
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
                          progresscontroller.fingergraph(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );});
  }
}
