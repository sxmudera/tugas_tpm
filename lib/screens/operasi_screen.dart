import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_theme.dart';

class OperasiScreen extends StatefulWidget {
  const OperasiScreen({super.key});
  @override
  State<OperasiScreen> createState() => _State();
}

class _State extends State<OperasiScreen> {
  final _a = TextEditingController();
  final _b = TextEditingController();
  String? _hasil;
  String? _expr;

  String _fmt(double v) =>
      v == v.truncateToDouble() ? v.toInt().toString() : v.toString();

  void _hitung(String op) {
    final a = double.tryParse(_a.text);
    final b = double.tryParse(_b.text);
    if (a == null || b == null) {
      setState(() {
        _hasil = 'Input tidak valid';
        _expr = null;
      });
      return;
    }
    final r = op == '+' ? a + b : a - b;
    setState(() {
      _expr = '${_fmt(a)}  $op  ${_fmt(b)}';
      _hasil = _fmt(r);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operasi Hitung'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_hasil != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              decoration: BoxDecoration(
                color: kHijau,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_expr != null)
                    Text(
                      _expr!,
                      style: const TextStyle(fontSize: 12, color: kHitam),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    _hasil!,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: kHitam,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bilangan A',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kHitam,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _a,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                  ],
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kHitam,
                  ),
                  decoration: const InputDecoration(hintText: '0'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bilangan B',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kHitam,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _b,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                  ],
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _hitung('+'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kHitam,
                  ),
                  decoration: const InputDecoration(hintText: '0'),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _hitung('+'),
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: kHijau,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '+',
                            style: TextStyle(
                              color: kHitam,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _hitung('-'),
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: kHitam,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '−',
                            style: TextStyle(
                              color: kPutih,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
