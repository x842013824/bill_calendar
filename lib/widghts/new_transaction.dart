import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final ValueChanged<({String title, double amount})> onSubmit;

  const NewTransaction(this.onSubmit, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void _submit() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);
    if (title.isNotEmpty && amount > 0) {
      widget.onSubmit((title: title, amount: amount));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 320),
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submit(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submit(),
            ),
            TextButton(
              onPressed: _submit,
              child: const Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
