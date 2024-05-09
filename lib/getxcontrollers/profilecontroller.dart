import 'package:exohealandroid/getxcontrollers/basecontroller.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../constants/color_constants.dart';
import '../constants/fontconstants.dart';
import '../datamodels/ExerciseModel.dart';
import '../screens/exercise/full_lap_exercise.dart';
import '../screens/historyandprogress/history.dart';
import '../screens/historyandprogress/progress.dart';
final BaseController baseController = Get.put(BaseController());
class ProfileController extends GetxController{
  bool changemade=false;
  String useremail="";
  int selectedinfotab=0;
  TextEditingController namecontroller=TextEditingController();
  TextEditingController useremailcontroller=TextEditingController();
  setnameandemail()async{
    String email=FirebaseAuth.instance.currentUser!.email.toString();
    final name=FirebaseAuth.instance.currentUser!.displayName;
    if(name==null){
      useremail=FirebaseAuth.instance.currentUser!.email.toString();

    }else{
      namecontroller.text=FirebaseAuth.instance.currentUser!.displayName.toString();
      useremail=FirebaseAuth.instance.currentUser!.email.toString();

    }
    update();
  }
  void setinfoTabindex(int index){
    selectedinfotab=index;
    update();
  }
  updateuserdata(BuildContext context){
    FirebaseAuth.instance.currentUser!.updateDisplayName(namecontroller.text);
    changemade=false;
    FocusScope.of(context).unfocus();
    update();

  }
  List<ExerciseModel> staticexerciselist=[
    ExerciseModel("exohealgreen", "Finger Tip Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min",'a'),
    ExerciseModel("exohealgreen", "Haptic Exercise Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min",'b'),
    ExerciseModel("exohealgreen", "Mirror Therapy",
        "Make sure you have bluetooth on your device turned on", "8 min",'c'),
    ExerciseModel("exohealgreen", "Grabbing Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min",'d'),
  ];
  Widget toggleProfileSection(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return selectedinfotab==0?recordSection(context):statsSection(context);
  }
  Widget statsSection(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       /* Container(
          width: screenwidth,
          margin: EdgeInsets.only(top: screenwidth*0.032,
              bottom: screenwidth*0.038),
          child: Text(
            "Weekly Streak",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: sfproroundedsemibold,
                color: Colors.white,
                //        fontSize: 18
                fontSize: screenwidth * 0.04),
          ),
        ),*/
        //weeklystreak(context),
        SizedBox(height: screenwidth*0.058,),
        circularProgressSlider(context),
        piechartSection(context),
        exercisePerformanceSection(context),
        SizedBox(height: screenwidth*0.048,),
      ],
    );
  }
  Widget circularProgressSlider(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          progresshistoryslider(context),
        ],
      ),
    );

  }
  Widget piechartSection(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/darkmodeimg/steakpiechart.png",
          width: screenwidth,)
        ],
      ),
    );
  }
  Widget recordSection(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        weeklystreak(context),
        badgesSection(context),
        SizedBox(height: screenwidth
            *0.06,),
        exercisePerformanceSection(context),
        SizedBox(height: screenwidth*0.048,),

      ],
    );
  }
  Widget profileSection(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenwidth*0.250,
            height: screenwidth*0.250,
            decoration: BoxDecoration(
              color: exohealanotherbggrey,
              shape: BoxShape.circle
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: screenwidth*0.032,
            bottom: screenwidth*0.008),
            child: Text(
              "Test User",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intersemibold,
                  color: Colors.white,
                  //        fontSize: 18
                  fontSize: screenwidth * 0.04),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: screenwidth*0.042),
            child: Text(
              "Level 4",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intersemibold,
                  color: exoheallightgreen,
                  //        fontSize: 18
                  fontSize: screenwidth * 0.0326),
            ),
          ),

        ],
      ),
    );
  }
  Widget getrofilerow(BuildContext context) {
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
                left: screenwidth * 0.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "ExoHeal Test User",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealbeige,
                        //        fontSize: 18
                        fontSize: screenwidth * 0.0461),
                  ),
                ),
                Container(
                  child: Text(
                    useremail,
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
  Widget getprofilerow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      padding: EdgeInsets.symmetric(
           horizontal: screenwidth * 0.0461),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.grey,
//            size: 70,
              size: screenwidth * 0.159,
            ),
          ),
          Container(
            //   height: screenwidth * 0.179,
            margin: EdgeInsets.only(

//                left: 16
                left: screenwidth * 0.0410),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                   width: screenwidth*0.6,
                  child:
                  TextFormField(
                    onChanged: (v){
                      changemade=true;
                      update();
                    },
                    controller: namecontroller,
                    cursorColor: Colors.black87,
                    style: TextStyle(
                        fontFamily: interregular,
                        color: Colors.black87,
                        //       fontSize: 13.5
                        fontSize: screenwidth * 0.0361
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(

                      border: InputBorder.none,
                      hintText: 'Your Name',
                      hintStyle: TextStyle(
                          fontFamily: intermedium,
                          color: Colors.grey,
                          fontSize: screenwidth * 0.0361
                      ),

                    ),
                  ),
              /*    Text(
                    "Ramin Udash",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Colors.black87,
                        //        fontSize: 18
                        fontSize: screenwidth * 0.0461),
                  ),*/
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text(
                    useremail,
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Colors.black87,
                        //         fontSize: 14.5
                        fontSize: screenwidth * 0.0371),
                  ),/*Text(
                    "udashramin1@gmail.com",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Colors.black87,
                        //         fontSize: 14.5
                        fontSize: screenwidth * 0.0371),
                  ),*/
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget borderline(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      height: 1,
      decoration: BoxDecoration(
        color: Color(0xffECEBEB),
      ),
    );
  }

  Widget profileoptionscolumn(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        //         vertical: 24
          vertical: 6),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

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
                    bottom: screenwidth * 0.03461,
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
                      size: screenwidth * 0.0615,
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
          borderline(context),
        ],
      ),
    );
  }
putjson(){
    return {};
}
/*
  void putprofiledatablob(String useremail)async{
    var storage=AzureStorage.parse("DefaultEndpointsProtocol=https;AccountName=exohealmobile;AccountKey=+h4pGQ2WYV/c8kR9+Bic+k8keWo4YmH6RONNk/0OFBhocAGMkKJ5sf/6/HOtctZ0FVxEBCEPTmsckznxeuBAoA==;EndpointSuffix=core.windows.net");
    await storage.putBlob('/profile/$useremail.txt',
        body: 'Hello, worlduoooo.');

  }*/


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
                getrofilerow(context),
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
  Widget profileTabs(BuildContext context){
    double screenwidth=MediaQuery.sizeOf(context).width;
    return Container(
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            width: screenwidth*0.685,
            height: screenwidth*0.13,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(28)),
              color: exohealanotherbggrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(

                    onTap: (){
                      setinfoTabindex(0);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: screenwidth*0.07),
                      child: Text(
                        "Record",
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: sfproroundedsemibold,
                            color: selectedinfotab==0?
                            exoheallightgreen:Color(0xffB0B0B0),
                            fontSize: screenwidth*0.045),
                      ),
                    )),
                GestureDetector(

                    onTap: (){
                      setinfoTabindex(1);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: screenwidth*0.07),
                      child: Text(
                        "Statistics",
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: sfproroundedsemibold,
                            color: selectedinfotab==1?
                            exoheallightgreen:Color(0xffB0B0B0),
                            fontSize: screenwidth*0.045),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget weeklystreak(BuildContext context){
    double screenwidth=MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth*0.0),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/darkmodeimg/weeklystereak.png",
          width: screenwidth,)
        ],
      ),
    );
  }
  Widget badgesSection(BuildContext context){
    double screenwidth=MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        individualtopRow(context: context, title:  "Your Badges", tapsection: "View All",description:  "See the collection of your badges from all your exercises done since "
            "the beginning of your hourney with us."),
       /* Container(
          margin:EdgeInsets.only(left: screenwidth*0.0713,bottom:screenwidth*0.0213 ),
          child: Text(
            "See the collection of your badges from all your exercises done since "
            "the beginning of your hourney with us.",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: interregular,
                fontSize: 11,
                color:Color(0xff9c9c9c)),
          ),
        ),*/
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: screenwidth*0.028,
              ),
              child: Image.asset("assets/images/darkmodeimg/allbadges.png",
              width: screenwidth*0.84,),
            )
          ],
        )
      ],
    );
  }
  Widget exercisePerformanceSection(BuildContext context){
    double screenwidth=MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        individualtopRow(context: context, title:  "Exercise Performance", tapsection: "View All",
        description: "See the collection of your badges from all your exercises done since "
            "the beginning of your journey with us."),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/images/darkmodeimg/exercisehistory.png",
                width: screenwidth*0.91,
              ),
            )
          ],
        )
      ],
    );
  }
  Widget individualtopRow(
      {@required BuildContext? context, @required String? title, @required String? tapsection,
        @required String? description
      }){
    double screenwidth=MediaQuery.sizeOf(context!).width;
    return  Container(
      width: screenwidth,
     // margin: EdgeInsets.only(bottom: screenwidth*0.018,),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin:EdgeInsets.only(left: screenwidth*0.0713),
                child: Text(
                  title!,
                  style: TextStyle(
                      fontFamily: intersemibold,
                      fontSize: screenwidth*0.044,
                      color:Colors.white),
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
          SizedBox(height:screenwidth*0.01,),
          Container(
            margin:EdgeInsets.only(left: screenwidth*0.0713,bottom:screenwidth*0.0213 ),
            child: Text(
              description!,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: interregular,
                  fontSize: 11,
                  color:Color(0xff9c9c9c)),
            ),
          ),
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
                            trackColor: Color(0xffC1C7D2).withOpacity(0),
                            progressBarColor:exoheallightgreen
                        ),
                        customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            trackWidth: 12,
                            progressBarWidth: 12)

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
                            trackColor: Color(0xffC1C7D2).withOpacity(0),
                            progressBarColor:exohealpurple
                        ),
                        customWidths: CustomSliderWidths(  trackWidth: 12,
                            handlerSize: 0,
                            progressBarWidth: 12)

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
                            trackColor: Color(0xffC1C7D2).withOpacity(0.0),
                            progressBarColor:exohealightred
                        ),
                        customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            trackWidth: 12,
                            progressBarWidth: 12
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
}