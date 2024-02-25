
import 'package:get/get.dart';
import '../screens/base/exercises.dart';
import '../screens/base/home.dart';
import '../screens/base/profile.dart';

class BaseController extends GetxController{
  int selectedindex=0;
  List children=[Home(),Exercises(),Profile()];
  setindex(int index){
    selectedindex=index;
    update();
  }
}