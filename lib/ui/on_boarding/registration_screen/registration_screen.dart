import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding_screen/ui/on_boarding/login_screen/login_screen.dart';
import 'package:on_boarding_screen/ui/on_boarding/registration_screen/utils/elevated_button.dart';
import 'package:on_boarding_screen/ui/on_boarding/registration_screen/utils/text_form_widget.dart';
import 'package:on_boarding_screen/ui/on_boarding/registration_screen/utils/text_util.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  RegExp isValidEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final TextEditingController fNameController = TextEditingController();

  final TextEditingController lNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  late bool visiblePassword;
  late bool visiblePassword1;

  double spacingH = 10;
  double spacingV = 10;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visiblePassword = true;
    visiblePassword1 = true;

  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                defaultHeight(screenHeight * 0.01),
                BuildText(
                  context: context,
                  text: 'Hey there,',
                  fontSize: screenHeight * 0.025,
                ),
                defaultHeight(screenHeight * 0.02),
                BuildText(
                  context: context,
                  text: 'Create an Account',
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.04,
                ),
                defaultHeight(screenHeight * 0.01),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BuildTextFormField(
                        horizontal: spacingH,
                        vertical: spacingV,
                        obscureText: false,
                        controller: fNameController,
                        screenHeight: screenHeight,

                        labelText: 'First Name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter The First Name";
                          } else if (value.length < 3) {
                            return "First Name should be greater then 3";
                          } else {
                            return null;
                          }
                        },
                      ),
                      BuildTextFormField(
                        horizontal: spacingH,
                        vertical: spacingV,
                        obscureText: false,
                        controller: lNameController,
                        screenHeight: screenHeight,
                        labelText: 'Last Name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter The Last Name";
                          } else if (value.length < 3) {
                            return "Last Name should be greater then 3";
                          } else {
                            return null;
                          }
                        },
                      ),
                      BuildTextFormField(
                        horizontal: spacingH,
                        vertical: spacingV,
                        obscureText: false,
                        controller: emailController,
                        screenHeight: screenHeight,
                        labelText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter The Email";
                          } else {
                            bool result = validateEmail(value);
                            if (result) {
                              return null;
                            } else {
                              return "Please Enter The Correct Email";
                            }
                          }
                        },
                      ),
                      BuildTextFormField(
                        horizontal: spacingH,
                        vertical: spacingV,
                        // contentPadding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 30.0),
                        obscureText: visiblePassword,
                        controller: passwordController,
                        screenHeight: screenHeight,
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(visiblePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              visiblePassword = !visiblePassword;
                            });
                          },
                        ),
                        validator: (value) {

                          if(value!.isEmpty){
                            return "Please Enter the Password";
                          }else{
                            bool result = validatePassword(value);
                            if(result){
                              return null;
                            }
                            else{
                              return "Password should contain Capital, Small letters & Numbers & Special Letter";
                            }
                          }
                        },
                      ),
                      BuildTextFormField(
                        horizontal: spacingH,
                        vertical: spacingV,
                        obscureText: visiblePassword1,

                        controller: confirmPasswordController,
                        screenHeight: screenHeight,
                        labelText: 'Confirm Password',
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: visiblePassword1 ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                          onPressed: (){
                            setState(() {
                              visiblePassword1 = !visiblePassword1;
                            });

                          },
                        ),
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please Enter The Password";
                          }
                          else if(value != passwordController.text){
                            return "Password Not Matched ";
                          }else{
                            return null;
                          }


                        },
                      ),
                    ],
                  ),
                ),
                defaultHeight(screenHeight * 0.01),
                BuildRow(isChecked: isChecked),
                defaultHeight(screenHeight * 0.028),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyElevatedButton(
                    width: screenWidth,
                    height: screenHeight * 0.065,
                    onPressed: () {
                      reduceSpacing();
                      // print(passwordController.text.)

                      if (_formKey.currentState!.validate()) {
                        // _formKey.currentState.validate();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Processing Data'),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: const Text('Register'),
                  ),
                ),
                defaultHeight(screenHeight * 0.02),
                BuildText(
                  context: context,
                  text: 'Login',
                  fontSize: screenHeight * 0.05,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
                // defaultHeight(screenHeight * 0.005),
                Text.rich(
                  TextSpan(
                    text: 'Already have an account?',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: ' Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        style: const TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateEmail(String email) {
    String _email = email.trim();
    if (isValidEmail.hasMatch(_email)) {
      return true;
    } else {
      return false;
    }
  }

  bool validatePassword(String passWord){
    String _passWord = passWord.trim();
    if(pass_valid.hasMatch(_passWord)){
      return true;
    }else{
      return false;
    }
  }

  void reduceSpacing(){
    setState(() {
      spacingH = 5;
      spacingV = 5;

    });
  }

  SizedBox defaultHeight(double screenHeight) => SizedBox(height: screenHeight);
}

class BuildRow extends StatefulWidget {
  BuildRow({
    super.key,
    required this.isChecked,
  });

  bool isChecked;

  @override
  State<BuildRow> createState() => _BuildRowState();
}

class _BuildRowState extends State<BuildRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.16,
          child: Checkbox(
            value: widget.isChecked,
            onChanged: (bool? value) {
              setState(() {
                widget.isChecked = value!;
              });
            },
          ),
        ),
        Text.rich(
          TextSpan(
            text: 'By creating an account, you agree to our',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
            children: const [
              TextSpan(
                text: '\nConditions of use',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: ' and',
              ),
              TextSpan(
                text: ' Privacy Notice',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
