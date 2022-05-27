class BlogModel {
  String? responseCode;
  String? msg;
  List<Blogs> blogs = [];
  String? status;

  BlogModel({this.responseCode, this.msg, this.blogs = const [], this.status});

  BlogModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    msg = json['message'];
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs.add(Blogs.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = msg;
    if (blogs != null) {
      data['blogs'] = blogs.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Blogs {
  String? blog_id;
  String? title;
  String? slug;
  String? content;
  String? image;
  String? date;
  String? tags;

  Blogs({
    this.blog_id,
    this.title,
    this.slug,
    this.content,
    this.image,
    this.date,
    this.tags,
  });

  Blogs.fromJson(Map<String, dynamic> json) {
    blog_id = json['blog_id'];
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    image = json['image'];
    date = json['date'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['blog_id'] = blog_id;
    data['title'] = title;
    data['slug'] = slug;
    data['content'] = content;
    data['image'] = image;
    data['date'] = date;
    data['tags'] = tags;
    return data;
  }
}
