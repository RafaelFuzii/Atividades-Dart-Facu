class Account<T extends num> {
  String accountName;
  T balance;

  Account(this.accountName, this.balance);

  void deposit(T amount) {
    balance += amount;
  }

  void withdraw(T amount) {
    if (balance >= amount) {
      balance -= amount;
    } else {
      throw Exception('Saldo insuficiente');
    }
  }

  T getBalance() {
    return balance;
  }
}
