import 'package:clinica_vida_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // ignore: prefer_const_constructors
  final Uuid _uuid = Uuid();

  Future<bool> registerUser({
    required String email,
    required String nombre,
    required String apellido,
    required String password,
    required DateTime fechaNacimiento,
    required String sexo,
    required String telefono,
    required String dui,
    required String direccion,
    required String departamento,
    required String tipoUsuario,
  }) async {
    try {
      // Verificar si ya existe un usuario con el mismo correo y contraseña
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // ignore: avoid_print
        print('Ya existe un usuario con este correo y contraseña');
        return false;
      }

      // Generar un UID único para el usuario
      String uid = _uuid.v4();

      // Crear una instancia de UserModel
      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        nombre: nombre,
        apellido: apellido,
        password: password,
        fechaNacimiento: fechaNacimiento,
        sexo: sexo,
        telefono: telefono,
        dui: dui,
        direccion: direccion,
        departamento: departamento,
        tipoUsuario: tipoUsuario,
      );

      // Convertir el objeto UserModel a un mapa
      Map<String, dynamic> userMap = newUser.toMap();

      // Guardar el usuario en Firestore
      await _firestore.collection('users').doc(uid).set(userMap);


      return true;
    } catch (e) {
      return false;
    }
  }

  //inicio de sesion

  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Verificar si existe un usuario con el correo y la contraseña proporcionados
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromMap(userData);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //Obtener todos los usuarios
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<UserModel> users = querySnapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return users;
    } catch (e) {
      return [];
    }
  }
  
 //obtener usuario por id
  Future<UserModel?> getUserById(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  ///Actualizar información de un usuario
  Future<bool> updateUser({
    required String uid,
    required Map<String, dynamic> updatedData,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update(updatedData);
      return true;
    } catch (e) {
      return false;
    }
  }

//Eliminar un usuario
  Future<bool> deleteUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
