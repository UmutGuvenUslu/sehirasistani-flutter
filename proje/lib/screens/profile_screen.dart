import 'package:flutter/material.dart';
import '../widgets/quick_action_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profil Kartı
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Ahmet Yılmaz",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Text(
                    "ahmet.yilmaz@email.com",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on, size: 14, color: Colors.blue),
                      SizedBox(width: 4),
                      Text(
                        "İstanbul, Kadıköy",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _ProfileStat(
                        count: "34",
                        label: "Bildirim",
                        icon: Icons.description_outlined,
                      ),
                      _ProfileStat(
                        count: "28",
                        label: "Çözülen",
                        icon: Icons.check_circle_outline,
                      ),
                      _ProfileStat(
                        count: "4.8",
                        label: "Puan",
                        icon: Icons.star_border,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Rozetler
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Rozetler",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.star,
                    label: "İlk Bildirim",
                    color: Colors.orange,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.star,
                    label: "10 Bildirim",
                    color: Colors.orange,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.verified,
                    label: "Topluluk Lideri",
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Ayarlar Listesi
            const Text(
              "HESAP",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    Icons.person_outline,
                    "Kişisel Bilgiler",
                    "Ad, e-posta, telefon",
                  ),
                  const Divider(height: 1),
                  _buildSettingsItem(
                    Icons.location_on_outlined,
                    "Konum Ayarları",
                    "Varsayılan konum, izinler",
                  ),
                  const Divider(height: 1),
                  _buildSettingsItem(
                    Icons.notifications_none,
                    "Bildirim Tercihleri",
                    "Push bildirimler, e-posta",
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

class _ProfileStat extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;
  const _ProfileStat({
    required this.count,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.blue),
            const SizedBox(width: 4),
            Text(
              count,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
  return ListTile(
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black54),
    ),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(fontSize: 12, color: Colors.grey),
    ),
    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
  );
}
