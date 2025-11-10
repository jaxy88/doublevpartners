import 'package:flutter/material.dart';
import 'package:doublevpartners/constants/constant.dart'; // si usas tus colores personalizados
import 'package:ionicons/ionicons.dart';

class AddressListView extends StatefulWidget {
  final int userId;
  final dynamic userController;

  const AddressListView({
    super.key,
    required this.userId,
    required this.userController,
  });

  @override
  State<AddressListView> createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> {
  List<Map<String, dynamic>> _addresses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserAddresses(widget.userId);
  }

  Future<void> loadUserAddresses(int userId) async {
    try {
      final addresses = await widget.userController.getAddressesByUserId(
        userId,
      );
      setState(() {
        _addresses = addresses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_addresses.isEmpty) {
      return const Center(child: Text(notFoundAddressText));
    }

    return ListView.builder(
      itemCount: _addresses.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final address = _addresses[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Ionicons.location_outline, color: colorPrimary),
            title: Text(
              "${address['street']}, ${address['city']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${address['state']}, ${address['country']} - ${address['zip']}",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
