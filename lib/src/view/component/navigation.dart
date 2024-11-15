import 'package:flutter/material.dart';
import 'package:petrolops/src/view/page/login.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(child: Text('PetrolOps')),
        ListTile(
          title: const Text('Inicio'),
          leading: const Icon(Icons.home_filled),
          onTap: () => Navigator.pushReplacementNamed(context, LoginPage.route),
        ),
      ],
    );
  }
}
