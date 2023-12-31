import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/components.dart';

class NotificationModel
{
  String? id;
  late String type;
  UserModel? user;

  NotificationModel({
    required this.type,
    required this.user,
});

  NotificationModel.fromJson(Map<String, dynamic> notification, UserModel user)
  {
    this.id = notification['id'];
    this.type = notification['type'];
    this.user = user;
  }

  Map<String, dynamic> toMap()
  {
    DocumentReference userRef = FirebaseFirestore.instance.collection('users')
    .doc(user?.id);

    return {
      'type' : this.type,
      'user' : userRef,
    };
  }

}