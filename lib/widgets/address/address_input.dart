import 'package:doublevpartners/constants/constant.dart';
import 'package:doublevpartners/modules/user/controller/user_controller.dart';
import 'package:doublevpartners/modules/user/storage/info_id.dart';
import 'package:doublevpartners/ui/message_alert.dart';
import 'package:doublevpartners/widgets/button/primary_button.dart';
import 'package:doublevpartners/widgets/fields/field_input.dart';
import 'package:doublevpartners/widgets/fields/field_select.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AddressInputForm extends StatefulWidget {
  const AddressInputForm({super.key});

  @override
  State<AddressInputForm> createState() => _AddressInputFormState();
}

class _AddressInputFormState extends State<AddressInputForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController streetName = TextEditingController();
  final TextEditingController cityName = TextEditingController();
  final TextEditingController stateName = TextEditingController();
  final TextEditingController zipName = TextEditingController();
  final TextEditingController countryName = TextEditingController();

  final userController = UserController();
  final infoId = InfoId();

  double _opacity = 0.0;
  bool isLoading = false;
  int counter = 0;
  String selectedCountry = "";

  final List<Map<String, String>> addressesInput = [];

  @override
  void initState() {
    super.initState();
    setOpacity();
  }

  void setOpacity() {
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    streetName.dispose();
    cityName.dispose();
    stateName.dispose();
    zipName.dispose();
    countryName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FieldSelect(
              textLabel: countryText,
              hintText: 'Seleccione un país',
              colorLabel: Colors.grey.shade700,
              colorPrefixIcon: Colors.blueAccent,
              colorBorderSide: Colors.blue,
              icon: Ionicons.globe_outline,
              isRequired: true,
              onChanged: (value) {
                countryName.text = value!;
              },
            ),

            FieldInput(
              textLabel: cityText,
              hintText: "",
              colorLabel: colorSecondary,
              colorPrefixIcon: colorPrimary,
              colorBorderSide: colorPrimary,
              icon: Ionicons.location_outline,
              ctrl: cityName,
              textCapitalization: false,
              isRequired: true,
            ),

            FieldInput(
              textLabel: stateProvinceText,
              hintText: "",
              colorLabel: colorSecondary,
              colorPrefixIcon: colorPrimary,
              colorBorderSide: colorPrimary,
              icon: Ionicons.location_outline,
              ctrl: stateName,
              textCapitalization: false,
              isRequired: true,
            ),
            /*
             FieldInput(
              textLabel: countryText,
              hintText: "",
              colorLabel: colorSecondary,
              colorPrefixIcon: colorPrimary,
              colorBorderSide: colorPrimary,
              icon: Ionicons.location_outline,
              ctrl: countryName,
              textCapitalization: true,
              isRequired: true,
            ),
            */
            FieldInput(
              textLabel: streetAddressText,
              hintText: hintextAddress,
              colorLabel: colorSecondary,
              colorPrefixIcon: colorPrimary,
              colorBorderSide: colorPrimary,
              icon: Ionicons.locate_sharp,
              ctrl: streetName,
              textCapitalization: false,
              isRequired: true,
            ),

            FieldInput(
              textLabel: postalCodeText,
              hintText: "",
              isNumeric: true,
              colorLabel: colorSecondary,
              colorPrefixIcon: colorPrimary,
              colorBorderSide: colorPrimary,
              icon: Ionicons.location_outline,
              ctrl: zipName,
              textCapitalization: true,
              isRequired: true,
            ),

            IconButton(
              onPressed: () {
                addressesInput.add({
                  'street': streetName.text,
                  'city': cityName.text,
                  'state': stateName.text,
                  'zip': zipName.text,
                  'country': countryName.text,
                });
                setState(() {
                  counter = addressesInput.length;
                });
              },
              icon: Icon(Ionicons.add_circle_sharp, color: Colors.green),
            ),
            PrimaryButton(
              text: "$textSaveAddress $counter $textAddress",
              isLoading: isLoading,
              onPressed: () async {
                toggleLoading();
                final userId = await infoId.getUserId();
                int? id = int.tryParse(userId.toString());
                if (_formKey.currentState!.validate()) {
                  if (id != null) {
                    await userController.insertMultipleAddresses(
                      userId: id,
                      addresses: addressesInput,
                    );
                  }
                  MessageAlert.messageAlert(textAddressRegistered);
                  toggleLoading();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
