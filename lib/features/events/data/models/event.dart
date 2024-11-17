import 'package:fempinya3_flutter_app/features/events/data/models/event_member_comment.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/tag.dart';

class EventModel {
  final int? id;
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? address;
  final String? status;
  final String? type;
  final String? description;
  final int? companions;
  final List<TagModel>? tags;
  final List<EventMemberCommentModel>? comments;

  EventModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.status,
    required this.type,
    required this.description,
    required this.companions,
    required this.tags,
    required this.comments,
  });

  // Factory constructor for JSON deserialization
  factory EventModel.fromJson(Map<String, dynamic> data) {
    var tagsFromJson = data['tags'] as List?;
    List<TagModel>? tagList = tagsFromJson?.map((tag) => TagModel.fromJson(tag)).toList();
    var commentsFromJson = data['comments'] as List?;
    List<EventMemberCommentModel>? commentList = commentsFromJson?.map((comment) => EventMemberCommentModel.fromJson(comment)).toList();

    return EventModel(
      id: data['id'],
      title: data['title'],
      startDate: data['startDate'] != null ? DateTime.tryParse(data['startDate']) : null,
      endDate: data['endDate'] != null ? DateTime.tryParse(data['endDate']) : null,
      address: data['address'],
      status: data['status'],
      type: data['type'],
      description: data['description'],
      companions: data['companions'],
      tags: tagList,
      comments: commentList,
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'address': address,
      'status': status,
      'type': type,
      'description': description,
      'companions': companions,
      'tags': tags?.map((tag) => tag.toJson()).toList() ?? [],
      'comments': comments?.map((comment) => comment.toJson()).toList() ?? [],
    };
  }
}
