import 'package:flutter/material.dart';

class MarketsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MarketsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Selecciona una Plaza de Mercado'),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
        const CircleAvatar(
          //TODO: Replace with user image
          backgroundImage: NetworkImage('https://picsum.photos/200'),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
