import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome_task/feature/auth/cubit/auth_cubit.dart';
import 'package:welcome_task/feature/main/main_screen.dart';
import 'package:welcome_task/service/api/repository/donut_repository.dart';

import 'cubit/auth_state.dart';

class SignInPage extends StatefulWidget {
  final Connectivity connectivityMonitor;
  final DonutRepository donutRepository;
  const SignInPage({
    super.key,
    required this.connectivityMonitor,
    required this.donutRepository,
  });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState<String>> emailTextFieldKey =
      GlobalKey<FormFieldState<String>>();
  final emailController = TextEditingController();

  // GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  // GlobalKey<FormFieldState<String>> passwordTextFieldKey =
  //     GlobalKey<FormFieldState<String>>();
  final passwordController = TextEditingController();

  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  late AuthCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is Authenticated) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => MainPage(
                            connectivityMonitor: widget.connectivityMonitor,
                            donutRepository: widget.donutRepository,
                          ))),
                  (route) => route.isFirst);
            }
            if (state is UnAuthenticated) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.3,
                            child: Image.asset(
                              "assets/img/splash.png",
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: emailFormKey,
                            child: TextFormField(
                              key: emailTextFieldKey,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              // style: AppTextStyles.base,
                              // cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                // labelStyle: const TextStyle(color: Colors.black54),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                // fillColor: Colors.grey.shade800,
                                filled: true,
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) =>
                                  email != null && !EmailValidator.validate(email)
                                      ? 'emailErrorTextField'.tr()
                                      : null,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              obscureText: _isHidden,
                              keyboardType: TextInputType.emailAddress,
                              controller: passwordController,
                              // cursorColor: Colors.black87,
                              decoration: InputDecoration(
                                suffix: InkWell(
                                  onTap: () => _togglePasswordView(),
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                labelText: 'password'.tr(),
                                // labelStyle: const TextStyle(color: Colors.black54),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                // fillColor: Colors.grey.shade800,
                                filled: true,
                                hintText: 'password'.tr(),
                                hintStyle: TextStyle(color: Colors.grey[500]),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (emailFormKey.currentState!.validate()) {
                                  _cubit.signInRequst(emailController.text,
                                      passwordController.text);
                                }
                              },
                              icon: const Icon(Icons.login),
                              label: Text('signIn'.tr()),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              onPressed: () => _cubit.googleSignInRequest(),
                              icon: Image.asset('assets/img/google_logo.png'),
                              label: Text('signInWithGoogle'.tr()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
