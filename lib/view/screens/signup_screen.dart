import 'package:chat_server_mechine_test/utils/constants.dart';
import 'package:chat_server_mechine_test/controller/bloc/auth_bloc/authentication_bloc.dart';
import 'package:chat_server_mechine_test/controller/bloc/auth_bloc/authentication_event.dart';
import 'package:chat_server_mechine_test/controller/bloc/auth_bloc/authentication_state.dart';
import 'package:chat_server_mechine_test/view/screens/home.dart';
import 'package:chat_server_mechine_test/view/screens/login_screen.dart';
import 'package:chat_server_mechine_test/view/widgets/mainbutton.dart';
import 'package:chat_server_mechine_test/view/widgets/maintextfield.dart';
import 'package:chat_server_mechine_test/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signupwrapper extends StatelessWidget {
  const Signupwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: SignupScreen(),
    );
  }
}

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: constants.fillcolor,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "No user Found with this email or password did not match "),
                ),
              );
            }
            if (state is Networkauthenticatederor) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("No  intrnet connection !!!"),
                ),
              );
            } else if (state is AuthLoading) {
              const CircularProgressIndicator();
            } else if (state is Authenticated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) =>  signinwrapper()),
                    (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You are Logged in"),
                  ),
                );
              });
            }
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width * 0.28,
              height: MediaQuery.of(context).size.height * 0.68,
              decoration: BoxDecoration(
                  color: constants.backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: MainTextfield(
                            controller: emailcontroller,
                            preicon: Icons.email_outlined,
                            hinttext: "Please enter your email",
                            namefield: "Email",
                            keyboard: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a valid email";
                              } else if (!constants.regemail.hasMatch(value)) {
                                return "Please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        MainTextfield(
                          controller: passwordcontroller,
                          preicon: Icons.lock,
                          hinttext: "Please enter your password",
                          namefield: "Password",
                          keyboard: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a password";
                            } else if (!constants.password.hasMatch(value)) {
                              return 'Password should contain at least one upper case, one lower case, one digit, one special character and  must be 8 characters in length';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: MainTextfield(
                            controller: fullnamecontroller,
                            preicon: Icons.person_3_outlined,
                            hinttext: "Please enter your full name",
                            namefield: "Full name",
                            keyboard: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter name";
                              } else if (!constants.name.hasMatch(value)) {
                                return "Enter a valid name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: MainTextfield(
                            controller: usernamecontroller,
                            preicon: Icons.person_search_sharp,
                            hinttext: "Please enter your User name",
                            namefield: "User name",
                            keyboard: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter name";
                              } else if (!constants.name.hasMatch(value)) {
                                return "Enter a valid name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MainButton(
                            buttontext: "Sign in",
                            onpressed: () {
                              if (formKey.currentState!.validate()) {
                                final users = Usermodel(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                    username: usernamecontroller.text);
                                BlocProvider.of<AuthBloc>(context)
                                    .add(SignUpEvent(user: users));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
