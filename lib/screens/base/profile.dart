import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../constants/fontconstants.dart';
import '../../getxcontrollers/mainBTController.dart';
import '../../getxcontrollers/profilecontroller.dart';
class Profile extends StatelessWidget {
   Profile({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
   final ProfileController profileController = Get.put(ProfileController());
   final MainBTController mainBTController = Get.put(MainBTController());
   @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.sizeOf(context).width;
    return
      GetBuilder<ProfileController>(
          initState: (v){
            profileController.setnameandemail();
          },
          init: ProfileController(),
          builder: (profilecontroller){
        return Scaffold(
          key: _key,
          backgroundColor: exohealdarkmodepagebg,
          drawer: profilecontroller.drawer(context),
          appBar: AppBar(
            backgroundColor: exohealdarkmodepagebg,
            elevation: 0,
            actions: [
              profilecontroller.changemade?
              GestureDetector(onTap: (){
                profilecontroller.updateuserdata(context);
              }, child:  Container(
                child: Text("Save",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: exohealgreen,
                      fontSize: 14
                  ),),
              ),):
              SizedBox(height: 0,),

            ],
            leading: IconButton(
                onPressed: () {
                  _key.currentState!.openDrawer();
//                  profilecontroller.putprofiledatablob();
                },
                icon: const Icon(
                  FeatherIcons.menu,
                  size: 20,
                  color: Colors.white70,
                )),
            centerTitle: true,
            title: Container(
              child: Text(
                "Profile",
                style: TextStyle(
                    fontFamily: proximanovaregular,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profilecontroller.profileSection(context),
                profilecontroller.profileTabs(context),
                  profilecontroller.toggleProfileSection(context),
                  /*
                  profilecontroller.getprofilerow(context),
                  profilecontroller.borderline(context),
                  profilecontroller.profileoptionscolumn(context),
*/
                ],
              ),
            ),
          ),
      );});
    }

  }

