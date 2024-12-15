import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelListPage extends StatelessWidget {
  const ChannelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listController = StreamChannelListController(
      client: StreamChat.of(context).client,
      filter: Filter.in_('members', const ['1']),
      channelStateSort: const [SortOption('last_message_at')],
    );

    return StreamChannelListView(
      controller: listController,
      onChannelTap: (channel) {
        context.push('/channelpage', extra: channel);
      },
    );
  }
}
