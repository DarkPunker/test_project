import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:test_project/screens/chat_screen/channel_page.dart';

class ChannelListPage extends StatelessWidget {
  const ChannelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listController = StreamChannelListController(
      client: StreamChat.of(context).client,
      filter: Filter.in_('members', const ['1']),
      channelStateSort: const [SortOption('last_message_at')],
    );

    return Scaffold(
      body: StreamChannelListView(
        controller: listController,
        onChannelTap: (channel) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => StreamChannel(
                channel: channel,
                child: const ChannelPage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
