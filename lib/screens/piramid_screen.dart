import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import '../app_theme.dart';

class PiramidScreen extends StatefulWidget {
  const PiramidScreen({super.key});
  @override
  State<PiramidScreen> createState() => _State();
}

class _State extends State<PiramidScreen> {
  final _a = TextEditingController();
  final _t = TextEditingController();
  Map<String, String>? _r;

  String _fmt(double v) =>
      v == v.truncateToDouble() ? v.toInt().toString() : v.toStringAsFixed(2);

  void _hitung() {
    final a = double.tryParse(_a.text);
    final t = double.tryParse(_t.text);
    if (a == null || t == null || a <= 0 || t <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Masukkan nilai alas dan tinggi yang valid'),
        backgroundColor: kHitam,
      ));
      return;
    }
    final la = a * a;
    final s  = sqrt(pow(a / 2, 2) + pow(t, 2));
    final ls = 2 * a * s;
    setState(() => _r = {
      'Luas Alas':      '${_fmt(la)} cm²',
      'Sisi Miring':    '${_fmt(s)} cm',
      'Luas Selimut':   '${_fmt(ls)} cm²',
      'Luas Permukaan': '${_fmt(la + ls)} cm²',
      'Volume':         '${_fmt((1 / 3) * la * t)} cm³',
    });
  }

  Widget _field(String label, TextEditingController c) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kHitam)),
          const SizedBox(height: 6),
          TextField(
            controller: c,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kHitam),
            decoration: const InputDecoration(hintText: '0', suffixText: 'cm'),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piramid'),
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
            _field('Panjang Alas (a)', _a),
            const SizedBox(height: 16),
            _field('Tinggi (t)', _t),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _hitung,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: kHijau,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text('Hitung',
                    style: TextStyle(
                        color: kHitam, fontWeight: FontWeight.w800, fontSize: 14)),
              ),
            ),
            if (_r != null) ...[
              const SizedBox(height: 32),
              ..._r!.entries.map((e) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key,
                            style: const TextStyle(fontSize: 13, color: kHitam)),
                        Text(e.value,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800, color: kHitam)),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
