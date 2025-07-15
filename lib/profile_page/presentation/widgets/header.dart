import 'package:flutter/material.dart';

import '../../../commonUI/label_widget.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          width: double.infinity,
          color: Colors.deepOrange.shade400,
          child: Stack(
            children: [
              const Positioned(
                top: 20,
                left: 20,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Positioned(
                top: 70,
                right: 150,
                child: Column(
                  children: [
                    profilePicture(),
                    const SizedBox(height: 8),
                    LabelWidget(
                      label: 'Kareem',
                      labelColor: Colors.white,
                      widget: const Text(
                        "+201061744918",
                        style: TextStyle(color: Colors.white),
                      ),
                      labelFontSize: 10,
                      labelFontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Stack profilePicture() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 36, color: Colors.black),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.deepOrange,
            child: const Icon(Icons.edit, size: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
