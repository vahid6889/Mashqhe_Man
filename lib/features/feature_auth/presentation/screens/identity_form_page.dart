// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:mashgh/core/params/user_profile_params.dart';
import 'package:mashgh/core/presentation/ui/main_wrapper.dart';
import 'package:mashgh/core/presentation/widgets/toastification_mood.dart';
import 'package:mashgh/core/utils/color_manager.dart';
import 'package:mashgh/core/utils/storage_operator.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/auth_bloc.dart';
import 'package:mashgh/features/feature_auth/presentation/bloc/authentication/update_user_profile_status.dart';
import 'package:mashgh/features/feature_auth/presentation/cubits/input_chip_cubit.dart';
import 'package:mashgh/features/feature_auth/presentation/widgets/app_bar_custom.dart';
import 'package:mashgh/locator.dart';
import 'package:sizer/sizer.dart';

StorageOperator storageOperator = locator();

class IdentityFormPage extends StatelessWidget {
  static const routeName = "/identity_form_page";
  const IdentityFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    final userNameFocusNode = FocusNode();
    final firstNameFocusNode = FocusNode();
    final lastNameFocusNode = FocusNode();
    final ageFocusNode = FocusNode();
    final formKey = GlobalKey<FormState>();
    String? _riseUpAuthUserToken;
    String? _phoneNumber;
    Map<String, dynamic>? _args;

    /// get argument from navigator pages
    _args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _phoneNumber = _args?['phone_number'];
    _riseUpAuthUserToken = _args?['rise_up_auth_user_token'];

    final Map<String, int> inputChipRolesList = {
      'دانش آموز': 0,
      'معلم': 1,
      'والدین': 2,
    };
    int? selectedChip;
    bool _validateFields = false;
    RegExp _englishAlphabetWithSpace = RegExp(r'^[A-Za-z0-9_]+$');

    return Scaffold(
      appBar: const AppBarCustom(),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Gap(10),
                      TextFormField(
                        controller: userNameController,
                        onEditingComplete: () =>
                            firstNameFocusNode.requestFocus(),
                        focusNode: userNameFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'نام کاربری',
                          prefixIcon: Icon(Icons.person_2_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            _validateFields = true;
                            ToastificationMood.showToast(
                              context: context,
                              typeToast: 'error',
                              titleToast: 'خطا !',
                              descriptionToast:
                                  'لطفا نام کاربری خود را وارد کنید',
                            );
                          } else if (!_englishAlphabetWithSpace
                              .hasMatch(value)) {
                            return 'فقط از حروف انگلیسی و فاصله استفاده کنید';
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      TextFormField(
                        controller: firstNameController,
                        onEditingComplete: () =>
                            lastNameFocusNode.requestFocus(),
                        focusNode: firstNameFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'نام',
                          prefixIcon: Icon(Icons.person_2_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            _validateFields = true;
                            ToastificationMood.showToast(
                              context: context,
                              typeToast: 'error',
                              titleToast: 'خطا !',
                              descriptionToast: 'لطفا نام خود را وارد کنید',
                            );
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      TextFormField(
                        controller: lastNameController,
                        onEditingComplete: () => ageFocusNode.requestFocus(),
                        focusNode: lastNameFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'نام خانوادگی',
                          prefixIcon: Icon(Icons.person_2_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            _validateFields = true;
                            ToastificationMood.showToast(
                              context: context,
                              typeToast: 'error',
                              titleToast: 'خطا !',
                              descriptionToast:
                                  'لطفا نام خانوادگی خود را وارد کنید',
                            );
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      TextFormField(
                        maxLength: 2,
                        controller: ageController,
                        focusNode: ageFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'سن',
                          prefixIcon: Icon(
                            Icons.emoji_people,
                          ),
                          counterText: "",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            _validateFields = true;
                            ToastificationMood.showToast(
                              context: context,
                              typeToast: 'error',
                              titleToast: 'خطا !',
                              descriptionToast: 'لطفا سن خود را وارد کنید',
                            );
                          }
                          return null;
                        },
                      ),
                      const Gap(40),
                      BlocBuilder<InputChipCubit, int>(
                        builder: (context, chipState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Wrap(
                                children: List.generate(
                                  inputChipRolesList.length,
                                  (index) {
                                    return InputChip(
                                      isEnabled: inputChipRolesList.keys
                                                  .toList()[index] ==
                                              'والدین'
                                          ? false
                                          : true,
                                      selected: chipState == index,
                                      selectedColor: ColorManager.darkWhite5,
                                      disabledColor: ColorManager.darkWhite1,
                                      label: SizedBox(
                                        width: 60.sp,
                                        child: Center(
                                          child: Text(
                                            inputChipRolesList.keys
                                                .toList()[index],
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      backgroundColor: ColorManager.darkWhite1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
                                      onSelected: (value) {
                                        selectedChip = index;
                                        BlocProvider.of<InputChipCubit>(context)
                                            .inputChipSwitch(index);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const Gap(50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BlocConsumer<AuthBloc, AuthState>(
                            listenWhen: (previous, current) {
                              if (previous.updateUserProfileStatus ==
                                  current.updateUserProfileStatus) {
                                return false;
                              }
                              return true;
                            },
                            listener: (context, state) {
                              if (state.updateUserProfileStatus
                                  is UpdateUserProfileError) {
                                final UpdateUserProfileError
                                    updateUserProfileError =
                                    state.updateUserProfileStatus
                                        as UpdateUserProfileError;

                                ToastificationMood.showToast(
                                  context: context,
                                  typeToast: 'error',
                                  titleToast: 'خطا !',
                                  descriptionToast: updateUserProfileError
                                      .message
                                      .replaceAll("<br/>", ""),
                                );
                              }
                            },
                            buildWhen: (previous, current) {
                              if (previous.updateUserProfileStatus ==
                                  current.updateUserProfileStatus) {
                                return false;
                              }
                              return true;
                            },
                            builder: (context, state) {
                              if (state.updateUserProfileStatus
                                  is UpdateUserProfileLoading) {
                                return SizedBox(
                                  width: 30.w,
                                  child: const LinearProgressIndicator(),
                                );
                              }
                              if (state.updateUserProfileStatus
                                  is UpdateUserProfileCompleted) {
                                storageOperator.push(
                                    'roleUser', selectedChip.toString());
                                storageOperator.push(
                                    'riseUpAuthentication', 'true');
                                storageOperator.push('riseUpAuthUserToken',
                                    _riseUpAuthUserToken);
                                storageOperator.push(
                                    'phoneNumber', _phoneNumber);

                                WidgetsBinding.instance.addPostFrameCallback(
                                  (timeStamp) =>
                                      Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    MainWrapper.routeName,
                                    ModalRoute.withName(
                                      MainWrapper.routeName,
                                    ),
                                  ),
                                );
                              }

                              return OutlinedButton(
                                onPressed: () {
                                  /// check choose roles with user
                                  bool isAnyChipSelected = inputChipRolesList
                                      .containsValue(selectedChip);

                                  if (userNameController.text.isNotEmpty ||
                                      firstNameController.text.isNotEmpty ||
                                      lastNameController.text.isNotEmpty ||
                                      ageController.text.isNotEmpty) {
                                    _validateFields = false;
                                  }

                                  if (isAnyChipSelected) {
                                    if (formKey.currentState!.validate() &&
                                        _validateFields == false) {
                                      /// create params for api call
                                      final UserProfileParams
                                          userProfileParams = UserProfileParams(
                                        mobile: _phoneNumber,
                                        name: firstNameController.text,
                                        family: lastNameController.text,
                                        age: int.tryParse(ageController.text),
                                        userName: userNameController.text,
                                        role: selectedChip,
                                      );
                                      BlocProvider.of<AuthBloc>(context).add(
                                        UpdateUserProfileEvent(
                                          userProfileParams,
                                          _riseUpAuthUserToken,
                                        ),
                                      );
                                    }
                                  } else {
                                    ToastificationMood.showToast(
                                      context: context,
                                      typeToast: 'error',
                                      titleToast: 'خطا !',
                                      descriptionToast:
                                          'لطفا یک نقش را انتخاب کنید',
                                    );
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      ColorManager.seeBlue.withOpacity(0.3),
                                  side: BorderSide(
                                    width: 2.0,
                                    color: Colors.blue.withOpacity(0.7),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'ارسال',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    SizedBox.square(dimension: 25.sp),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.blue,
                                      size: 15.sp,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 3.5.h),
                            child: Lottie.asset(
                              'assets/lottie/Identity_pencil.json',
                              width: 30.w,
                            ),
                          ),
                        ],
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
}
