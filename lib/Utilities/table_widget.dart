import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<String> topics;
  final List<String> questions;
  final List<String> answers;

  CustomTable({required this.topics, required this.questions, required this.answers});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 16.0, // Adjust this value as per your preference
      columns: [
        DataColumn(
          label: Text(
            'Subject',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Question',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Answer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: List<DataRow>.generate(
        topics.length,
        (index) => DataRow(
          cells: [
            DataCell(Text(topics[index])),
            DataCell(Text(questions[index])),
            DataCell(Text(answers[index])),
          ],
        ),
      ),
    );
  }
}
