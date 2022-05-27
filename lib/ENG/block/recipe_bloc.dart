import 'package:love/ENG/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../model/recipe_response_model.dart';

class RecipeBloc {
  final recipe = PublishSubject<RecipeResponseModel>();

  Stream<RecipeResponseModel> get recipeStream => recipe.stream;

  Future recipeSink() async {
    RecipeResponseModel nearbyModal = await Repository().recipeRepository();
    recipe.sink.add(nearbyModal);
  }

  dispose() {
    recipe.close();
  }
}

final recipeblog = RecipeBloc();
