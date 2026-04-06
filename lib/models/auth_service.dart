import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Registro de usuario
  Future<User?> registerWithEmailAndPassword(UserModel userModel) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      User? user = result.user;

      if (user != null) {
        userModel.uid = user.uid; // Asignar el UID generado por Firebase
        // Guardar datos adicionales en Firestore
        await _firestore
            .collection('usuarios')
            .doc(user.uid)
            .set(userModel.toMap());
      }

      return user;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }
}
