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
            hintText: TextConstants.userNamePlaceholder,
            onSavedFn: (newValue) {
              controller.name = newValue;
            },
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4)
                return TextConstants.usernameErrorText;
            },
          ),
          const SizedBox(height: 20),
          SigninTextField(
            title: TextConstants.email,
            controller: controller.emailController,
            hintText: TextConstants.emailPlaceholder,
            keyboardType: TextInputType.emailAddress,
            onSavedFn: (newValue) {
              controller.email = newValue;
            },
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4)
                return TextConstants.emailErrorText;
            },
          ),
          const SizedBox(height: 20),
          SigninTextField(
            title: TextConstants.password,
            hintText: TextConstants.passwordPlaceholder,
            obscureText: true,
            controller: controller.passwordController,
            onSavedFn: (newValue) {
              controller.password = newValue;
            },
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4)
                return TextConstants.passwordErrorText;
            },
          ),
          const SizedBox(height: 20),
          SigninTextField(
            title: TextConstants.phone,
            controller: controller.phoneController,
            hintText: TextConstants.phonePlaceholder,
            onSavedFn: (newValue) {
              controller.phone = newValue;
            },
            validatorFn: (value) {
              if (value!.isEmpty || value.length < 4)
                return TextConstants.phoneErrorText;
            },
          ),
          Row(
            children: [
              Expanded(
                child: SigninTextField(
                  title: TextConstants.country,
                  controller: controller.countryController,
                  hintText: TextConstants.countryPlaceholder,
                  onSavedFn: (newValue) {
                    controller.country = newValue;
                  },
                  validatorFn: (value) {
                    if (value!.isEmpty || value.length < 4)
                      return TextConstants.countryErrorText;
                  },
                ),
              ),
              Expanded(
                child: SigninTextField(
                  title: TextConstants.city,
                  controller: controller.cityController,
                  hintText: TextConstants.cityPlaceholder,
                  onSavedFn: (newValue) {
                    controller.city = newValue;
                  },
                  validatorFn: (value) {
                    if (value!.isEmpty || value.length < 4)
                      return TextConstants.cityErrorText;
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
                  hintText: TextConstants.streetPlaceholder,
                  onSavedFn: (newValue) {
                    controller.street = newValue;
                  },
                  validatorFn: (value) {
                    if (value!.isEmpty || value.length < 4)
                      return TextConstants.streetErrorText;
                  },
                ),
              ),
              Expanded(
                child: SigninTextField(
                  title: TextConstants.zip,
                  controller: controller.zipController,
                  hintText: TextConstants.zipPlaceholder,
                  onSavedFn: (newValue) {
                    controller.zip = newValue;
                  },
                  validatorFn: (value) {
                    if (value!.isEmpty || value.length < 4)
                      return TextConstants.zipErrorText;
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
