import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/report_issue_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const MapScreen(),
    const SizedBox(), // Ortadaki buton için boşluk
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pages[_currentIndex == 2 ? 0 : _currentIndex],

      // --- ORTA BUTON AYARLARI ---
      floatingActionButton: Transform.translate(
        // Y ekseninde (dikey) 28 piksel aşağı indiriyoruz.
        // Bu değer butonu diğer ikonlarla tam aynı hizaya (satır içine) sokar.
        offset: const Offset(0, 28),
        child: SizedBox(
          height: 60, // Boyutu 70'ten 60'a düşürdük
          width: 60,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReportIssueScreen(),
                ),
              );
            },
            backgroundColor: kPrimaryColor,
            shape: const CircleBorder(),
            elevation: 4, // Hafif gölge
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ), // İkon boyutu da orantılı küçüldü
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // --- ALT MENÜ (BOTTOM BAR) ---
      bottomNavigationBar: BottomAppBar(
        shape: null, // Arkadaki oyuğu iptal ettik (düz zemin)
        color: Colors.white,
        elevation: 10,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height:
              65, // Bar yüksekliğini çok az artırdık (60 -> 65) ki buton sıkışmasın
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center, // Dikeyde ortala
            children: [
              // Sol İkonlar
              Row(
                children: [
                  _buildNavItem(Icons.home_outlined, "Ana Sayfa", 0),
                  const SizedBox(width: 25), // İkon arası boşluk
                  _buildNavItem(Icons.location_on_outlined, "Harita", 1),
                ],
              ),

              // Orta Boşluk (Buton buraya gelecek)
              const SizedBox(width: 50),

              // Sağ İkonlar
              Row(
                children: [
                  _buildNavItem(
                    Icons.notifications_none_outlined,
                    "Bildirimler",
                    3,
                  ),
                  const SizedBox(width: 25), // İkon arası boşluk
                  _buildNavItem(Icons.person_outline, "Profil", 4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? kPrimaryColor : Colors.grey,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? kPrimaryColor : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            // Seçili ise altındaki nokta
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 2),
                height: 4,
                width: 4,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
