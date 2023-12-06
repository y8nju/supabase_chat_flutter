import 'package:flutter/material.dart';
import 'package:flutter_chatting_app/datas/chat_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.myName,
    required this.list,
    required this.client,
  }) : super(key: key);

  final String myName;
  final List<ChatDto> list;
  final SupabaseClient client;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      reverse: true,
      itemBuilder: (context, index) => _oneItem(list[index]),
    );
  }

  Widget _oneItem(ChatDto dto) {
    bool isMe = myName == dto.name;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
            color: isMe ? Colors.green : Colors.grey,
          ),
          child: Text(
            '${dto.text}',
            style: TextStyle(color: Colors.grey.shade200),
          ),
        ),
      ),
    );
  }
}
