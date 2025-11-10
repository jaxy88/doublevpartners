import 'dart:convert';
import 'package:doublevpartners/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FieldSelect extends StatefulWidget {
  final String textLabel;
  final String hintText;
  final Color colorLabel;
  final Color colorPrefixIcon;
  final Color colorBorderSide;
  final IconData icon;
  final bool isRequired;
  final Function(String?)? onChanged;

  const FieldSelect({
    super.key,
    required this.textLabel,
    required this.hintText,
    required this.colorLabel,
    required this.colorPrefixIcon,
    required this.colorBorderSide,
    required this.icon,
    this.isRequired = false,
    this.onChanged,
  });

  @override
  State<FieldSelect> createState() => _FieldSelectState();
}

class _FieldSelectState extends State<FieldSelect> {
  List<String> _countries = [];
  String? _selectedCountry;
  String? _errorText;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      setState(() => _isLoading = true);
      final response = await http.get(Uri.parse(baseUrlCountry));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          _countries =
              data
                  .map((country) => country['name']['common'] as String)
                  .toList()
                ..sort();
        });
      } else {
        throw Exception('Error al obtener países');
      }
    } catch (e) {
      debugPrint('Error obteniendo países: $e');
      setState(() => _errorText = 'No se pudieron cargar los países');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _openSearch(BuildContext context) async {
    final result = await showSearch<String?>(
      context: context,
      delegate: CountrySearchDelegate(_countries),
    );

    if (result != null) {
      setState(() {
        _selectedCountry = result;
        _errorText = null;
      });
      if (widget.onChanged != null) widget.onChanged!(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _countries.isNotEmpty ? () => _openSearch(context) : null,
      child: AbsorbPointer(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: widget.textLabel,
              hintText: widget.hintText,
              labelStyle: TextStyle(color: widget.colorLabel, fontSize: 15),
              prefixIcon: Icon(widget.icon, color: widget.colorPrefixIcon),
              suffixIcon: const Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.colorBorderSide,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorText: _errorText,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
            ),
            controller: TextEditingController(text: _selectedCountry ?? ''),
          ),
        ),
      ),
    );
  }
}

class CountrySearchDelegate extends SearchDelegate<String?> {
  final List<String> countries;

  CountrySearchDelegate(this.countries);

  @override
  String? get searchFieldLabel => textSearchCountry;

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
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = countries
        .where((c) => c.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildResultList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = countries
        .where((c) => c.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildResultList(context, suggestions);
  }

  Widget _buildResultList(BuildContext context, List<String> results) {
    if (results.isEmpty) {
      return const Center(child: Text(textNotFoundCountry));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final country = results[index];
        return ListTile(
          leading: const Icon(Icons.flag, color: Colors.blueAccent),
          title: Text(country),
          onTap: () => close(context, country),
        );
      },
    );
  }
}
