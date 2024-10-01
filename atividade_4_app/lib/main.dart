import 'package:flutter/material.dart';

void main() {
  runApp(BankingApp());
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BankingFormScreen(),
    );
  }
}

// Tela de formulário para adicionar uma nova conta
class BankingFormScreen extends StatefulWidget {
  @override
  _BankingFormScreenState createState() => _BankingFormScreenState();
}

class _BankingFormScreenState extends State<BankingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  List<Map<String, dynamic>> accounts = [];

  @override
  void dispose() {
    // Limpa os controladores quando o widget é destruído
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _accountNameController.clear();
    _accountNumberController.clear();
    _balanceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Conta Bancária'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _accountNameController,
                decoration: InputDecoration(labelText: 'Nome da Conta'),
                validator: (value) {
                  return value!.isEmpty ? 'Informe o nome da conta' : null;
                },
              ),
              TextFormField(
                controller: _accountNumberController,
                decoration: InputDecoration(labelText: 'Número da Conta'),
                validator: (value) {
                  return value!.isEmpty ? 'Informe o número da conta' : null;
                },
              ),
              TextFormField(
                controller: _balanceController,
                decoration: InputDecoration(labelText: 'Saldo'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  return value!.isEmpty ? 'Informe o saldo' : null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Salva os dados do formulário
                    setState(() {
                      accounts.add({
                        'name': _accountNameController.text,
                        'number': _accountNumberController.text,
                        'balance': double.tryParse(_balanceController.text) ?? 0,
                      });
                    });
                    // Reseta o formulário
                    _resetForm();
                    // Navega para a lista de contas
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountListScreen(accounts: accounts),
                      ),
                    );
                  }
                },
                child: Text('Salvar Conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela de listagem de contas
class AccountListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> accounts;

  AccountListScreen({required this.accounts});

  @override
  _AccountListScreenState createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contas'),
      ),
      body: ListView.builder(
        itemCount: widget.accounts.length,
        itemBuilder: (context, index) {
          final account = widget.accounts[index];
          return ListTile(
            title: Text(account['name']),
            subtitle: Text('Número: ${account['number']} - Saldo: \$${account['balance']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.accounts.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Reseta o formulário ao voltar para a tela de adicionar contas
          Navigator.pop(context);
        },
      ),
    );
  }
}
