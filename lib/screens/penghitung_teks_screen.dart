import 'package:flutter/material.dart';
import '../app_theme.dart';

class PenghitungTeksScreen extends StatefulWidget {
  const PenghitungTeksScreen({super.key});
  @override
  State<PenghitungTeksScreen> createState() => _State();
}

class _State extends State<PenghitungTeksScreen> {
  final _c = TextEditingController();
  Map<String, int> _r = {
    'Karakter (dengan spasi)': 0,
    'Karakter (tanpa spasi)': 0,
    'Jumlah Kata': 0,
    'Jumlah Angka': 0,
  };

  void _hitung(String text) {
    setState(() {
      _r = {
        'Karakter (dengan spasi)': text.length,
        'Karakter (tanpa spasi)': text.replaceAll(RegExp(r'\s+'), '').length,
        'Jumlah Kata': text.trim().isEmpty
            ? 0
            : text.trim().split(RegExp(r'\s+')).length,
        'Jumlah Angka': text.replaceAll(RegExp(r'[^0-9]'), '').length,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penghitung Teks'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan Teks / Paragraf',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kHitam,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _c,
              maxLines: 6,
              onChanged: _hitung,
              style: const TextStyle(fontSize: 15, color: kHitam),
              decoration: const InputDecoration(
                hintText: 'Mulai mengetik di sini...',
              ),
            ),
            const SizedBox(height: 32),
            ..._r.entries.map(
              (e) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.key,
                      style: const TextStyle(fontSize: 13, color: kHitam),
                    ),
                    Text(
                      '${e.value}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: kHitam,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
