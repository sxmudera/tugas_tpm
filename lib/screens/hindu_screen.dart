import 'package:flutter/material.dart';
import '../app_theme.dart';

class HinduCalendarResult {
  final String sakaYear;
  final String sakaMonth;
  final String paksa; // Suklapaksa / Kresnapaksa
  final String tithi; // Pratipada … Amavasya
  final String wuku;
  final String pancawara; // Pahing, Pon, Wage, Kliwon, Umanis
  final String saptawara; // Minggu … Sabtu
  final String triwara;
  final String caturwara;
  final String sadwara;
  final String astawara;
  final String sangawara;
  final String dasawara;

  const HinduCalendarResult({
    required this.sakaYear,
    required this.sakaMonth,
    required this.paksa,
    required this.tithi,
    required this.wuku,
    required this.pancawara,
    required this.saptawara,
    required this.triwara,
    required this.caturwara,
    required this.sadwara,
    required this.astawara,
    required this.sangawara,
    required this.dasawara,
  });
}

class HinduCalendarConverter {
  static const List<String> _pancawaraNames = [
    'Umanis',
    'Pahing',
    'Pon',
    'Wage',
    'Kliwon',
  ];

  static const List<String> _saptawaraNames = [
    'Redite',
    'Soma',
    'Anggara',
    'Buda',
    'Wraspati',
    'Sukra',
    'Saniscara',
  ];
  static const List<String> _triwaraNames = ['Pasah', 'Beteng', 'Kajeng'];
  static const List<String> _caturwaraNames = ['Sri', 'Laba', 'Jaya', 'Menala'];
  static const List<String> _sadwaraNames = [
    'Tungleh',
    'Aryang',
    'Urukung',
    'Paniron',
    'Was',
    'Maulu',
  ];
  static const List<String> _astawaraNames = [
    'Sri',
    'Indra',
    'Guru',
    'Yama',
    'Ludra',
    'Brahma',
    'Kala',
    'Uma',
  ];
  static const List<String> _sangawaraNames = [
    'Dangu',
    'Jangur',
    'Gigis',
    'Nohan',
    'Ogan',
    'Erangan',
    'Urungan',
    'Tulus',
    'Dadi',
  ];
  static const List<String> _dasawaraNames = [
    'Pandita',
    'Pati',
    'Suka',
    'Duka',
    'Sri',
    'Manuh',
    'Manusa',
    'Raja',
    'Dewa',
    'Raksasa',
  ];
  static const List<String> _wukuNames = [
    'Sinta',
    'Landep',
    'Ukir',
    'Kulantir',
    'Tolu',
    'Gumbreg',
    'Wariga',
    'Warigadean',
    'Julungwangi',
    'Sungsang',
    'Dungulan',
    'Kuningan',
    'Langkir',
    'Medangsia',
    'Pujut',
    'Pahang',
    'Krulut',
    'Mrakih',
    'Tambir',
    'Medangkungan',
    'Matal',
    'Uye',
    'Menail',
    'Prangbakat',
    'Bala',
    'Ugu',
    'Wayang',
    'Kelawu',
    'Dukut',
    'Watugunung',
  ];
  static const List<String> _sakaMonthNames = [
    'Caitra',
    'Waisaka',
    'Jyestha',
    'Asadha',
    'Srawana',
    'Bhadra',
    'Aswina',
    'Kartika',
    'Margasira',
    'Pausa',
    'Magha',
    'Phalguna',
  ];
  static const List<String> _tithiNames = [
    'Pratipada',
    'Dwithiya',
    'Trithiya',
    'Chaturti',
    'Panchami',
    'Shashti',
    'Saptami',
    'Ashtami',
    'Navami',
    'Dashami',
    'Ekadashi',
    'Dwadashi',
    'Trayodashi',
    'Chaturdashi',
    'Purnima/Amavasya',
  ];

  static int _toJulianDay(int y, int m, int d) {
    int a = ((14 - m) / 12).floor();
    int yy = y + 4800 - a;
    int mm = m + 12 * a - 3;
    return d +
        ((153 * mm + 2) / 5).floor() +
        365 * yy +
        (yy / 4).floor() -
        (yy / 100).floor() +
        (yy / 400).floor() -
        32045;
  }

  static HinduCalendarResult convert(DateTime date) {
    final int jd = _toJulianDay(date.year, date.month, date.day);

    // saka 78m, caka masehi + 2-3 bulan
    int sakaYear = date.year - 78;
    if (date.month < 3 || (date.month == 3 && date.day < 22)) sakaYear--;

    // saka, caitra maret-april
    int sakaMonthIndex = (date.month + 9) % 12;

    // tithi 29.5hari
    // purnima 2451580 (Jan 21, 2000 purnama)
    const double synodicMonth = 29.530589;
    const int epochJD = 2451580;
    double phase =
        ((jd - epochJD) % synodicMonth + synodicMonth) % synodicMonth;
    int tithiIndex = (phase / synodicMonth * 30).floor() % 30;

    String paksa;
    String tithi;
    if (tithiIndex < 15) {
      paksa = 'Suklapaksa (Terang)';
      tithi = _tithiNames[tithiIndex < 14 ? tithiIndex : 14];
      if (tithiIndex == 14) tithi = 'Purnima (Purnama)';
    } else {
      paksa = 'Kresnapaksa (Gelap)';
      int kIdx = tithiIndex - 15;
      tithi = _tithiNames[kIdx < 14 ? kIdx : 14];
      if (tithiIndex == 29) tithi = 'Amavasya (Tilem)';
    }

    // --- Wuku (siklus 210 hari, 30 wuku × 7 hari) ---
    // wuku (210 hari, 30 wukux 7 hari)
    // epoch : jd 2144957 = senin 25 feb 6 ce (sinta redite)

    const int wukuEpoch = 2144957;
    int dayInCycle = ((jd - wukuEpoch) % 210 + 210) % 210;
    int wukuIndex = dayInCycle ~/ 7;

    // saptawara
    int saptaIndex = (jd + 1) % 7; // 0=Minggu

    // pancawara
    const int pancaEpoch = 2144957; // Umanis
    int pancaIndex = ((jd - pancaEpoch) % 5 + 5) % 5;

    // triwara
    int triIndex = ((jd - wukuEpoch) % 3 + 3) % 3;

    // caturwara
    int caturIndex = ((jd - wukuEpoch) % 4 + 4) % 4;

    // sadwara
    int sadIndex = ((jd - wukuEpoch) % 6 + 6) % 6;

    // astawara
    int astaIndex = ((jd - wukuEpoch) % 8 + 8) % 8;

    // sangawara
    int sangaIndex = ((jd - wukuEpoch) % 9 + 9) % 9;

    // dasawara
    int dasaIndex = ((jd - wukuEpoch) % 10 + 10) % 10;

    return HinduCalendarResult(
      sakaYear: '$sakaYear Saka',
      sakaMonth: _sakaMonthNames[sakaMonthIndex],
      paksa: paksa,
      tithi: tithi,
      wuku: _wukuNames[wukuIndex],
      pancawara: _pancawaraNames[pancaIndex],
      saptawara: _saptawaraNames[saptaIndex],
      triwara: _triwaraNames[triIndex],
      caturwara: _caturwaraNames[caturIndex],
      sadwara: _sadwaraNames[sadIndex],
      astawara: _astawaraNames[astaIndex],
      sangawara: _sangawaraNames[sangaIndex],
      dasawara: _dasawaraNames[dasaIndex],
    );
  }
}

class HinduScreen extends StatefulWidget {
  const HinduScreen({super.key});

  @override
  State<HinduScreen> createState() => _HinduScreenState();
}

class _HinduScreenState extends State<HinduScreen> {
  DateTime? _selectedDate;
  HinduCalendarResult? _result;

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kHijau,
              onPrimary: kHitam,
              onSurface: kHitam,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _result = HinduCalendarConverter.convert(picked);
      });
    }
  }

  String _formatDate(DateTime d) {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${d.day} ${bulan[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: kHitam),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kalender Hindu',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: kHitam,
          ),
        ),
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
            _buildSectionLabel('Pilih Tanggal Masehi'),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFDDDDDD)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kHijau.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.calendar_today_rounded,
                        size: 20,
                        color: kHijau,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        _selectedDate != null
                            ? _formatDate(_selectedDate!)
                            : 'Ketuk untuk memilih tanggal',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _selectedDate != null
                              ? kHitam
                              : const Color(0xFFAAAAAA),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: kAbu,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),

            if (_result != null) ...[
              const SizedBox(height: 28),
              _buildSectionLabel('Hasil Kalender Hindu (Bali)'),
              const SizedBox(height: 10),

              _buildCard([
                _buildRow('Tahun Saka', _result!.sakaYear),
                _buildDivider(),
                _buildRow('Bulan Saka', _result!.sakaMonth),
                _buildDivider(),
                _buildRow('Paksa', _result!.paksa),
                _buildDivider(),
                _buildRow('Tithi', _result!.tithi),
              ]),
              const SizedBox(height: 14),

              _buildCard([
                _buildRow('Wuku', _result!.wuku, highlight: true),
                _buildDivider(),
                _buildRow('Saptawara', _result!.saptawara),
                _buildDivider(),
                _buildRow('Pancawara', _result!.pancawara),
              ]),
              const SizedBox(height: 14),

              _buildCard([
                _buildRow('Triwara', _result!.triwara),
                _buildDivider(),
                _buildRow('Caturwara', _result!.caturwara),
                _buildDivider(),
                _buildRow('Sadwara', _result!.sadwara),
                _buildDivider(),
                _buildRow('Astawara', _result!.astawara),
                _buildDivider(),
                _buildRow('Sangawara', _result!.sangawara),
                _buildDivider(),
                _buildRow('Dasawara', _result!.dasawara),
              ]),

              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: kAbu,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kAbu,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: highlight
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: kHijau,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: kHitam,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  )
                : Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kHitam,
                    ),
                    textAlign: TextAlign.right,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0));
}
