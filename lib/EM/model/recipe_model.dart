class RecipeModel {
  String? responseCode;
  String? msg;
  List<Recipes>? recipe;
  String? status;

  RecipeModel({this.responseCode, this.msg, this.recipe, this.status});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    msg = json['message'];
    if (json['blogs'] != null) {
      recipe = <Recipes>[];
      json['blogs'].forEach((v) {
        recipe?.add(Recipes.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = msg;
    if (recipe != null) {
      data['blogs'] = recipe?.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Recipes {
  String? recipe_id;
  String? ing;
  String? method;
  String? image;
  String? date;
  String? title;

  Recipes({
    this.recipe_id,
    this.ing,
    this.method,
    this.image,
    this.date,
    this.title,
  });

  Recipes.fromJson(Map<String, dynamic> json) {
    recipe_id = json['blog_id'];
    ing = json['a_ing'];
    method = json['a_method'];
    image = json['image'];
    date = json['date'];
    title = json['a_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipe_id'] = recipe_id;
    data['a_ing'] = ing;
    data['a_method'] = method;
    data['image'] = image;
    data['date'] = date;
    data['a_title'] = title;
    return data;
  }
}
