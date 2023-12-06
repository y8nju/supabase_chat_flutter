class ChatDto {
  ChatDto(this.id, this.name, this.text, this.created_at);

  final String id;
  final String name;
  final String text;
  final String created_at;

  factory ChatDto.fromJson(dynamic json) => ChatDto(
        json['id'],
        json['name'],
        json['text'],
        json['created_at'],
      );
  Map<String, dynamic> get toJson => <String, dynamic>{
        'id': id,
        'name': name,
        'text': text,
        'created_at': created_at,
      };
}
