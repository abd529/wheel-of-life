import 'package:cloud_firestore/cloud_firestore.dart';

class CoachModel {
  final String id;
  final String name;
  final String email;
  final Map code;
  final String package;
  final int limit;

  CoachModel({
    required this.id,
    required this.name,
    required this.email,
    required this.code,
    required this.package,
    required this.limit,
  });

  factory CoachModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CoachModel(
      id: snapshot.id, 
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      code: data['codeData']?? '',
      limit: data['codeData']["limit"],
      package: data['package'] ?? '',
    );
  }
}