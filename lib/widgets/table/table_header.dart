import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  final List<String> headers; // Lista de cabeçalhos
  final Widget? trailingIcon; // Ícone opcional à direita

  const TableHeader({
    Key? key,
    required this.headers,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ocupa 100% do tamanho do pai
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEFFB), // Fundo cinza claro
        borderRadius: BorderRadius.circular(8), // Bordas arredondadas
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  ...headers
                      .map(
                        (header) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(header.toUpperCase(),
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        ),
                      )
                      .toList(),
                  const SizedBox(
                    width: 140,
                  ),
                  if (trailingIcon != null) trailingIcon!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
