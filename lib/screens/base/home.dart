import 'package:exohealandroid/constants/color_constants.dart';
import 'package:exohealandroid/getxcontrollers/mainBTController.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/fontconstants.dart';
import '../../getxcontrollers/homecontroller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final HomeController homeController = Get.put(HomeController());
  final MainBTController mainBTController = Get.put(MainBTController());

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return GetBuilder<MainBTController>(
        initState: (v) {},
        init: MainBTController(),
        builder: (mainbtcontroller) {
          return GetBuilder<HomeController>(
              initState: (v) {
                mainbtcontroller.checkifNotConnectedthenConnect(mainbtcontroller.isExohealConnected);
                //   homeController.setmessageboxfalse();
                homeController.getOnBoardingConfig();
                homeController.getlatestAISuggestedExercises();
              },
              init: HomeController(),
              builder: (homecontroller) {
                return Scaffold(
                  key: _key,
                  drawer: homecontroller.drawer(context),
                  backgroundColor: exohealdarkmodepagebg,
                  appBar: AppBar(
                    backgroundColor: exohealdarkmodepagebg,
                    elevation: 0,
                    actions: [
                     /* IconButton(
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
                            color: Colors.white,
                          ))*/
                    ],
                    leading: IconButton(
                        onPressed: () {
                          _key.currentState!.openDrawer();
                        },
                        icon: Icon(
                          FeatherIcons.menu,
                          size: 20,
                          color: Colors.white,
                        )),
                    centerTitle: true,
                    title: Container(
                      child: Text(
                        "Exoheal",
                        style: TextStyle(
                            fontFamily: proximanovaregular,
                            fontSize: 20,
                            color:Colors.white),
                      ),
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
                          homecontroller.loading
                              ? homecontroller.connectingcolumn(context)
                              :
                          mainbtcontroller.isExohealConnected?
                          homecontroller.connectedcircle(context):
                          homecontroller.notconnectedcircle(context),
                          homecontroller.showmessagebox
                              ? homecontroller.messagebox(context)
                              : SizedBox(
                            height: 0,
                          ),
                          Container(
                            width: screenwidth,
                            margin: EdgeInsets.only(top: screenwidth * 0.0186),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: screenwidth * 0.074),
                                  child: Text(
                                    "Make sure you have bluetooth\n"
                                        "on your device turned on",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: intermedium,
                                        color: Color(0xffA8A8A8),
                                        fontSize: screenwidth * 0.0293),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: screenwidth * 0.028,
                              left: screenwidth * 0.0666,
                              right:screenwidth * 0.0666, ),
                            child: SvgPicture.asset(
                              "assets/images/separation.svg",
                              width: screenwidth,
                            ),
                          ),
                          homecontroller.AIsuggestionsSection(context),
                          homecontroller.recentsessionslist(context),
                          homecontroller.streakSection(context),
                          homecontroller.exerciseHistorySection(context),
                          SizedBox(height: screenwidth*0.06,)
                          // homecontroller.history_home(context, homecontroller.staticlist)
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}