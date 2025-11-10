import 'package:doublevpartners/constants/constant.dart';
import 'package:doublevpartners/modules/user/controller/user_controller.dart';
import 'package:doublevpartners/modules/user/controller/user_getx_controller.dart';
import 'package:doublevpartners/modules/user/view/address_list_view.dart';
import 'package:doublevpartners/widgets/address/address_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../storage/info_id.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final controller = Get.find<UserGetxController>();
  final userController = UserController();
  final infoId = InfoId();

  @override
  void initState() {
    super.initState();
    controller.loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(textManagamentUser),
        backgroundColor: colorPrimary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (controller.users.isEmpty) {
          return const Center(
            child: Text(notFoundUserText, style: TextStyle(fontSize: 16)),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadUsers,
          child: ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              final isSelected =
                  controller.selectedUser.value?['id'] == user['id'];

              return Column(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorPrimary,
                        child: Text(
                          user['name']?.substring(0, 1).toUpperCase() ?? '?',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        '${user['name'] ?? ''} ${user['lastName'] ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '$birthdateText: ${user['birthdate'] ?? ''}',
                      ),
                      trailing: const Icon(Icons.pin_drop, color: colorPrimary),
                      onTap: () async {
                        showAddressesModal(context, userController, user['id']);
                      },
                    ),
                  ),

                  IconButton(
                    onPressed: () => {
                      setState(() {
                        if (controller.selectedUser.value?['id'] ==
                            user['id']) {
                          controller.selectedUser.value = null;
                        } else {
                          infoId.saveUserI(user['id'].toString());
                          controller.selectedUser.value = user;
                        }
                      }),
                    },
                    icon: Icon(
                      Ionicons.add_circle_sharp,
                      color: isSelected ? Colors.red : Colors.green,
                    ),
                  ),

                  if (isSelected &&
                      (user['birthdate'] != null &&
                          user['birthdate'].toString().isNotEmpty))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: AddressInputForm(),
                    ),
                  //user['birthdate'] !=  ?  AddressInputForm() : Text(""),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  void showAddressesModal(
    BuildContext context,
    dynamic userController,
    var userId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // permite que ocupe casi toda la pantalla
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7, // ocupa el 70% de la pantalla
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (_, scrollController) {
            return Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Direcciones del usuario",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: AddressListView(
                    userId: userId,
                    userController: userController,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
