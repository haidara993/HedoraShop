import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedorashop/helpers/color_constant.dart';
import 'package:hedorashop/helpers/text_constants.dart';
import 'package:hedorashop/pages/auth/sign_in/sign_in.dart';
import 'package:hedorashop/pages/widgets/signin_button.dart';
import 'package:hedorashop/pages/widgets/signin_text_field.dart';
import 'package:hedorashop/viewmodels/auth_viewmodel.dart';

class SignUpPage extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: ColorConstants.white,
            child: Stack(
              children: [
                _createMainData(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createMainData(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _createTitle(),
            // const SizedBox(height: 50),
            _createForm(context),
            const SizedBox(height: 40),
            _createSignUpButton(context),
            // Spacer(),
            const SizedBox(height: 40),
            _createHaveAccountText(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _createTitle() {
    return Text(
      TextConstants.signUp,
      style: TextStyle(
        color: ColorConstants.textBlack,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SigninTextField(
            title: TextConstants.username,
            controller: controller.userNameController,
            placeholder: TextConstants.userNamePlaceholder,
            textInputAction: TextInputAction.next,
            errorText: TextConstants.usernameErrorText,
            onTextChanged: () {
              controller.name = controller.userNameController.text;
            },
          ),
          const SizedBox(height: 20),
          SigninTextField(
            title: TextConstants.email,
            controller: controller.emailController,
            placeholder: TextConstants.emailPlaceholder,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            errorText: TextConstants.emailErrorText,
            onTextChanged: () {
              controller.email = controller.emailController.text;
            },
          ),
          const SizedBox(height: 20),
          SigninTextField(
            title: TextConstants.password,
            placeholder: TextConstants.passwordPlaceholder,
            obscureText: true,
            // isError: state is ShowErrorState ? !ValidationService.password(bloc.passwordController.text) : false,
            textInputAction: TextInputAction.next,
            controller: controller.passwordController,
            errorText: TextConstants.passwordErrorText,
            onTextChanged: () {
              controller.password = controller.passwordController.text;
            },
          ),
          const SizedBox(height: 20),
          SigninTextField(
            title: TextConstants.phone,
            controller: controller.phoneController,
            placeholder: TextConstants.phonePlaceholder,
            textInputAction: TextInputAction.next,
            errorText: TextConstants.phoneErrorText,
            onTextChanged: () {
              controller.phone = controller.phoneController.text;
            },
          ),
          Row(
            children: [
              Expanded(
                child: SigninTextField(
                  title: TextConstants.country,
                  controller: controller.countryController,
                  placeholder: TextConstants.countryPlaceholder,
                  textInputAction: TextInputAction.next,
                  errorText: TextConstants.countryErrorText,
                  onTextChanged: () {
                    controller.country = controller.countryController.text;
                  },
                ),
              ),
              Expanded(
                child: SigninTextField(
                  title: TextConstants.city,
                  controller: controller.cityController,
                  placeholder: TextConstants.cityPlaceholder,
                  textInputAction: TextInputAction.next,
                  errorText: TextConstants.cityErrorText,
                  onTextChanged: () {
                    controller.city = controller.cityController.text;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SigninTextField(
                  title: TextConstants.street,
                  controller: controller.streetController,
                  placeholder: TextConstants.streetPlaceholder,
                  textInputAction: TextInputAction.next,
                  errorText: TextConstants.streetErrorText,
                  onTextChanged: () {
                    controller.street = controller.streetController.text;
                  },
                ),
              ),
              Expanded(
                child: SigninTextField(
                  title: TextConstants.zip,
                  controller: controller.zipController,
                  placeholder: TextConstants.zipPlaceholder,
                  textInputAction: TextInputAction.next,
                  errorText: TextConstants.zipErrorText,
                  onTextChanged: () {
                    controller.zip = controller.zipController.text;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SigninButton(
        title: TextConstants.signUp,
        onTap: () {
          FocusScope.of(context).unfocus();

          _formKey.currentState?.save();
          if (_formKey.currentState!.validate()) {
            print('object');
            controller.createaccountwithemailandpassword();
          }
        },
      ),
    );
  }

  Widget _createHaveAccountText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: TextConstants.alreadyHaveAccount,
        style: TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 18,
        ),
        children: [
          TextSpan(
            text: " ${TextConstants.signIn}",
            style: TextStyle(
              color: ColorConstants.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.to(() => SignInPage());
              },
          ),
        ],
      ),
    );
  }
}
