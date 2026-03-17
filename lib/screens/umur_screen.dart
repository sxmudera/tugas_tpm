import 'package:flutter/material.dart';
import 'dart:async';
import '../app_theme.dart';

class UmurDetailScreen extends StatefulWidget {
  const UmurDetailScreen({super.key});
  @override
  State<UmurDetailScreen> createState() => _State();
}

class _State extends State<UmurDetailScreen> {
  DateTime? _tglLahir;
  Timer? _timer;
  Map<String, int> _diff = {};

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _pilihTanggal() async {
    final t = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: kHitam,
              onPrimary: kPutih,
            ),
          ),
          child: child!,
        );
      },
    );

    if (t != null) {
      setState(() {
        _tglLahir = t;
      });
      _startLiveUpdate();
    }
  }

  void _startLiveUpdate() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_tglLahir == null) return;

      final sekarang = DateTime.now();
      Duration duration = sekarang.difference(_tglLahir!);

      // Logika hitung manual untuk Tahun, Bulan, Hari agar akurat
      int years = sekarang.year - _tglLahir!.year;
      int months = sekarang.month - _tglLahir!.month;
      int days = sekarang.day - _tglLahir!.day;

      if (days < 0) {
        months -= 1;
        days += DateTime(sekarang.year, sekarang.month, 0).day;
      }
      if (months < 0) {
        years -= 1;
        months += 12;
      }

      setState(() {
        _diff = {
          'Tahun': years,
          'Bulan': months,
          'Hari': days,
          'Jam': sekarang.hour,
          'Menit': sekarang.minute,
          'Detik': sekarang.second,
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Umur & Waktu'),
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
              'Pilih Tanggal Lahir',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kHitam,
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: _pilihTanggal,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: kHitam, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _tglLahir != null
                          ? "${_tglLahir!.day}/${_tglLahir!.month}/${_tglLahir!.year}"
                          : "Ketuk untuk memilih tanggal",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(Icons.cake, size: 20),
                  ],
                ),
              ),
            ),
            if (_diff.isNotEmpty) ...[
              const SizedBox(height: 32),
              const Text(
                'Lama Waktu Sejak Lahir:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kAbu,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2,
                children: _diff.entries
                    .map(
                      (e) => Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: e.key == 'Detik'
                              ? kHijau
                              : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e.value.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: kHitam,
                              ),
                            ),
                            Text(
                              e.key,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: kAbu,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
