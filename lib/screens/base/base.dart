import 'package:exohealandroid/constants/color_constants.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/fontconstants.dart';
import '../../getxcontrollers/basecontroller.dart';
class Base extends StatelessWidget {
   Base({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.black,
        statusBarBrightness: Brightness.light));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    double screenwidth=MediaQuery.of(context).size.width;
    return
      GetBuilder<BaseController>(
          initState: (v){},
          init: BaseController(),
          builder: (basecontroller){
        return Scaffold(
        backgroundColor: exohealanotherbggrey,
          bottomNavigationBar: Container(
            //  height: 91,
            //  height: screenwidth*0.233,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, -6),
                      color: Color(0x0000000D),
                      blurRadius: 25)
                ],
                color: exohealanotherbggrey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: BottomNavigationBar(

              onTap: (index){
           //     print(screenwidth.toStringAsFixed(1));
                basecontroller.setindex(index);
              },
              iconSize:  screenwidth*0.0583,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: exohealanotherbggrey,
              type: BottomNavigationBarType.fixed,
              currentIndex: basecontroller.selectedindex,
              items: [
                BottomNavigationBarItem(
                  label: "",
                    backgroundColor: exohealanotherbggrey,
                      icon:
                Container(
                  child: Column(
                    children: [
                      Icon(FeatherIcons.home,size: screenwidth*0.0589,
                        color:  basecontroller.selectedindex==0?
                        Colors.white:Colors.grey
                        ,
                      ),
                      Container(
                        margin: EdgeInsets.only(
//                                bottom: 15, top: 10
                            bottom: screenwidth*0.0024, top: screenwidth*0.0084
                        ),
                        child: Text("Home",
                          style: TextStyle(
                              fontFamily: intermedium,
                              color: basecontroller.selectedindex==0?Colors.white
                                  :Colors.grey,
                              fontSize: screenwidth*0.0291
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
                BottomNavigationBarItem(
//                    backgroundColor: Colors.transparent,
                    label: "",
                    icon: Container(
                      child: Column(
                        children: [
                          Icon(FeatherIcons.gitPullRequest,size: screenwidth*0.0589,
                  color:  basecontroller.selectedindex==1?
                  Colors.white:Colors.grey
                  ,
                ),
                          Container(
                            margin: EdgeInsets.only(
//                                bottom: 15, top: 10
                                bottom: screenwidth*0.0024, top: screenwidth*0.0084
                            ),
                            child: Text("Exercise/ Progress",
                              style: TextStyle(
                                  fontFamily: intermedium,
                                  color: basecontroller.selectedindex==1?Colors.white
                                      :Colors.grey,
                                  fontSize: screenwidth*0.0291
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                /*        BottomNavigationBarItem(
                          backgroundColor: Colors.transparent,
                          title: Text(""),    icon: SvgPicture.asset(
                        basecontroller.currentindex==2?
                        "assets/selectedlisticon.svg":
                        "assets/unselectedlists.svg",
                      //  width: 24,
                        width: screenwidth*0.0615,
                        //   color: Colors.black,
                      )),*/
                BottomNavigationBarItem(
                    label: "",
                    backgroundColor: Colors.transparent,
            icon:
                Container(
                  child: Column(
                    children: [
                      Icon(FeatherIcons.user,size: screenwidth*0.0589,
                        color:  basecontroller.selectedindex==2?
                       Colors.white:Colors.grey
                        ,
                      ),
                      Container(
                        margin: EdgeInsets.only(
//                                bottom: 15, top: 10
                            bottom: screenwidth*0.0024, top: screenwidth*0.0084
                        ),
                        child: Text("Profile",
                          style: TextStyle(
                              fontFamily: intermedium,
                              color: basecontroller.selectedindex==2?Colors.white
                                  :Colors.grey,
                              fontSize: screenwidth*0.0291
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),

        body: basecontroller.children[basecontroller.selectedindex],
      );});
    }
  }

