import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/stat_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/report_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Merhaba,",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Text(
                    "Ahmet",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildHeaderIcon(Icons.search),
                  const SizedBox(width: 10),
                  Stack(
                    children: [
                      _buildHeaderIcon(Icons.notifications_none),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            "3",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // İstatistik Kartları
          Row(
            children: const [
              Expanded(
                child: StatCard(
                  icon: Icons.warning_amber_rounded,
                  count: "248",
                  label: "Aktif",
                  color: Colors.orange,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  icon: Icons.check_circle_outline,
                  count: "1.2K",
                  label: "Çözülen",
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  icon: Icons.access_time,
                  count: "86",
                  label: "Bekleyen",
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  icon: Icons.trending_up,
                  count: "+34",
                  label: "Bu Hafta",
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Hızlı Bildirim
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Hızlı Bildirim",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Tümü >",
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              QuickActionCard(
                icon: Icons.water_drop_outlined,
                label: "Altyapı",
                color: Colors.blue,
              ),
              QuickActionCard(
                icon: Icons.electric_bolt,
                label: "Elektrik",
                color: Colors.orange,
              ),
              QuickActionCard(
                icon: Icons.park_outlined,
                label: "Çevre",
                color: Colors.green,
              ),
              QuickActionCard(
                icon: Icons.directions_car_outlined,
                label: "Trafik",
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // AI Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.green.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.auto_awesome, color: kPrimaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Yapay Zeka Analizi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Fotoğraf yükleyin, AI sorunu otomatik sınıflandırsın",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Son Bildirimler
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Son Bildirimler",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Tümü >",
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ],
          ),
          const ReportListItem(
            title: "Kaldırıma Taşkın Ağaç Dalı",
            location: "Kadıköy, Moda Cd.",
            status: "İnceleniyor",
            statusColor: Colors.orange,
            time: "2 saat önce",
            likes: 24,
            comments: 8,
          ),
          const SizedBox(height: 12),
          const ReportListItem(
            title: "Su Boru Patlaması",
            location: "Beşiktaş, Barbaros Blv.",
            status: "İşleme Alındı",
            statusColor: Colors.green,
            time: "4 saat önce",
            likes: 56,
            comments: 15,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Icon(icon, color: kTextColor),
    );
  }
}
