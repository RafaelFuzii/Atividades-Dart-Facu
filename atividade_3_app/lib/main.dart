import 'package:flutter/material.dart';

void main() {
  runApp(BancoApp());
}

class BancoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final List<String> _transacoes = [];
  final TextEditingController _controller = TextEditingController();

  void _adicionarTransacao() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _transacoes.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicação Bancária'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nova Transação',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _adicionarTransacao(),
            ),
          ),
          ElevatedButton(
            onPressed: _adicionarTransacao,
            child: Text('Adicionar Transação'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _transacoes.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    title: Text(_transacoes[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
