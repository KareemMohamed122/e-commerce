import 'package:flutter/material.dart';

class OptionListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const OptionListTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange.shade50,
        child: Icon(icon, color: Colors.deepOrange),
      ),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
