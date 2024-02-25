import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_constants.dart';
import '../constants/fontconstants.dart';

class DoctorAuthController extends GetxController {
  TextEditingController logindoctoridcontroller = TextEditingController();
  TextEditingController loginhospitalnamecontroller = TextEditingController();
  TextEditingController loginpasswordcontroller = TextEditingController();
  String autherror = "";

  Widget doctorloginfields(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth * 0.0833),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          indivfield(
            context: context,
            fieldname: "Doctor's id",
            hinttext: "robfox@gmail.com",
            fieldicon: Icon(
              FeatherIcons.user,
              color: Color(0xff404d4d),
              //                 size: 18,
              size: screenwidth * 0.0437,
            ),
            textEditingController: logindoctoridcontroller,
          ),
          indivfield(
            context: context,
            fieldname: "Hospital/ Research centre",
            hinttext: "Walter Reed Hospital, etc.",
            fieldicon: Icon(
              FeatherIcons.home,
              color: Color(0xff404d4d),
              //                 size: 18,
              size: screenwidth * 0.0437,
            ),
            textEditingController: loginhospitalnamecontroller,
          ),
          indivfield(
            context: context,
            fieldname: "Enter password",
            hinttext: "at least 8 characters",
            fieldicon: Icon(
              FeatherIcons.user,
              color: Color(0xff404d4d),
              //                 size: 18,
              size: screenwidth * 0.0437,
            ),
            textEditingController: loginpasswordcontroller,
          ),
          loginbutton(context),
          Container(
            width: screenwidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: screenwidth*0.1733,
                        top: screenwidth*0.0533),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontFamily: intermedium,
                              color: Color(0xff656565),
                              fontSize: screenwidth*0.032
                          ),
                          children: [
                            TextSpan(
                                text: "Not registered as a doctor? "
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style:  TextStyle(
                                  fontFamily: intermedium,
                                  color: Color(0xff4CA852),
                                  fontSize: screenwidth*0.032
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget indivfield(
      {BuildContext? context,
      String? fieldname,
      String? hinttext,
        Icon? fieldicon,
      TextEditingController? textEditingController}) {
    double screenwidth = MediaQuery.of(context!).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: screenwidth * 0.0413),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: screenwidth * 0.021,
              bottom: screenwidth * 0.024,
            ),
            child: Text(
              fieldname!,
              style: TextStyle(
                  fontFamily: intermedium,
                  color: Color(0xff656565),
                  fontSize: screenwidth * 0.032),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              //         horizontal: 24
              left: screenwidth * 0.04,
              //     right: screenwidth*0.04
            ),
            //      height: 46,
            height: screenwidth * 0.096,
            width: screenwidth,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffECECEC),
                width: 1,
              ),
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: TextFormField(
                controller: logindoctoridcontroller,
                cursorColor: Colors.black87,
                style: TextStyle(
                    fontFamily: interregular,
                    color: Colors.black87,
                    //       fontSize: 13.5
                    fontSize: screenwidth * 0.0328),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  suffixIcon: fieldicon,
                  border: InputBorder.none,
                  hintText: hinttext,
                  hintStyle: TextStyle(
                      fontFamily: interregular, color: Color(0xffB5B5B5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget errorsections(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        autherror == ""
            ? Container(
                margin: EdgeInsets.only(
                    top: screenwidth * 0.032, right: screenwidth * 0.0246),
                child: Text(
                  "autherror",
                  style: TextStyle(
                    fontFamily: intermedium,
                    color: Colors.transparent,
                    fontSize: screenwidth * 0.0293,
                  ),
                  maxLines: 2,
                ),
              )
            : Container(
                margin: EdgeInsets.only(
                    top: screenwidth * 0.032, right: screenwidth * 0.0246),
                child: Text(
                  autherror,
                  style: TextStyle(
                    fontFamily: intermedium,
                    color: Colors.redAccent,
                    fontSize: screenwidth * 0.0293,
                  ),
                  maxLines: 2,
                ),
              ),
      ],
    );
  }

  Widget loginbutton(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: screenwidth*0.101),
        width: screenwidth,
        height: screenwidth * 0.101,
        padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.0373),
        decoration: BoxDecoration(
          color: exohealgreen,
          borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                CupertinoIcons.arrow_right,
                color: Colors.transparent,
                size: screenwidth * 0.053,
              ),
            ),
            Container(
              child:

              Text(
                "Sign In as Doctor",
                style: TextStyle(
                    fontFamily: intermedium,
                    color: Colors.white,
                    fontSize: screenwidth * 0.0373),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                CupertinoIcons.arrow_right,
                color: Color(0xffECECEC),
                size: screenwidth * 0.053,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
