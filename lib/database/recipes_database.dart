import 'package:uas_c14220050/database/recipe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipesDatabase {
  final database = Supabase.instance.client.from('recipes');

  Future createRecipe(Recipe newRecipe) async {
    await database.insert(newRecipe.toMap());
  }

  Stream<List<Recipe>> getRecipesByUid(String uid) {
    return Supabase.instance.client
      .from('recipes')
      .stream(primaryKey: ['id'])
      .eq('uid', uid)
      .map((data) => data.map((recipeMap) => Recipe.fromMap(recipeMap)).toList());
  }
}