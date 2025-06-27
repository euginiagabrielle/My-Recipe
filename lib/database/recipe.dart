class Recipe {
  int? id;
  String uid;
  String name;
  String description;
  String ingredients;

  Recipe({
    this.id, 
    required this.uid,
    required this.name, 
    required this.description, 
    required this.ingredients
  });
  
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      uid: map['uid'] as String, 
      name: map['name'] as String, 
      description: map['description'] as String, 
      ingredients: map['ingredients'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'ingredients': ingredients,
    };
  }
}