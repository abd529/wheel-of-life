import 'package:com.ezeelogix.truenorth/Models/coach_mode.dart';
import 'package:com.ezeelogix.truenorth/Screens/add_coach.dart';
import 'package:com.ezeelogix.truenorth/Screens/coach_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoachesScreen extends StatelessWidget {
  final CollectionReference coachesCollection =
      FirebaseFirestore.instance.collection("coaches");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coaches List'),
        actions: [
          IconButton(
            onPressed: () {
              coachesCollection.get().then((value) => value.docs);
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const AddCoach()))
                  .then((value) {
                // Handle what to do after adding a coach
              });
            },
            icon: const Icon(Icons.add_box, size: 35),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: coachesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Coaches"));
          } else {
            List<CoachModel> coachList = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              // Retrieve the "codes" field as a Map<String, bool>
              Map<String, bool> codes = Map<String, bool>.from(data["codes"]);

              return CoachModel(
                name: data["name"],
                email: data["email"],
                codes: codes,
                package: data["package"],
              );
            }).toList();
            return ListView.builder(
              itemCount: coachList.length,
              itemBuilder: (context, index) {
                CoachModel coach = coachList[index];
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CoachDetailScreen(coach: coach),
                        ));
                      },
                      title: Text(coach.name),
                      subtitle: Text(coach.email),
                      trailing: Text( coach.package == "50 Code Package"? "50 Codes":"100 Codes"),
                    ),
                    const Divider()
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
