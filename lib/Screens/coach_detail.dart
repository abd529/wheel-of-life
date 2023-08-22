import 'package:com.ezeelogix.truenorth/Models/coach_mode.dart';
import 'package:flutter/material.dart';

class CoachDetailScreen extends StatelessWidget {
  final CoachModel coach;

  CoachDetailScreen({super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coach Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Name: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  coach.name,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  coach.email,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Package: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  coach.package,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Codes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: coach.codes.length,
              itemBuilder: (context, index) {
                String code = coach.codes.keys.elementAt(index);
                bool value = coach.codes[code] ?? false;
                return ListTile(
                  title: Text('Code: $code'),
                  subtitle: Text('Value: ${value ? 'Not Used' : 'Used'}', style: TextStyle(color: value ? Colors.green: Colors.red ),),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
