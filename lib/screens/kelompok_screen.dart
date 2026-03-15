import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../data/kelompok_data.dart';

class KelompokScreen extends StatelessWidget {
  const KelompokScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kelompok'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: anggota.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        itemBuilder: (_, i) {
          final u = anggota[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: kHijau,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: kHitam,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(u.nama,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700, color: kHitam)),
                    const SizedBox(height: 2),
                    Text(u.nim,
                        style: const TextStyle(fontSize: 12, color: kAbu)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
