import 'package:flutter/material.dart';
import 'package:uas_c14220050/database/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(recipe.description),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.w600)),
                ...recipe.ingredients.split('\n').map((item) => Text('$item'))
              ],
            )
          ],
        ),
      ),
    );
  }
}