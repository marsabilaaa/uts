import 'package:flutter/material.dart';
import 'package:uts/side_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: const SideMenu(),
      body: Center(child: const Text('Selamat datang')),
    );
  }
}
