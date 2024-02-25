import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/fontconstants.dart';
import '../../../getxcontrollers/doctorauthcontrollelr.dart';
class DoctorsLogin extends StatelessWidget {
  const DoctorsLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return GetBuilder<DoctorAuthController>(
      initState: (v){

      },
        init: DoctorAuthController(),
        builder: (doctorsauthcontroller){
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
                child: Container(
                  width: screenwidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenwidth,
                        height: screenwidth*0.549,
                        decoration: BoxDecoration(
                          color: Color(0xffF8F5F2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
//                        height:65,width:65,
                              height:screenwidth*0.173,width:screenwidth*0.173,
                              margin: EdgeInsets.only(bottom: screenwidth*0.0746,
                                  left: screenwidth*0.0693),
                              decoration: BoxDecoration(
                                color: Color(0xff19221D),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset("assets/images/Arhive_light.svg",
                                  width: screenwidth*0.0933,),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: screenwidth,
                        padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0693),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: screenwidth*0.072),
                              child:
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontFamily: intersemibold,
                                      color: Color(0xff373737),
                                      fontSize: screenwidth*0.0746
                                  ),
                                  children:[
                                    TextSpan(text: "Sign In as a"),
                                    TextSpan(text: " Doctor",
                                      style: TextStyle(
                                          fontFamily: intersemibold,
                                          color: exohealgreen,
                                          fontSize: screenwidth*0.0746
                                      ),),
                                  ]
                                ),
                              )
                            ),]

                      )

                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4,left: 4),
                        width: screenwidth,
                        padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0699),
                        child:
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontFamily: intermedium,
                                      color: Color(0xff656565),
                                      fontSize: screenwidth*0.032
                                  ),
                                  children:[
                                    TextSpan(text: "Review ",
                                      style: TextStyle(
                                          fontFamily: intermedium,
                                          color: exohealgreen,
                                          fontSize: screenwidth*0.032
                                      ),),
                                    TextSpan(text: "patients and "),
                                    TextSpan(text: "help them recover ",
                                      style: TextStyle(
                                          fontFamily: intermedium,
                                          color: exohealgreen,
                                          fontSize: screenwidth*0.032
                                      ),),
                                    TextSpan(text: "faster."),
                                  ]
                              ),

                            ),
                          ],
                        )

                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0643),
                          child: doctorsauthcontroller.doctorloginfields(context)),

                    ],
                  ),
                ),
            ),
          );});
  }
}
