import 'package:com.ezeelogix.truenorth/Models/coach_model.dart';
import 'package:com.ezeelogix.truenorth/Screens/add_coach.dart';
import 'package:com.ezeelogix.truenorth/Screens/coach_detail.dart';
import 'package:com.ezeelogix.truenorth/Screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          // IconButton(
          //   onPressed: () {
          //     coachesCollection.get().then((value) => value.docs);
          //   },
          //   icon: const Icon(Icons.refresh),
          // ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const AddCoach()))
                  .then((value) {
                // Handle what to do after adding a coach
              });
            },
            icon: const Icon(Icons.add_box, size: 35),
          ),
          const SizedBox(width: 30,)
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        FirebaseAuth.instance.signOut();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SplashScreen(),));
      } , child: const Icon(Icons.logout_rounded),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('coaches').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<CoachModel> coaches = snapshot.data!.docs.map((doc) {
            return CoachModel.fromSnapshot(doc);
          }).toList();
          return ListView.builder(
            itemCount: coaches.length,
            itemBuilder: (context, index) {
              final coach = coaches[index];
              return ListTile(
                title: Text(coach.name),
                subtitle: Text(coach.email),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CoachDetailScreen(coach: coach)));
                },
                // Add more fields here as needed
              );
            },
          );
        },
      ),

      
    );
  }
}
