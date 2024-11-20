import 'package:flutter/material.dart';

class CustomTableRow extends StatefulWidget {
  final Map<String, dynamic> data;

  const CustomTableRow({super.key, required this.data});

  @override
  State<CustomTableRow> createState() => _CustomTableRowState();
}

class _CustomTableRowState extends State<CustomTableRow> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final photo = widget.data['Foto'] as String?;
    final name = widget.data['Nome'] as String?;

    return Card(
      color: Colors.white,
      child: Column(
        children: [
          // Cabeçalho (linha superior)
          ListTile(
            leading: photo != null
                ? CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(photo),
                  )
                : null,
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                name ?? 'Sem nome',
                style: const TextStyle(
                  color: Color(0xFF1C1C1C),
                ),
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Theme.of(context).primaryColor, // Azul para ícone
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          // Detalhes em formato de tabela (expandido)
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(5),
                  1: FlexColumnWidth(5),
                },
                children: widget.data.entries
                    .where((entry) =>
                        entry.key != 'Foto' &&
                        entry.key != 'Nome') // Exclui 'Foto' e 'Nome'
                    .map(
                      (entry) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C1C1C),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              entry.value.toString(),
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
