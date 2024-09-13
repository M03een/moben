import 'package:flutter/material.dart';
import 'package:moben/view/notifications_manger_view/widgets/notification_manager_view_body.dart';

class NotificationManagerView extends StatelessWidget {
  const NotificationManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return     Scaffold(
      body: NotificationViewBody(),
    );
  }
}
