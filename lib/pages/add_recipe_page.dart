import 'package:flutter/material.dart';
import 'package:uas_c14220050/auth/auth_service.dart';
import 'package:uas_c14220050/database/recipe.dart';
import 'package:uas_c14220050/database/recipes_database.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final authService = AuthService();
  final recipeDatabase = RecipesDatabase();
  
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();

  void addNewRecipe() async {
    final uid = authService.getCurrentUserId().toString();
    final name = _nameController.text;
    final description = _descriptionController.text;
    final ingredients = _ingredientsController.text;

    if (name.isEmpty || description.isEmpty || ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    final newRecipe = Recipe(uid: uid, name: name, description: description, ingredients: ingredients);

    try {
      await recipeDatabase.createRecipe(newRecipe);
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint("Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save recipe")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
        appBar: AppBar(
          backgroundColor: Colors.amber[100],
          title: Text("Add new recipe"),
          titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          centerTitle: true,
        ),

        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Recipe's name",
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                )
              ),
              cursorColor: Colors.black,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                )
              ),
              cursorColor: Colors.black,
            ),
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(
                labelText: "Ingredients",
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                )
              ),
              cursorColor: Colors.black,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(onPressed: () { 
                    Navigator.pop(context);
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[50],
                    foregroundColor: Colors.grey[600]
                  ),
                  child: Text("Cancel")),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: addNewRecipe, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[300],
                      foregroundColor: Colors.black
                    ),
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}