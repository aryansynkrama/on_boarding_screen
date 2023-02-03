import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/image.jpg',
            fit: BoxFit.fill,
            height: screenHeight,
            width: screenWidth,
            // width: screenWidth,
          ),
          Positioned(
            top: screenHeight * 0.2,
            left: screenWidth * 0.1,
            child: Text(
              "Login",
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
                  topLeft: Radius.circular(60),
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
                  topLeft: Radius.circular(60),
                  bottomLeft: Radius.elliptical(30, 40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 45,top: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.st,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        'Username',
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter User ID or Email',
                          labelStyle: TextStyle(
                            fontSize:screenHeight * 0.018,
                          )
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter The Email";
                          } else {
                            bool result = validatePassword(value);
                            if (result) {
                              return null;
                            } else {
                              return "Please Enter Correct Email";
                            }
                          }
                        },
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Password',
                          labelStyle: TextStyle(
                            fontSize:screenHeight * 0.018,
                          )
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter The Password";
                          } else {
                            bool result = validatePassword(value);
                            if (result) {
                              return null;
                            } else {
                              return "Password should contain Capital, Small letters & Numbers & Special Letter";
                            }
                          }
                        },
                      ),
                      SizedBox(height: screenHeight * 0.016),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                            fontSize: screenHeight * 0.022,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildRow(),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: screenHeight * 0.05,
                              width: screenWidth * 0.25,
                              decoration: BoxDecoration(
                                color: Color(0xff294a41),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.elliptical(25, 25),
                                  bottomRight: Radius.elliptical(25, 25),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Sign In",
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
                        color: Colors.black,
                      ),
                      SizedBox(height: screenHeight * 0.038),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: buildContainer('assets/images/google.png'),
                              onTap: () {
                                _launchUrl("www.google.com");
                              },
                            ),
                            Text(
                              "or",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            GestureDetector(
                              child: buildContainer('assets/images/apple.png'),
                              onTap: () {
                                _launchUrl("www.apple.com");
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
        ],
      ),
    );
  }

  Widget buildContainer(String imagePath) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        color: Color(0xffdbede7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(20, 20),
          bottomRight: Radius.elliptical(20, 20),
        ),
      ),
      child: Image.asset(
        imagePath,
        color: Color(0xff2a554d),
      ),
    );
  }

  Widget buildRow() {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Text(
          'Remember Me',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.020,
            fontWeight: FontWeight.w500,
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
    if (pass_valid.hasMatch(_email)) {
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
      throw Exception('Could not launch $uri');
    }
  }
}
