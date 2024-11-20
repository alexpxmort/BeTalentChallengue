import 'package:be_talent_alex_challengue/utils/str.dart';
import 'package:test/test.dart';

void main() {
  group('normalizeString', () {
    test('Removes accents correctly', () {
      expect(normalizeString('áàãâäå'), 'aaaaaa');
      expect(normalizeString('éèêë'), 'eeee');
      expect(normalizeString('íìîï'), 'iiii');
      expect(normalizeString('óòõôö'), 'ooooo');
      expect(normalizeString('úùûü'), 'uuuu');
      expect(normalizeString('ç'), 'c');
    });

    test('Removes special characters', () {
      expect(normalizeString('hello@world!'), 'helloworld');
      expect(normalizeString('123#\$%^&*()'), '123');
      expect(normalizeString('clean_this_string'), 'cleanthisstring');
    });

    test('Trims leading and trailing spaces', () {
      expect(normalizeString('   leading spaces'), 'leading spaces');
      expect(normalizeString('trailing spaces   '), 'trailing spaces');
      expect(normalizeString('   both   '), 'both');
    });

    test('Handles empty strings', () {
      expect(normalizeString(''), '');
    });

    test('Handles only spaces', () {
      expect(normalizeString('   '), '');
    });
  });
}
