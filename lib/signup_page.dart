import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demu_chat/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email.text,
      });

      Get.offAll(const Wrapper());

    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = "The email address is already in use.";
          break;
        case 'invalid-email':
          message = "The email address is not valid.";
          break;
        case 'operation-not-allowed':
          message = "Operation not allowed. Please contact support.";
          break;
        case 'weak-password':
          message = "The password is too weak.";
          break;
        default:
          message = "An unexpected error occurred. Please try again.";
      }
      Get.snackbar("Error", message, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "An unknown error occurred. Please try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Enter email",
              ),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                hintText: "Enter password",
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: signup,
                child: const Text("Sign up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
