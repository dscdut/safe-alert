import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/utils/toast_util.dart';
import 'package:flutter_template/data/dtos/auth/register_response_dto.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/auth/bloc/register/register_bloc.dart';
import 'package:flutter_template/presentation/auth/bloc/register/register_state.dart';
import 'package:flutter_template/presentation/auth/widgets/register/register_form.dart';
import 'package:flutter_template/presentation/widgets/common_rounded_button.dart';
import '../../../di/di.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterBloc(userRepository: getIt.get<UserRepository>()),
      child: RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void onPressSignUp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(RegisterSubmit(
              registerDTO: RegisterDTO(
            fullName: fullNameController.text,
            phoneNumber: phoneNumberController.text,
            email: emailController.text,
            password: passwordController.text,
            confirmPassword: confirmPasswordController.text,
          ),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        color: ColorStyles.primaryColor,
        child: Column(
          children: [
            Flexible(
              child: Center(
                  child: Image.asset('assets/icons/register/app_icon.png'),),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorStyles.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 46),
                  child: Column(
                    children: [
                      const SizedBox(height: 24,),
                      Text(
                        LocaleKeys.auth_sign_up.tr(),
                        style: TextStyles.s17BoldText.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 16.0,),
                      SizedBox(
                        height: 480,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RegisterForm(
                                formKey: formKey,
                                fullNameController: fullNameController,
                                phoneNumberController: phoneNumberController,
                                emailController: emailController,
                                passwordController: passwordController,
                                confirmPasswordController:
                                    confirmPasswordController,
                              ),
                              const SizedBox(height: 32,),
                              BlocConsumer<RegisterBloc, RegisterState>(
                                  listener: (context, state) {
                                    if (state.isSuccess!) {
                                      ToastUtil.showSuccess(context,
                                          text: LocaleKeys
                                              .auth_thank_you_for_registering.tr(),);
                                    } else {
                                      if (state.error != null) {
                                        ToastUtil.showError(context, text: state.error);
                                      }
                                    }
                                  },
                                  buildWhen: (previous, current) =>
                                      previous.isLoading != current.isLoading,
                                  builder: (context, state) {
                                    return CommonRoundedButton(
                                      onPressed: () => onPressSignUp(context),
                                      content: LocaleKeys.auth_sign_in.tr(),
                                      isLoading: state.isLoading!,
                                    );
                                  },),
                              const SizedBox(height: 12.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(LocaleKeys.texts_you_have_an_account.tr(),),
                                  const SizedBox(width: 8.0,),
                                  InkWell(
                                    child: Text(LocaleKeys.auth_sign_in.tr(),
                                        style: const TextStyle(
                                            color: ColorStyles.hightLightText,),),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
