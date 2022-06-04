import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/data/models/user.dart';

class UserRepository{
  final _firestore=FirebaseFirestore.instance;
  late   user   current_user;
 // UserRepository(this.current_user);
  //function to check if the username is unique or not

  Future<void> createUser()async
  {
    try{

      await _firestore
          .collection("user")
          .doc(this.current_user.userId)
          .set(this.current_user.toDocument());
      await _firestore
          .collection("username")
          .doc(this.current_user.username)
          .set({"user_name":this.current_user.username});

    }
    catch(e){
      throw Exception(e.toString());
    }

  }
Future<void> getUser(String userId)async
{
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await _firestore.collection('user').doc(userId ?? '').get();


  if (documentSnapshot.exists) {

    this.current_user= user.fromSnapshot(documentSnapshot);
  }
  else{
    throw Exception('user-not-found');
  }
}
  Future<List<user>> getUsersByUserName(String userName)async
  {
    try{
    final documentSnapshot =
    await _firestore.collection('user').where('username',isGreaterThanOrEqualTo:userName).get();
       List<user>resultedUsers=documentSnapshot.docs.map((doc)=>user.fromSnapshot(doc)).toList();

return resultedUsers;}
        catch(e)
    {
      throw Exception('no user found');
    }

  }


  Future<String> loadImage(String img_url1)async {

    try{
      final String url= await FirebaseStorage.instance.ref("/profile_images").child(img_url1).getDownloadURL();
      return url;
    }
    catch(e){
      throw Exception(e.toString());
    }

  }




}
