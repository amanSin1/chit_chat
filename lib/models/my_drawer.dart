import 'package:demu_chat/pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  signOut()async{
    await FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("H O M E"),
              leading: Icon(Icons.home),
              onTap: (){
                Navigator.pop(context);
              },
    ),
          ),

    Padding(
    padding: const EdgeInsets.only(left: 25.0),
    child: ListTile(
    title: const Text("S E T T I N G S"),
    leading: const Icon(Icons.settings),
    onTap: (){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
    },
    ),
    ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout_rounded),
              onTap:  (() => signOut()),
            ),
          ),

        ],
      ),
    );
  }
}
