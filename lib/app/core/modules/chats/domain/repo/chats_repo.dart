import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/app/core/modules/chats/domain/models/user_model.dart';

class ChatsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> fetchRegisteredUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<UserModel> userList = querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return userList;
    } catch (e) {
      throw e.toString();
    }
  }
}
