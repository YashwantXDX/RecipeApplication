class RecipeModel{

  late String appLabel;
  late String appImageUrl;
  late double appCalories;
  late String appUrl;

  RecipeModel({this.appLabel = "Label",this.appCalories = 0.000,this.appImageUrl = "Image",this.appUrl = "url"});
  factory RecipeModel.fromMap(Map recipe){

    return RecipeModel(
      appLabel: recipe["label"],
      appCalories: recipe["calories"],
      appImageUrl: recipe["image"],
      appUrl: recipe["url"]
    );
  }
}