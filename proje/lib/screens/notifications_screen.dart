import 'package:flutter/material.dart';
import '../widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Bildirimler",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: "Tümü"),
                  Tab(text: "Bildirimlerim"),
                  Tab(text: "Güncellemeler"),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: const [
                  NotificationCard(
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                    title: "Bildiriminiz çözüldü",
                    subtitle: "Kadıköy, Moda Cd. su boru tamiri tamamlandı.",
                    time: "15 dk önce",
                  ),
                  SizedBox(height: 12),
                  NotificationCard(
                    icon: Icons.chat_bubble_outline,
                    iconColor: Colors.blue,
                    title: "Yeni yorum geldi",
                    subtitle:
                        "\"Biz de aynı sorunu yaşıyoruz, çok teşekkürler!\"",
                    time: "1 saat önce",
                  ),
                  SizedBox(height: 12),
                  NotificationCard(
                    icon: Icons.thumb_up_alt_outlined,
                    iconColor: Colors.purple,
                    title: "12 kişi oyununa katıldı",
                    subtitle:
                        "Şişli trafik lambası arızası bildirimi trend oluyor.",
                    time: "2 saat önce",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
