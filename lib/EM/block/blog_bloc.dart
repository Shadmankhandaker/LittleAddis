import 'package:rxdart/rxdart.dart';

import '../../ENG/model/blog_model.dart';
import '../../ENG/repository/repository.dart';

class BlogBloc {
  final blogs = PublishSubject<BlogModel>();

  Stream<BlogModel> get blogsStream => blogs.stream;

  Future blogsSink() async {
    BlogModel nearbyModal = await Repository().blogRepository();
    blogs.sink.add(nearbyModal);
  }

  dispose() {
    blogs.close();
  }
}

final blogsblog = BlogBloc();
