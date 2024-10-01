import 'package:flutter_test/flutter_test.dart';
import 'account.dart';

void main() {
  group('Account Tests', () {
    test('Deposit should increase balance', () {
      final account = Account<String>('Conta Corrente', 100.0);
      account.deposit(50.0);
      expect(account.getBalance(), 150.0);
    });

    test('Withdraw should decrease balance', () {
      final account = Account<String>('Conta Poupança', 200.0);
      account.withdraw(100.0);
      expect(account.getBalance(), 100.0);
    });

    test('Withdraw should throw exception on insufficient funds', () {
      final account = Account<String>('Cartão de Crédito', 50.0);
      expect(() => account.withdraw(100.0), throwsException);
    });
  });
}
