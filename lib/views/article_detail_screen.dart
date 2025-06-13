import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wabah Monster Krabby Patty!")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Image(image: AssetImage('assets/images/logo.png')),
            SizedBox(height: 16),
            Text(
              'Wabah Monster Krabby Patty!\nDes 1, 1950',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Lorem ipsum dolor amet, consectetur adipiscing elit. '
              'Lorem ipsum dolor amet, consectetur adipiscing elit. '
              'Lorem ipsum dolor amet, consectetur adipiscing elit.',
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
