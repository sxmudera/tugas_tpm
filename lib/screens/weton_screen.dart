import 'package:flutter/material.dart';
import '../app_theme.dart';

class WetonScreen extends StatefulWidget {
  const WetonScreen({super.key});
  @override
  State<WetonScreen> createState() => _State();
}

class _State extends State<WetonScreen> {
  DateTime? _tgl;
  String? _weton;

  void _pilihTanggal() async {
    final t = await showDatePicker(
      context: context,
      initialDate: _tgl ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: kHitam, onPrimary: kPutih),
          ),
          child: child!,
        );
      },
    );

    if (t != null) {
      // Patokan: 17 Agustus 1945 adalah Jumat Legi
      final diff = t.difference(DateTime(1945, 8, 17)).inDays;
      
      final d7 = (diff % 7 + 7) % 7;
      final d5 = (diff % 5 + 5) % 5;

      final saptawara = ['Jumat', 'Sabtu', 'Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis'];
      final pancawara = ['Legi', 'Pahing', 'Pon', 'Wage', 'Kliwon'];

      setState(() {
        _tgl = t;
        _weton = '${saptawara[d7]} ${pancawara[d5]}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Weton'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Tanggal',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kHitam)),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: _pilihTanggal,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: kHitam, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _tgl != null ? "${_tgl!.day}/${_tgl!.month}/${_tgl!.year}" : "Ketuk untuk memilih tanggal",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            if (_weton != null) ...[
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: kHijau,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text('Weton Anda',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kAbu)),
                    const SizedBox(height: 8),
                    Text(
                      _weton!,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: kHitam),
                    ),
                  ],
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}