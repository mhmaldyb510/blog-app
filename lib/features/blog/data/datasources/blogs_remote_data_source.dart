import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogsRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File imageFile,
    required BlogModel blogModel,
  });
}

class BlogsRemoteDataSourceImpl implements BlogsRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toMap())
          .select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File imageFile,
    required BlogModel blogModel,
  }) async {
    try {
      supabaseClient.storage
          .from('blog_images')
          .update(blogModel.id, imageFile);
      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blogModel.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
