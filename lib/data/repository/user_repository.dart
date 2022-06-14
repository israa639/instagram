import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/data/models/user.dart';

import '../models/post.dart';

class UserRepository{
  final _firestore=FirebaseFirestore.instance;
 // late   user   current_user;

Future<List<post>>  getUserPosts(List<String> postsId)  async {
  List<post> posts=[];
  var documentSnapshot;
  for(int i=0;i<postsId.length;i++)
  {
    try {
      documentSnapshot =
      await _firestore.collection('posts').doc(postsId[i]).get();
      posts.add(post.fromSnapshot(documentSnapshot));
    }
    catch(e)
    {
      throw Exception('no user found');
    }

  }

  return posts;


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
