import 'package:app_tugas/screens/umur_screen.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
import 'kelompok_screen.dart';
import 'operasi_screen.dart';
import 'bilangan_screen.dart';
import 'stopwatch_screen.dart';
import 'piramid_screen.dart';
import 'penghitung_teks_screen.dart';
import 'weton_screen.dart';
import 'hijriah_screen.dart';
import 'umur_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final menus = [
      ('Data Kelompok', const KelompokScreen()),
      ('Operasi Hitung', const OperasiScreen()),
      ('Cek Bilangan', const BilanganScreen()),
      ('Stopwatch', const StopwatchScreen()),
      ('Hitung Piramida', const PiramidScreen()),
      ('Penghitung Teks', const PenghitungTeksScreen()),
      ('Cek Weton Tanggal', const WetonScreen()),
      ('Konversi Hijriah', const HijriahScreen()),
      ('Cek Umur', const UmurDetailScreen()),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kHijau,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          child: Text(
                            user.nim,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: kHitam,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          user.nama,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: kHitam,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFCCCCCC),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: kHitam,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1, color: Color(0xFFEEEEEE)),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: menus.length,
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFEEEEEE),
                ),
                itemBuilder: (context, i) => InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => menus[i].$2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          menus[i].$1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: kHitam,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: kAbu,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
