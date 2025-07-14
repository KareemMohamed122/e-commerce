import 'package:flutter/material.dart';
import 'package:untitled2/commonUI/label_widget.dart';

import '../widgets/body.dart';
import '../widgets/header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade400,
      body: Stack(
        children: [
          Header(),
          Positioned(top: 240, left: 0, right: 0, bottom: 0, child: Body()),
        ],
      ),
    );
  }
}
