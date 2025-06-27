import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uas_c14220050/auth/auth_service.dart';
import 'package:uas_c14220050/database/recipes_database.dart';
import 'package:uas_c14220050/pages/recipe_card.dart';
import 'package:uas_c14220050/pages/add_recipe_page.dart';

class ListRecipePage extends StatefulWidget {
  const ListRecipePage({super.key});

  @override
  State<ListRecipePage> createState() => _ListRecipePageState();
}

class _ListRecipePageState extends State<ListRecipePage> {
  final authService = AuthService();
  final recipeDatabase = RecipesDatabase();

  void logout() async {
    await authService.signOut();
  }

  @override
  void initState() {
    super .initState();
  }

  @override
  Widget build(BuildContext context) {
    final uid = Supabase.instance.client.auth.currentUser?.id;
    debugPrint("CURRENT UID: $uid");
    
    return Scaffold(
      backgroundColor: Colors.amber[100],
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text("My Recipes"),
          titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          centerTitle: true,
          actions: [
            IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
          ],
        ),
        
        body: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(onPressed: () async {
                final result = await Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => AddRecipePage()),
                );
                if (result == true && mounted){
                  setState(() {});
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Recipe saved!")));
                }
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[300],
                foregroundColor: Colors.black,
              ),
              child: Text("Add new recipe"),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: recipeDatabase.getRecipesByUid(uid!), 
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  final recipes = snapshot.data!;
                  if (recipes.isEmpty) {
                    return const Center(
                      child: Text("No recipes found")
                    );
                  }
                  return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return RecipeCard(recipe: recipe);
                    }
                  );
                }
              )
            ),
          ],
        ),
        
    );
  }
}