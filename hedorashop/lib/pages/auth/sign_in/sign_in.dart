import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedorashop/helpers/color_constant.dart';
import 'package:hedorashop/helpers/text_constants.dart';
import 'package:hedorashop/pages/auth/sign_up/sign_up_page.dart';
import 'package:hedorashop/pages/widgets/signin_text_field.dart';
import 'package:hedorashop/pages/widgets/signin_button.dart';
import 'package:hedorashop/viewmodels/auth_viewmodel.dart';

class SignInPage extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            _createMainData(context),
          ],
        ),
      ),
    );
  }

  Widget _createMainData(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: height - 30 - MediaQuery.of(context).padding.bottom,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20),
              _createHeader(),
              // const SizedBox(height: 50),
              _createForm(context),
              const SizedBox(height: 20),
              _createForgotPasswordButton(context),
              const SizedBox(height: 40),
              _createSignInButton(context),
              Spacer(),
              _createDoNotHaveAccountText(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createHeader() {
    return Center(
      child: Text(
        "Sign In",
        style: TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SigninTextField(
            title: TextConstants.email,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            placeholder: TextConstants.emailPlaceholder,
            controller: controller.emailController,
            errorText: TextConstants.emailErrorText,
            onTextChanged: () {
              controller.email = controller.emailController.text;
            },
          ),
          const SizedBox(height: 20),
          SigninTextField(
            title: TextConstants.password,
            placeholder: TextConstants.passwordPlaceholderSignIn,
            controller: controller.passwordController,
            errorText: TextConstants.passwordErrorText,
            obscureText: true,
            onTextChanged: () {
              controller.password = controller.passwordController.text;
            },
          ),
        ],
      ),
    );
  }

  Widget _createForgotPasswordButton(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 21),
        child: Text(
          TextConstants.forgotPassword,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstants.primaryColor,
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget _createSignInButton(BuildContext context) {
    return SigninButton(
      title: TextConstants.signIn,
      // isEnabled: state is SignInButtonEnableChangedState
      //     ? state.isEnabled
      //     : false,
      onTap: () {
        FocusScope.of(context).unfocus();
        // bloc.add(SignInTappedEvent());
        controller.login();
      },
    );
  }

  Widget _createDoNotHaveAccountText(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: TextConstants.doNotHaveAnAccount,
          style: TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: " ${TextConstants.signUp}",
              style: TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(() => SignUpPage());
                },
            ),
          ],
        ),
      ),
    );
  }
}
