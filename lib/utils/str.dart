String normalizeString(String input) {
  String normalized = input
      .replaceAll(RegExp(r'[áàãâäå]'), 'a')
      .replaceAll(RegExp(r'[éèêë]'), 'e')
      .replaceAll(RegExp(r'[íìîï]'), 'i')
      .replaceAll(RegExp(r'[óòõôö]'), 'o')
      .replaceAll(RegExp(r'[úùûü]'), 'u')
      .replaceAll(RegExp(r'[ç]'), 'c')
      .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '')
      .trim();

  return normalized;
}
