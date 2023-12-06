import 'package:flutter/material.dart';
import 'package:flutter_chatting_app/datas/chat_dto.dart';
import 'package:flutter_chatting_app/widgets/send_widget.dart';
import 'package:flutter_chatting_app/widgets/text_Widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ChatDto>? list;
  final String name = DateTime.now().millisecondsSinceEpoch.toString();
  late final SupabaseClient client;
  late final dynamic stream;

  @override
  void initState() {
    // TODO: implement initState
    client = Supabase.instance.client;
    _loadData();
    // realTime
    stream = client
        .from('chat')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .limit(1);
    super.initState();
  }

  Future<void> _loadData() async {
    final response =
        await Supabase.instance.client.from('chat').select().execute();
    if (response.status == 200) {
      setState(() {
        list = (response.data as List).map((e) => ChatDto.fromJson(e)).toList();
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade400,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: StreamBuilder<Object>(
                stream: stream,
                builder: (context, data) {
                  if (data.connectionState == ConnectionState.active) {
                    var d = (data.data as List);
                    if (list != null) {
                      var dto = ChatDto.fromJson(d[0]);
                      if (list!.isEmpty) {
                        list!.add(dto);
                      } else {
                        list!.insert(0, dto);
                      }
                    } else {
                      list = [];
                    }
                  }
                  return TextWidget(
                    myName: name,
                    list: list ?? [],
                    client: client,
                  );
                },
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade400,
          ),
          SendWidget(myName: name, client: client),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
