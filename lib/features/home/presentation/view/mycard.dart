import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onFavoritePressed;

  const MyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (imageUrl.isNotEmpty)
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ListTile(
            title: Text(title),
            subtitle: Row(
              children: [
                Text(subtitle),
                IconButton(
                  onPressed: onFavoritePressed,
                  icon: const Icon(Icons.favorite_border),
                ),
              ],
            ),
          ),
          //   favoriteButton(),
        ],
      ),
    );
  }
}
