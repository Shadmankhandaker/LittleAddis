class RecipeResponseModel {
  String? code;
  List<Output> output = [];

  RecipeResponseModel({this.code, this.output = const []});

  RecipeResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['output'] != null) {
      output = <Output>[];
      json['output'].forEach((v) {
        output.add(Output.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['output'] = output.map((v) => v.toJson()).toList();
    return data;
  }
}

class Output {
  String? shortdesc;
  String? image;
  String? id;
  Steps? steps;
  String? postTitle;
  String? modified;
  String? thumbnail;

  Output(
      {this.shortdesc,
      this.image,
      this.id,
      this.postTitle,
      this.modified,
      this.thumbnail});

  Output.fromJson(Map<String, dynamic> json) {
    shortdesc = json['shortdesc'];
    image = json['image'];
    id = json['id'];
    postTitle = json['post_title'];
    modified = json['modified'];
    thumbnail = json['thumbnail'];
    steps = json['Steps'] != null ? Steps.fromJson(json['Steps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shortdesc'] = shortdesc;
    data['image'] = image;
    data['id'] = id;
    data['post_title'] = postTitle;
    data['thumbnail'] = thumbnail;
    data['modified'] = modified;
    if (steps != null) {
      data['Steps'] = steps!.toJson();
    }
    return data;
  }
}

class Steps {
  String? step01;
  String? step02;
  String? step03;
  String? step04;
  String? step05;

  Steps({this.step01, this.step02, this.step03, this.step04, this.step05});

  Steps.fromJson(Map<String, dynamic> json) {
    step01 = json['Step 01'];
    step02 = json['Step 02'];
    step03 = json['Step 03'];
    step04 = json['Step 04'];
    step05 = json['Step 05'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Step 01'] = step01;
    data['Step 02'] = step02;
    data['Step 03'] = step03;
    data['Step 04'] = step04;
    data['Step 05'] = step05;
    return data;
  }
}
