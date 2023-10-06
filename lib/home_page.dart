import 'package:flutter/material.dart';
import 'package:uts/side_menu.dart';
import 'package:uts/tambah_data.dart'; // Import file TambahData

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: const SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Selamat datang'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TambahData(),
                  ),
                );
              },
              child: const Text('Mulai buat task baru'),
            ),
          ],
        ),
      ),
    );
  }
}
