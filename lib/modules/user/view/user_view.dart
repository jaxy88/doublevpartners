import 'package:doublevpartners/constants/constant.dart';
import 'package:doublevpartners/modules/user/controller/user_controller.dart';
import 'package:doublevpartners/modules/user/storage/info_id.dart';
import 'package:doublevpartners/ui/message_alert.dart';
import 'package:doublevpartners/widgets/address/address_input.dart';
import 'package:doublevpartners/widgets/button/primary_button.dart';
import 'package:doublevpartners/widgets/fields/field_birth_date.dart';
import 'package:doublevpartners/widgets/logo/app_logo.dart';
import 'package:doublevpartners/widgets/fields/field_input.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  bool isLoading = false;
  bool isAddress = false;
  var userIdPersist = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController ctrlName = TextEditingController();
  final TextEditingController ctrlLastName = TextEditingController();
  final TextEditingController ctrlBirthdate = TextEditingController();

  final userController = UserController();
  final infoId = InfoId();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  AppLogo(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FieldInput(
                          textLabel: nameText,
                          hintText: "",
                          colorLabel: colorSecondary,
                          colorPrefixIcon: colorPrimary,
                          colorBorderSide: colorPrimary,
                          icon: Ionicons.person_outline,
                          ctrl: ctrlName,
                          textCapitalization: true,
                          isRequired: true,
                        ),
                        FieldInput(
                          textLabel: lastNameText,
                          hintText: "",
                          colorLabel: colorSecondary,
                          colorPrefixIcon: colorPrimary,
                          colorBorderSide: colorPrimary,
                          icon: Ionicons.person_outline,
                          ctrl: ctrlLastName,
                          textCapitalization: true,
                          isRequired: true,
                        ),

                        FieldInputBirthdate(
                          textLabel: birthdateText,
                          colorLabel: colorSecondary,
                          colorPrefixIcon: colorPrimary,
                          colorBorderSide: colorPrimary,
                          icon: Ionicons.time_outline,
                          ctrl: ctrlBirthdate,
                          isRequired: true,
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          isAddress = !isAddress;
                        });
                      },
                      icon: const Icon(
                        Icons.add_location_alt_outlined,
                        color: colorPrimary,
                      ),
                      label: const Text(
                        addAddressText,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorPrimary,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        foregroundColor: colorPrimary,
                      ),
                    ),
                  ),

                  isAddress == true
                      ? Column(children: [AddressInputForm()])
                      : PrimaryButton(
                          text: textSave,
                          //icon: Ionicons.save_outline,
                          isLoading: isLoading,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              toggleLoading();
                              await Future.delayed(Duration(seconds: 2));
                              final userId = await userController.insertUser(
                                name: ctrlName.text,
                                lastName: ctrlLastName.text,
                                birthdate: ctrlBirthdate.text,
                              );
                              infoId.saveUserI(userId.toString());
                              MessageAlert.messageAlert(textUserRegistered);
                              toggleLoading();
                            } else {
                              toggleLoading(false);
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void toggleLoading([bool? value]) {
    setState(() {
      if (value != null) {
        isLoading = value;
      } else {
        isLoading = !isLoading;
      }
    });
  }
}
