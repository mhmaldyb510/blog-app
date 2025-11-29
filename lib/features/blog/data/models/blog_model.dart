import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.posterName,
  });
  BlogModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'updated_at': updatedAt.toIso8601String(),
    'user_id': userId,
    'title': title,
    'content': content,
    'image_url': imageUrl,
    'topics': topics,
  };

  toJson() => toMap();

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String? ?? '',
    content: json['content'] as String? ?? '',
    imageUrl: json['image_url'] as String? ?? '',
    topics: List<String>.from(json['topics'] as List<dynamic>? ?? []),
    updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
  );
}
