import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final ValueChanged<({String title, double amount, DateTime date})> onSubmit;

  const NewTransaction(this.onSubmit, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submit() {
    if (_amountController.text.isEmpty) return;

    final title = _titleController.text;
    final amount = double.parse(_amountController.text);
    if (title.isNotEmpty && amount > 0 && _selectedDate != null) {
      widget.onSubmit((title: title, amount: amount, date: _selectedDate!));
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
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'not selected date'
                      : DateFormat().add_yMd().format(_selectedDate!)),
                ),
                TextButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year),
                      lastDate: DateTime.now(),
                    );
                    if (date == null) return;
                    setState(() => _selectedDate = date);
                  },
                  child: const Text('choose date'),
                )
              ],
            ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
