import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  static signUp(
     String email, password, firstName, lastName) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user?.uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'uid': credential.user!.uid,
          'firstName': firstName,
          'lastName': lastName,
          'email': email
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text('The password provided is too weak.')));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text('The account already exists for that email.')));
        print('The account already exists for that email.');
      }
    } catch (e) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
    }
  }

  static signIn(String email, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
