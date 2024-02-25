import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/fontconstants.dart';
class NewBadge extends StatelessWidget {
  const NewBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff77B1F9),
      body: Container(
        width: screenwidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
       Container(
                  width: screenwidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Container(
                          child: Image.asset("assets/images/Group 170.png",
                            height: screenheight,),

                      )
                    ],
                  ),
                ),
                Container(
                  width: screenwidth,
                  height: screenheight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 23),
                        child: Text("You've just earned\na new badge",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: sfproroundedsemibold,
                            color: Colors.white,
                            fontSize: 27
                        ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: screenwidth*0.0453,
                        bottom: screenwidth*0.048,
                        left: 12,right: 12
                        ),
                        margin: EdgeInsets.only(bottom: 60),
                        height: screenwidth*1.076,
                        width: screenwidth*0.834,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  CupertinoIcons.clear_thick_circled,
                                  size: 30,
                                    color: Color(0xffF5A491),
                                )
                              ],
                            ),
                            Container(
                              child: Image.asset("assets/images/Ellipse 143.png",
                              width: screenwidth*0.437,),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: screenwidth*0.0266),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Level 5",style: TextStyle(
                                    fontFamily: sfproroundedmedium,
                                    color: Color(0xff84868D),
                                    fontSize: 16
                                  ),),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("High Five",style: TextStyle(
                                      fontFamily: sfproroundedsemibold,
                                      color: Color(0xff070707),
                                      fontSize: 25
                                  ),),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("+64 xp",style: TextStyle(
                                      fontFamily: sfproroundedsemibold,
                                      color: Color(0xff9BB87B),
                                      fontSize: 21
                                  ),),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: screenwidth*0.6,
                                height: 54,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/Group 169.png",

                                  ),),
                                ),
                                margin: EdgeInsets.only(top: screenwidth*0.0186),
                                child: Center(
                                  child: Text("Claim Reward",style: TextStyle(
                                      fontFamily: sfproroundedmedium,
                                      color: Colors.white,
                                      fontSize: 20
                                  ),),
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 18),
                              width: screenwidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(
                                      FeatherIcons.share,
                                      color: Color(0xff75757E),
                                      size: 22,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text("Share",style: TextStyle(
                                        fontFamily: sfproroundedsemibold,
                                        color: Color(0xff75757E),
                                        fontSize: 20
                                    ),),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
