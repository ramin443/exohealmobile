import 'package:exohealandroid/getxcontrollers/fulllapcontroller.dart';
import 'package:exohealandroid/screens/pairing/pairDevicePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../getxcontrollers/mainBTController.dart';
class MainPair extends StatelessWidget {
  const MainPair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.sizeOf(context).width;
    double screenheight=MediaQuery.sizeOf(context).height;
    return GetBuilder<MainBTController>(
        init: MainBTController(),
        initState: (v){

  },
        builder: (mainbtcontroller) {
          return Scaffold(
            backgroundColor: exohealdarkmodepagebg,
            body: Stack(
              children: [
                Container(
                  width: screenwidth,
                  height: screenheight,
                  decoration: BoxDecoration(
                      color: exohealdarkmodepagebg
                  ),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: screenwidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppBar(
                          automaticallyImplyLeading: false,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),
                        mainbtcontroller.pagebackRrow(context),
                        SizedBox(height: screenwidth*0.08,),
                        PairDevicePage()
                      ],
                    ),
                  ),
                ),
              //  mainbtcontroller.displaywidgetfounddialog(context, mainbtcontroller.allconnecteddevices)

              ],
            ),

          );

        }
    );  }
}
