import 'package:flutter/material.dart';
import 'package:flutter_chatting_app/datas/chat_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SendWidget extends StatefulWidget {
  const SendWidget({Key? key, required this.myName, required this.client})
      : super(key: key);

  final String myName;
  final SupabaseClient client;

  @override
  State<SendWidget> createState() => _SendWidgetState();
}

class _SendWidgetState extends State<SendWidget> {
  final tc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .4,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: TextField(
                  controller: tc,
                  maxLines: null,
                  onSubmitted: (str) async {
                    submit(str);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent, // 남은 공간 없이 누를 수 있도록
              onTap: () {
                submit(tc.text);
              },
              child: Container(
                height: double.infinity,
                color: Colors.grey.shade700,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.grey.shade200,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future submit(String str) async {
    if (str.isNotEmpty) {
      await widget.client
          .from('chat')
          .insert({'name': widget.myName, 'text': str});
      tc.clear();
    }
  }
}
