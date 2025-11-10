import 'package:flutter/material.dart';

class DepartmentSearchDelegate extends SearchDelegate<String?> {
  final List<String> items;
  DepartmentSearchDelegate(this.items);

  @override
  String? get searchFieldLabel => 'Buscar departamento';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (Navigator.canPop(context)) {
          close(context, null);
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final results = items
        .where((d) => d.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return results.isEmpty
        ? Center(child: Text('No se encontraron departamentos'))
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(results[i]),
              onTap: () {
                if (Navigator.canPop(context)) {
                  close(context, results[i]);
                } else {
                  Navigator.of(context).pop(results[i]);
                }
              },
            ),
          );
  }
}
