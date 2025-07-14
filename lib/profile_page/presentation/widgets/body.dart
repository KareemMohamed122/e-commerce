import 'package:flutter/material.dart';
import 'package:untitled2/profile_page/presentation/widgets/option_list_tile.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account Overview",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            OptionListTile(icon: Icons.person, title: "My Profile"),
            SizedBox(height: 16),
            OptionListTile(icon: Icons.shopping_bag, title: "My Orders"),

            SizedBox(height: 16),
            OptionListTile(icon: Icons.attach_money, title: "Refund"),

            SizedBox(height: 16),
            OptionListTile(icon: Icons.lock, title: "Change Password"),

            SizedBox(height: 16),
            OptionListTile(icon: Icons.language, title: "Change Language"),

            SizedBox(height: 16),
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 16),
            OptionListTile(icon: Icons.logout, title: "Logout"),
          ],
        ),
      ),
    );
  }
}
