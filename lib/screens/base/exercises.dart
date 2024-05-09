
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../constants/fontconstants.dart';
import '../../getxcontrollers/exercisecontroller.dart';
import '../../getxcontrollers/mainBTController.dart';
class Exercises extends StatelessWidget {
   Exercises({Key? key}) : super(key: key);
  final ExerciseController exerciseController = Get.put(ExerciseController());
   final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
   final MainBTController mainBTController = Get.put(MainBTController());

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return

      GetBuilder<ExerciseController>(
          initState: (v){
            exerciseController.initscrollcontroller();
          },
          init: ExerciseController(),
          builder: (exercisecontroller){
        return Scaffold(
          key: _key,
          drawer: exercisecontroller.drawer(context),
          backgroundColor:exohealdarkmodepagebg,
          appBar: AppBar(
            backgroundColor: exohealdarkmodepagebg,
            elevation: 0,

            leading: IconButton(
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
                icon: Icon(
                  FeatherIcons.menu,
                  size: 20,
                  color: Colors.white70,
                )),
            centerTitle: true,
            title: Container(
              child: Text(
                "ExoHeal",
                style: TextStyle(
                    fontFamily: proximanovaregular,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: screenwidth,
              padding: EdgeInsets.symmetric(vertical: screenwidth*0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  exercisecontroller.AIexerciserow(context,exercisecontroller.staticexerciselist),
                  exercisecontroller.exerciserow(context,exercisecontroller.staticexerciselist),
                  exercisecontroller.progressrow(context),
                  FirebaseAuth.instance.currentUser!.email!=testuseremail?
                      exercisecontroller.progressemptystate(context):
                fingergraph(context),
                ],
              ),
            ),
          ),
        );});
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
       width: screenwidth * 0.916,
       height: screenwidth * 0.365,
       margin: EdgeInsets.only(top: screenwidth*0.0373,bottom: screenwidth*0.0373),
       padding: EdgeInsets.symmetric(
           vertical: screenwidth * 0.0426, horizontal: screenwidth * 0.0746),
       decoration: BoxDecoration(
           color: exohealanotherbggrey,
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
               color: Color(0xffEFEFEF).withOpacity(0.16),
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
                         ? exoheallightgreen
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
                   color: Colors.white),
             ),
           )
         ],
       ),
     );
   }
  }

