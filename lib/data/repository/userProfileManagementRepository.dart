import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/data/models/user.dart';
import 'package:quiver/collection.dart';

import '../models/comment.dart';
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

        posts[i].set_post_img_downloaded_url(loadPostImage(post_url[0],post_url[1]));
        posts[i].set_post_id(postsId[i]);
      }
      catch(e)
      {
        throw Exception('no user found');
      }

    }

    return posts;


  }
  Future<String> loadProfileImage(String img_url1)async {

    try{
      final String url= await FirebaseStorage.instance.ref("/profile_images").child(img_url1).getDownloadURL();
      return url;
    }
    catch(e){
      throw Exception(e.toString());
    }

  }
  Future<Multimap<user, String>> getPostComments(List<String> comments_id)
  async {
    var UserComment = Multimap<user, String>();
   // final  Map<user, List<String>>UserComment ={};
    var comment_Snapshot;
    var user_Snapshot;
    var resultedComment;
    for(int i=0;i< comments_id.length;i++)
    {
      try {
        comment_Snapshot =
            await _firestore.collection('comments').doc(comments_id[i]).get();
       comment resultedComment= comment.fromSnapshot(comment_Snapshot);

          user_Snapshot =
          await _firestore.collection('user').doc(resultedComment.userId).get();
          user resultedUser=await user.fromSnapshot(user_Snapshot);
       // resultedUser.profile_img_downloaded_url=loadProfileImage( resultedUser.profile_img_url!);
resultedUser.set_profile_img_downloaded_url(loadProfileImage( resultedUser.profile_img_url!));
        UserComment.add(resultedUser,resultedComment.commentText);
         // comments.add(resultedComment.commentText);
          //users.add(resultedUser);

      }
      catch(e)
      {
        throw Exception('no user found');
      }}
    return UserComment;
  }
  Future<String> loadPostImage(String folderName,String img_url1)async {

    try{
      final String url= await FirebaseStorage.instance.ref("/${folderName}").child(img_url1).getDownloadURL();
      return url;
    }
    catch(e){
      throw Exception(e.toString());
    }

  }






}
