import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/data/models/user.dart';

class AuthRepository{
  final _firebaseAuth = FirebaseAuth.instance;
final _firestore=FirebaseFirestore.instance;
  late   user   current_user;
  Future<void> signUp({required String email, required String password,required String username}) async {
    if(checkUserNameexistence(username)==false) {
    checkUserNameexistence(username);
    try {


        UserCredential result = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        user? new_user=user(userId:result.user?.uid,username:username);

        createUser(new_user);
        this.current_user=new_user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }}
    else{
      throw Exception(username );
    }
  }
  //function to check if the username is unique or not
 Future<bool> checkUserNameexistence(String username)async
  {

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await _firestore.collection('username').doc(username ?? '').get();
      if(documentSnapshot.exists)
      {

        return true;

      }

      return false;

  }
  Future<void> createUser(user new_user)async
  {
    try{

    await _firestore
        .collection("user")
        .doc(new_user.userId)
        .set(new_user.toDocument());
    await _firestore
        .collection("username")
        .doc(new_user.username)
        .set({"user_name":new_user.username});

    }
        catch(e){
          throw Exception(e.toString());
        }

  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await _firestore.collection('user').doc(result.user?.uid ?? '').get();


      if (documentSnapshot.exists) {

        this.current_user= user.fromSnapshot(documentSnapshot);
      }


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }


}
