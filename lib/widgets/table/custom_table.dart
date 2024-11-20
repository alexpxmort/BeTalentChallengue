import 'package:be_talent_alex_challengue/widgets/table/table_header.dart';
import 'package:be_talent_alex_challengue/widgets/table/table_row.dart';
import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<String> headers; // Cabeçalhos da tabela
  final List<Map<String, dynamic>> data; // Dados da tabela
  final Widget? trailingIcon; // Ícone opcional à direita

  const CustomTable({
    super.key,
    required this.headers,
    required this.data,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cabeçalho da tabela
          TableHeader(headers: headers, trailingIcon: trailingIcon),
          // Lista com os dados da tabela
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return CustomTableRow(data: data[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
