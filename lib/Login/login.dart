import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ticketapp/Controller/Login_controller.dart';
import 'package:ticketapp/Home/bottom_nav_bar.dart';

import 'package:ticketapp/Login/register.dart';
import 'package:ticketapp/Theme/colors.dart';
import 'package:ticketapp/Theme/styles.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final LoginController loginController=Get.put(LoginController());
  late String user, pass;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.light));
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.scaffold,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.background.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(4, 8),
                          )
                        ]),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Chào bạn!",
                          style: AppThemes.text30container,
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Icon(
                          Icons.directions_bus_rounded,
                          size: 100,
                          color: Colors.black,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.scaffold,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(4, 8),
                          color: AppColors.shadow.withOpacity(0.2),
                        )
                      ]),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: loginController.emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nhập tài khoản: ...@gmail.com';
                            } else {
                              user = value;
                            }
                          },
                          style: AppThemes.Text14,
                          decoration: InputDecoration(
                            labelText: "Tên đăng nhập: ",
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(()=>TextFormField(
                          controller: loginController.passwordController,
                          obscureText: loginController.eye.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nhập pass';
                            } else {
                              pass = value;
                            }
                          },
                          style: AppThemes.Text14,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: (){
                                loginController.eye.value=!loginController.eye.value;
                              },
                              child: Icon(loginController.eye.value?Icons.visibility_off_outlined:Icons.visibility),
                            ),
                            prefixIcon: Icon(Icons.lock_open),
                            labelText: "Mật khẩu: ",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {
                  _dangnhap();
                  // _controllerLogin.IsLogin = true;
                  // Get.to(HomePage());
                },
                color: AppColors.background,
                child: Container(
                  width: 250,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Đăng nhập",
                      style: AppThemes.text18container,
                    ),
                  ),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide:
                    BorderSide(color: AppColors.background, width: 1)),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: _dangky,
                color: AppColors.background,
                child: Container(
                  width: 250,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Đăng ký",
                      style: AppThemes.text18container,
                    ),
                  ),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide:
                    BorderSide(color: AppColors.background, width: 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _dangnhap() {
      if (formKey.currentState!.validate()) {
        loginController.apiLogin();
            }
  }

  void _dangky() {
    Get.to(Dangky());
  }
}
