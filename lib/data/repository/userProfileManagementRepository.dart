import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/data/models/user.dart';

import '../models/post.dart';

class UserProfileManagemetRepository{
  final _firestore=FirebaseFirestore.instance;
  // late   user   current_user;
Future<void> setUserProfile(user currentUser)
async {
  await this.getUserPosts(currentUser.posts_id!).then((List<post> posts) => currentUser.set_posts(posts) );

}





  Future<List<post>>  getUserPosts(List<String> postsId)  async {
    List<post> posts=[];
    var documentSnapshot;
    for(int i=0;i<postsId.length;i++)
    {
      try {
        documentSnapshot =
        await _firestore.collection('posts').doc(postsId[i]).get();
        posts.add(post.fromSnapshot(documentSnapshot));
        var post_url = posts[i].post_img_url.split('/');

        posts[i].set_post_img_downloaded_url(loadImage(post_url[0],post_url[1]));
      }
      catch(e)
      {
        throw Exception('no user found');
      }

    }

    return posts;


  }
  Future<String> loadImage(String folderName,String img_url1)async {

    try{
      final String url= await FirebaseStorage.instance.ref("/${folderName}").child(img_url1).getDownloadURL();
      return url;
    }
    catch(e){
      throw Exception(e.toString());
    }

  }






}
