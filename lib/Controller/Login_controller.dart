import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketapp/Home/bottom_nav_bar.dart';
import 'package:ticketapp/Login/login.dart';
import 'package:ticketapp/Models/accountObj.dart';
import 'package:ticketapp/http/request.dart';

class LoginController extends GetxController {
  var eye=true.obs;
  late final TextEditingController emailController;
  late final TextEditingController emaildkController;
  late final TextEditingController passwordController;
  late final TextEditingController passworddkController;
  late AccountObj accountObj;
  @override
  void onInit() {
    // TODO: implement onInit
    emailController = TextEditingController();
    emaildkController = TextEditingController();
    passwordController = TextEditingController();
    passworddkController = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void apiRegister() async{
    Get.dialog(Center(child: CircularProgressIndicator()));
    var headers = {"Content-type": "application/json"};
    Request request=Request(Url:"https://qlbvxk.herokuapp.com/api/accounts/3",body:jsonEncode({
      "Email" : emaildkController.text,
      "MatKhau" : passworddkController.text
    }),header: headers);
    request.post().then((value){
      print(value.statusCode);


      if(value.statusCode==201){
        Get.back();
        emailController.text=emaildkController.text;
        Get.off(()=>Login());
        Get.snackbar("","Đăng ký thành công!",backgroundColor: Colors.blue);
      }
      else{
        Get.back();
        Get.snackbar("Error", "Tài khoản đã tồn tại");
      }
    }
    ).catchError((e){

    });
  }

  void apiLogin() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var headers = {"Content-type": "application/json"};
    Request request=Request(Url:"https://qlbvxk.herokuapp.com/api/accounts/validate/",body:jsonEncode({
      "Email" : emailController.text,
      "MatKhau" : passwordController.text
    }),header: headers);
    request.post().then((value) async {
      print(value.body);
      AccountObj accountObj =AccountObj.fromJson(json.decode(value.body));
      print(accountObj.maNd);
      if(accountObj.maNd>0){
        SharedPreferences prefs= await SharedPreferences.getInstance();
        prefs.setInt("VaiTro", accountObj.vaitro);
        this.accountObj=accountObj;
        print("Ma ${this.accountObj.maNd}");
        print("Ten ${this.accountObj.tenNd}");
        print("sdt ${this.accountObj.sdt}");
        print("Ngay sinh ${this.accountObj.ngaySinh}");
        print("Dia chi ${this.accountObj.diaChi}");
        print("cmnd ${this.accountObj.cmnd}");

        Get.back();
        passwordController.text="";

        Get.off(()=>BottomNavBar());
      }
      else{
        Get.back();
        Get.snackbar("", "Lỗi Tài Khoản",backgroundColor: Colors.blue,colorText: Colors.white,);
      }
    }
    ).catchError((e){
      print("loi");
    });
  }
  
}
