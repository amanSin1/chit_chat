import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demu_chat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }


  // send messages
 Future<void> sendMessage(String receiverID, message) async{
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail  = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();


   // create a new message
   Message newMessage = Message(
       senderID: currentUserID,
       senderEmail: currentUserEmail,
     receiverID: receiverID,
       message: message,
       timestamp: timestamp,
   );

   // construct chat room ID for two users
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');


   // add new messages to data base
   await _firestore
    .collection("chat rooms")
    .doc(chatRoomID)
    .collection("messages")
    .add(newMessage.toMap());




 }
  // get messages
  Stream<QuerySnapshot> getMessages(String userID,otherUserID){
    // construct a chat room for two users
    List<String> ids = [userID,otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");
    return _firestore
        .collection("chat rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
