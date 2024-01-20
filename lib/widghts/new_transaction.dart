import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  final Function addTransaction;

  NewTransaction(this.addTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: _titleController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: _amountController,
          ),
          TextButton(
            onPressed: () {
              addTransaction(
                  _titleController.text, double.parse(_amountController.text));
            },
            child: const Text(
              'Add Transaction',
              style: TextStyle(color: Colors.purple),
            ),
          )
        ],
      ),
    );
  }
}
