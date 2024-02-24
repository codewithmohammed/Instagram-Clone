import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instragram_clone/screens/add_post_screen.dart';
import 'package:instragram_clone/screens/feed_screens.dart';
import 'package:instragram_clone/screens/profile_screen.dart';
import 'package:instragram_clone/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
