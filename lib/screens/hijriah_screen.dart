import 'package:flutter/material.dart';
import '../app_theme.dart';

class HijriahScreen extends StatefulWidget {
  const HijriahScreen({super.key});
  @override
  State<HijriahScreen> createState() => _State();
}

class _State extends State<HijriahScreen> {
  DateTime? _tgl;
  String? _hijri;

  // Fungsi konversi yang lebih akurat
  String _masehiKeHijriah(DateTime date) {
    // Kita tambahkan sedikit adjustment agar tidak 'kelebihan' 1 hari
    // Seringkali algoritma tabular butuh koreksi -1 atau -2 hari tergantung zona
    int day = date.day;
    int month = date.month;
    int year = date.year;

    if (month < 3) {
      year -= 1;
      month += 12;
    }

    int a = (year / 100).floor();
    int b = 2 - a + (a / 4).floor();

    // Julian Day Calculation
    int jd =
        (365.25 * (year + 4716)).floor() +
        (30.6001 * (month + 1)).floor() +
        day +
        b -
        1524;

    int daysSinceHijra = jd - 1948441;

    int cycles = (daysSinceHijra / 10631).floor();
    int remainingDays = daysSinceHijra % 10631;

    int yearInCycle = 0;
    for (int i = 1; i <= 30; i++) {
      int daysInYear = _isLeapYearHijri(i) ? 355 : 354;
      if (remainingDays < daysInYear) {
        yearInCycle = i;
        break;
      }
      remainingDays -= daysInYear;
    }

    int hYear = (cycles * 30) + yearInCycle;
    int hMonth = 0;
    int hDay = 0;

    for (int m = 1; m <= 12; m++) {
      int daysInMonth = (m % 2 != 0) ? 30 : 29;
      if (m == 12 && _isLeapYearHijri(yearInCycle)) daysInMonth = 30;

      if (remainingDays < daysInMonth) {
        hMonth = m;
        hDay = remainingDays + 1;
        break;
      }
      remainingDays -= daysInMonth;
    }

    // Jika hDay masih 0 karena perhitungan pembulatan
    if (hDay == 0) hDay = 1;

    final daftarBulan = [
      '',
      'Muharram',
      'Safar',
      'Rabiul Awal',
      'Rabiul Akhir',
      'Jumadil Awal',
      'Jumadil Akhir',
      'Rajab',
      'Syaban',
      'Ramadhan',
      'Syawal',
      'Dzulqadah',
      'Dzulhijjah',
    ];

    return '$hDay ${daftarBulan[hMonth]} $hYear H';
  }

  // Tahun kabisat hijriah dalam siklus 30 tahun (2, 5, 7, 10, 13, 16, 18, 21, 24, 26, 29)
  bool _isLeapYearHijri(int year) {
    List<int> leaps = [2, 5, 7, 10, 13, 16, 18, 21, 24, 26, 29];
    return leaps.contains(year % 30);
  }

  void _pilihTanggal() async {
    final t = await showDatePicker(
      context: context,
      initialDate: _tgl ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
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
        _tgl = t;
        _hijri = _masehiKeHijriah(t);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Hijriah'),
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
            const Text(
              'Pilih Tanggal Masehi',
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
                      _tgl != null
                          ? "${_tgl!.day}/${_tgl!.month}/${_tgl!.year}"
                          : "Pilih tanggal",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Icon(Icons.calendar_today, size: 18),
                  ],
                ),
              ),
            ),
            if (_hijri != null) ...[
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
                    const Text(
                      'Hasil Konversi',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: kAbu,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _hijri!,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: kHitam,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
