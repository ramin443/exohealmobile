
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/fontconstants.dart';
class HistoryHome extends StatelessWidget {
  const HistoryHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0693),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin:EdgeInsets.only(left: screenwidth*0.008),
                  child: Text(
                    "History",
                    style: TextStyle(
                        fontFamily: intersemibold,
                        fontSize: screenwidth*0.04,
                        color:exohealdarkgrey),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "View full history",
                          style: TextStyle(
                              fontFamily: intermedium,
                              fontSize: screenwidth*0.0293,
                              color:exohealgrey),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: screenwidth*0.0266),
                        child: Icon(
                          CupertinoIcons.arrow_right,
                            color:exohealgrey,
                          size: 14,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      ),

    );
  }
}
