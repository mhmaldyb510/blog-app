import 'dart:async';
import 'dart:io';

import 'package:blog_app/core/use_case/use_case.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
    : _uploadBlog = uploadBlog,
      _getAllBlogs = getAllBlogs,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>((event, emit) => _onBlogUpload(event, emit));
    on<GetAllBlogsEvent>((event, emit) => _onGetAllBlogs(event, emit));
  }

  Future<void> _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        title: event.title,
        content: event.content,
        userId: event.userId,
        topics: event.topics,
        image: event.image,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  Future<void> _onGetAllBlogs(
    GetAllBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogDisplaySuccess(r)),
    );
  }
}
