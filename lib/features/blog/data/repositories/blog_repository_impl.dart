import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/data/datasources/blogs_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogsRemoteDataSource blogsRemoteDataSource;

  BlogRepositoryImpl(this.blogsRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        userId: userId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogsRemoteDataSource.uploadBlogImage(
        imageFile: image,
        blogModel: blogModel,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

     final updatedBlog = await blogsRemoteDataSource.uploadBlog(blogModel);
      return right(updatedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
