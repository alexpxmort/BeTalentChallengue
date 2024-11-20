import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Future<void> Function(String) onSearch;

  const SearchInput({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSearch() async {
    final query = _controller.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onSearch(query); // Executa a função passada
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 50), // Adapta-se ao pai
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Color(0xFF1C1C1C),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Pesquisar',
                hintStyle: Theme.of(context).textTheme.headlineSmall,
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _handleSearch(), // Pesquisa ao enviar o texto
            ),
          ),
          if (_isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
