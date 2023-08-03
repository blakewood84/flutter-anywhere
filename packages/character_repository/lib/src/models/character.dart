import 'package:equatable/equatable.dart' show Equatable;

/// A Character
class Character extends Equatable {
  /// Creates a [Character] from json data
  Character.fromJson(Map<String, dynamic> json)
      : title = (json['FirstURL'] as String).split('.com/')[1].replaceAll('_', ' '),
        image = json['Icon']['URL'] as String,
        description = json['Text'] as String;

  /// Name of the [Character]
  final String title;

  /// Image of the [Character]
  final String image;

  /// Description of the [Character]
  final String description;

  @override
  List<Object?> get props => [title, image, description];

  @override
  bool get stringify => true;
}
