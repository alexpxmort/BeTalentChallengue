import 'dart:convert';

import 'package:be_talent_alex_challengue/utils/str.dart';
import 'package:be_talent_alex_challengue/widgets/search_input.dart';
import 'package:be_talent_alex_challengue/widgets/table/custom_table.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final http.Client client;

  const HomeScreen({super.key, required this.client});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> filteredData = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData(); // Busca os dados da API ao iniciar
  }

  Future<void> fetchData() async {
    const apiUrl = 'https://desafio-mobile-lex.vercel.app/employees';

    try {
      final response = await widget.client.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final jsonData = jsonResponse.map((item) {
          return {
            'Nome': item['name'],
            'Cargo': item['job'],
            'Data de admissão': formatDate(item['admission_date']),
            'Telefone': item['phone'],
            'Foto': item['image']
          };
        }).toList();
        setState(() {
          _data = jsonData;
          filteredData = jsonData;
          _isLoading = false;
        });
      } else {
        throw Exception(
            'Falha ao carregar dados. Código: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao buscar dados: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredData = _data;
      });
      return;
    }

    String sanitizedQuery = query.toLowerCase().trim();
    final resultFiltered = _data.where((item) {
      return normalizeString(item['Nome']!.toLowerCase())
              .contains(sanitizedQuery) ||
          normalizeString(item['Cargo']!.toLowerCase())
              .contains(sanitizedQuery) ||
          normalizeString(item['Telefone']!.toLowerCase())
              .contains(sanitizedQuery);
    }).toList();
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      filteredData = resultFiltered;
    });
  }

  String formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF5F5F5),
              child: const Text(
                'CG',
                style: TextStyle(color: Color(0xFF1C1C1C)),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF1C1C1C),
                    size: 30,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, // Azul (#0500FF)
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '02',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Funcionários',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: SearchInput(
                onSearch: _performSearch,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: CustomTable(
                      headers: const ['Foto', 'Nome'],
                      trailingIcon: Icon(Icons.circle, size: 10),
                      data: filteredData,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
