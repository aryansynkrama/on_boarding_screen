import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_boarding_screen/contants/string_constant.dart';
import 'package:on_boarding_screen/ui/on_boarding/registration_screen/registration_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  RegExp isValidEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
            top: screenHeight * 0.21,
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
                  topLeft: Radius.elliptical(40, 38),
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
                  topLeft: Radius.elliptical(40, 38),
                  bottomLeft: Radius.elliptical(28, 40),
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
                        SizedBox(height: screenHeight * 0.04),
                        Text(
                          StringConstant.username,
                          style: TextStyle(
                            fontSize: screenHeight * 0.026,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.4,
                          ),
                        ),
                        TextFormField(
                          minLines: 1,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.001),
                            labelText: StringConstant.userLabelText,
                            labelStyle: TextStyle(
                              fontSize: screenHeight * 0.018,
                            ),
                          ),
                          controller: emailController,
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
                        SizedBox(height: screenHeight * 0.025),
                        Text(
                          StringConstant.password,
                          style: TextStyle(
                            fontSize: screenHeight * 0.026,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.4,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.001),
                            border: const UnderlineInputBorder(),
                            labelText: StringConstant.passwordLabelText,
                            labelStyle: TextStyle(
                              fontSize: screenHeight * 0.018,
                            ),
                          ),
                          controller: passwordController,
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
                        SizedBox(height: screenHeight * 0.016),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            StringConstant.forgetPassword,
                            style: TextStyle(
                              color: Color(0xff2a554d),
                              fontSize: screenHeight * 0.021,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildRow(),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  navigateToNextScreen(context);
                                }
                              },
                              child: Container(
                                height: screenHeight * 0.047,
                                width: screenWidth * 0.23,
                                decoration: BoxDecoration(
                                  color: Color(0xff294a41),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(20, 20),
                                    bottomRight: Radius.elliptical(20, 20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    StringConstant.signIn,
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: screenHeight * 0.0235,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Divider(
                          thickness: 0,
                          color: Colors.black,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: buildContainer(StringConstant.googleImagePath),
                                onTap: () {
                                  _launchUrl(StringConstant.googleUrl);
                                },
                              ),
                              Text(
                                "or",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                              GestureDetector(
                                child: buildContainer(StringConstant.appleImagePath),
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
      height: MediaQuery.of(context).size.height * 0.055,
      width: MediaQuery.of(context).size.width * 0.14,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        color: Color(0xffdbede7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(14, 14),
          bottomRight: Radius.elliptical(14, 14),
        ),
      ),
      child: Image.asset(
        imagePath,
        color: Color(0xff2a554d),
        scale: 1.6,
      ),
    );
  }

  Widget buildRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.85,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.07,
            height: MediaQuery.of(context).size.width * 0.08,
            child: Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          ),
        ),
        // SizedBox(width: MediaQuery.of(context).size.width * 0.00005),
        Text(
          StringConstant.rememberMe,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.020,
            fontWeight: FontWeight.w500,
            color: Color(0xff2a554d),
          ),
        ),
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

  void navigateToNextScreen(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationScreen(),));
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $uri');
    }
  }
}

