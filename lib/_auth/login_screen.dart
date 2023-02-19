import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beekeeper/main.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../myPacks/myVoids.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure0 = true;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<String>? savedEmails = sharedPrefs!.getStringList('savedEmails') ?? [] ;

  onSuggestionSelected(suggestion) async {
    emailController.text = suggestion.toString();
    print('## selected_email: ${suggestion}');
    setState(() {});
  }

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pwdFocus = FocusNode();
  @override
  void initState() {

    super.initState();
    _emailFocus.addListener(_onFocusChange);
    _pwdFocus.addListener(_onFocusChange);

  }

  @override
  void dispose() {
    super.dispose();
    _emailFocus.removeListener(_onFocusChange);
    _pwdFocus.removeListener(_onFocusChange);
    _emailFocus.dispose();
    _pwdFocus.dispose();
  }

  void _onFocusChange() {
    setState((){});
  }



  @override
  Widget build(BuildContext context) {

    return Material(
      color: Color(0xFF75b0b5),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                 SizedBox(
                  height: 3.h,
                ),
                /// logo Image
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 170,
                ),
                SizedBox(
                  height: 3.h,
                ),
                /// animated_text
                SizedBox(
                  height: 40,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('لتحسين نظامنا البيئي',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.w500,
                          ),
                          speed: const Duration(
                            milliseconds: 200,
                          )),
                    ],
                    onTap: () {
                      debugPrint("Welcome back!");
                    },
                    isRepeatingAnimation: true,
                    totalRepeatCount: 40,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),



                 Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          /// email input with suggetions
                          TypeAheadFormField(
                            noItemsFoundBuilder: (_) {
                              return Container(height: 0,);
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                            validator: (value) {
                              RegExp regex = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
                              if (value!.isEmpty) {
                                return "email can\'t be empty".tr;
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter a valid email".tr);
                              } else {
                                return null;
                              }
                            },
                            //animationDuration: const Duration(milliseconds: 1500),
                            textFieldConfiguration: TextFieldConfiguration(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                fieldFocusChange(context,_emailFocus,_pwdFocus);
                              },
                              focusNode: _emailFocus,

                              //autocorrect: true,
                              //cursorColor: Colors.white54,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),

                              controller: emailController,
                              //autofocus: true,
                              decoration: InputDecoration(

                                //filled: true,
                                border: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: yellowCol,
                                        width: 0.5,
                                        style: BorderStyle.solid
                                    )
                                ),
                                // focusedBorder: InputBorder.none,
                                // enabledBorder: InputBorder.none,
                                // errorBorder: InputBorder.none,
                                // disabledBorder: UnderlineInputBorder(
                                //     borderSide: new BorderSide(
                                //         color: yellowCol,
                                //         width: 0.5,
                                //         style: BorderStyle.solid
                                //     )
                                // ),
                                fillColor: hintYellowColHex,
                                hintStyle: const TextStyle(
                                    fontSize: 13
                                ),
                                labelStyle: const TextStyle(
                                    fontSize: 16
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,

                                labelText: 'Email'.tr,
                                hintText: 'Enter your email'.tr,
                                icon: Icon(Icons.email , color: _emailFocus.hasFocus? yellowCol:disabledIconCol),

                                contentPadding: const EdgeInsets.only(bottom: 7),
                              ),
                            ),
                            suggestionsCallback: (pattern) {
                              return savedEmails!.where((String email) => email.toLowerCase().contains(pattern.toLowerCase())).toList();
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.toString()),
                              );
                            },
                            transitionBuilder: (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (suggestion) {
                              /// when click sugg
                              onSuggestionSelected(suggestion);
                            },
                            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                              color: blueColHex2,
                              elevation: 10,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                            ),
                          ),

                          SizedBox(
                            height: 25,
                          ),

                          /// password input
                          Column(
                            children: [
                              TextFormField(
                                focusNode: _pwdFocus,
                                textInputAction: TextInputAction.done,

                                controller: passwordController,
                                obscureText: _isObscure0,


                                onEditingComplete: () {
                               fieldUnfocusAll();

                                },
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontSize: 16
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(!_isObscure0 ? Icons.visibility : Icons.visibility_off,
                                      color: _pwdFocus.hasFocus?yellowCol:disabledIconCol,),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure0 = !_isObscure0;
                                        });
                                      }),

                                  contentPadding: const EdgeInsets.only(bottom: 7),
                                  hintStyle:const TextStyle(
                                      fontSize: 13
                                  ),
                                  /// simple deco
                                  icon: Icon(Icons.lock , color: _pwdFocus.hasFocus?yellowCol:disabledIconCol),
                                  hintText: 'Enter your password'.tr,
                                  labelText: 'Password'.tr,
                                ),
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return "password can\'t be empty".tr;
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ('Enter a valid password of at least 6 characters'.tr);
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  passwordController.text = value!;
                                },
                                keyboardType: TextInputType.text,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      goForgotPwd();
                                    },
                                    child:  Text(
                                      'Forgot Password?'.tr,
                                      style: GoogleFonts.almarai(
                                        textStyle: TextStyle(fontSize: 15.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),

                          /// google_signIn & signIn btn
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: (() {
                                  if (_formkey.currentState!.validate()) {
                                    authCtr.signIn(emailController.text, passwordController.text);
                                    authCtr.saveEnteredEmail(emailController.text);

                                  }
                                }),
                                //icon: const Icon(Icons.login),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 65,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1b3a4b),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Icon(
                                    Icons.login,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              TextButton(
                                onPressed: (() {
                                  authCtr.signInWithGoogle();
                                }),
                                //icon: const Icon(Icons.login),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 65,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1b3a4b),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child:  Icon(
                                    Ionicons.logo_google,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          SizedBox(
                            height: 2,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text('you have no account?'.tr),
                              TextButton(
                                onPressed: (() {
                                  goSignUp();
                                }),
                                child:  Text(
                                  'Sign Up'.tr,
                                  style:const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


