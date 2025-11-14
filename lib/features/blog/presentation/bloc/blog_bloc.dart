import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>((event, emit) => _onBlogUpload(event, emit));
  }

  Future<void> _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await uploadBlog(
      UploadBlogParams(
        title: event.title,
        content: event.content,
        userId: event.userId,
        topics: event.topics,
        image: event.image,
      ),
    );

    res.fold((l) => emit(BlogFailure(l.message)), (r) => emit(BlogSuccess()));
  }
}
