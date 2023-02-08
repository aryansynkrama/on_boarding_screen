import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_boarding_screen/contants/string_constant.dart';
import 'package:on_boarding_screen/database/database_helper.dart';
import 'package:on_boarding_screen/model/user_model.dart';
import 'package:on_boarding_screen/ui/on_boarding/registration_screen/registration_screen.dart';
import 'package:on_boarding_screen/ui/on_boarding/show_users.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  RegExp isValidEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            StringConstant.backgroundImageAsset,
            fit: BoxFit.fill,
            height: screenHeight,
            width: screenWidth,
            // width: screenWidth,
          ),
          Positioned(
            top: screenHeight * 0.2,
            left: screenWidth * 0.1,
            child: Text(
              StringConstant.loginButton,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.065,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.68,
              // width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(30, 40),
                  // bottomLeft: Radius.circular(60),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: screenHeight * 0.65,
              width: screenWidth * 0.96,
              decoration: BoxDecoration(
                color: Color(0xffdbede9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(30, 40),
                  bottomLeft: Radius.elliptical(30, 40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 45, top: 30),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.st,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          StringConstant.username,
                          style: TextStyle(
                            fontSize: screenHeight * 0.025,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.1,
                          child: MyTextFormField(
                            controller: usernameController,
                            screenHeight: screenHeight,
                            fontSize: screenHeight * 0.018,
                            labelText: StringConstant.userLabelText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return StringConstant.pleaseEnterTheEmail;
                              } else {
                                bool result = validateEmail(value);
                                if (result) {
                                  return null;
                                } else {
                                  return StringConstant.pleaseEnterCorrectEmail;
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        Text(
                          StringConstant.password,
                          style: TextStyle(
                            letterSpacing: 0.2,
                            fontSize: screenHeight * 0.025,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.1,
                          child: MyTextFormField(
                            // focusNode: FocusScope.of(context).requestFocus(FocusNode()),
                            controller: passwordController,
                            screenHeight: screenHeight,
                            labelText: StringConstant.passwordLabelText,
                            fontSize: screenHeight * 0.025,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return StringConstant.pleaseEnterThePassword;
                              } else {
                                bool result = validatePassword(value);
                                if (result) {
                                  return null;
                                } else {
                                  return StringConstant.passwordShouldContain;
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.016),

                        GestureDetector(
                          onTap: () async {
                            // await DatabaseHelper.instance
                            //     .add(User(username: usernameController.text, password: passwordController.text));
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              StringConstant.forgetPassword,
                              style: TextStyle(
                                fontSize: screenHeight * 0.022,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2a554d),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildRow(),
                            GestureDetector(
                              onTap: ()async {
                                // if (_formKey.currentState!.validate()) {
                                await DatabaseHelper.instance
                                    .add(User(username: usernameController.text, password: passwordController.text));
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ShowUser(),
                                    ),
                                  );
                                // }
                              },
                              child: Container(
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.25,
                                decoration: BoxDecoration(
                                  color: Color(0xff294a41),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(15, 15),
                                    bottomRight: Radius.elliptical(15, 15),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    StringConstant.signIn,
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: screenHeight * 0.02),
                        Divider(
                          thickness: 1,
                          color: Colors.black54,
                        ),
                        SizedBox(height: screenHeight * 0.038),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: buildContainer(
                                    StringConstant.googleImagePath),
                                onTap: () {
                                  _launchUrl(StringConstant.googleUrl);
                                },
                              ),
                              Text(
                                StringConstant.or,
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                              GestureDetector(
                                child: buildContainer(
                                    StringConstant.appleImagePath),
                                onTap: () {
                                  _launchUrl(StringConstant.appleUrl);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer(String imagePath) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.135,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        color: Color(0xffdbede7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(15, 15),
          bottomRight: Radius.elliptical(15, 15),
        ),
      ),
      child: Image.asset(
        imagePath,
        color: Color(0xff2a554d),
        scale: 1.5,
      ),
    );
  }

  Widget buildRow() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.height * 0.04,
          child: Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
        Text(
          StringConstant.rememberMe,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.020,
            fontWeight: FontWeight.w500,
            color: Color(0xff2a554d),
          ),
        )
      ],
    );
  }

  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  bool validateEmail(String email) {
    String _email = email.trim();
    if (isValidEmail.hasMatch(_email)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception("${StringConstant.couldNotLaunch} $uri");
    }
  }
}

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.screenHeight,
    this.labelText,
    this.fontSize,
    this.validator,
    this.controller, this.focusNode,
  });

  final double screenHeight;
  final String? labelText;
  final double? fontSize;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 1),
          errorStyle: TextStyle(height: 1),
          border: UnderlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: fontSize,
          )),
      validator: validator,

      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return StringConstant.pleaseEnterTheEmail;
      //   } else {
      //     bool result = validateEmail(value);
      //     if (result) {
      //       return null;
      //     } else {
      //       return StringConstant.pleaseEnterCorrectEmail;
      //     }
      //   }
      // },
    );
  }
}
