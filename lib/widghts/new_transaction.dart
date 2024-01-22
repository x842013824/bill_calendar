import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  final ValueChanged<({String title, double amount})> onSubmit;

  NewTransaction(this.onSubmit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: _titleController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
          ),
          TextButton(
            onPressed: () {
              final title = _titleController.text;
              final amount = double.parse(_amountController.text);
              if (title.isNotEmpty && amount > 0) {
                onSubmit((title: title, amount: amount));
              }
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
