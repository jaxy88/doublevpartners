import 'package:doublevpartners/modules/user/controller/user_controller.dart';
import 'package:doublevpartners/ui/message_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserGetxController extends GetxController {
  final UserController _userController;

  UserGetxController({UserController? userController})
    : _userController = userController ?? UserController();

  var users = <Map<String, dynamic>>[].obs;
  final Rxn<Map<String, dynamic>> selectedUser = Rxn<Map<String, dynamic>>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadUsers([BuildContext? context]) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _userController.getAllUsers();
      users.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Error cargando usuarios: $e';
      if (context != null) {
        MessageAlert.messageAlert(errorMessage.value);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
