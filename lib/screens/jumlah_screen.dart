import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_theme.dart';

class JumlahScreen extends StatefulWidget {
  const JumlahScreen({super.key});
  @override
  State<JumlahScreen> createState() => _State();
}

class _State extends State<JumlahScreen> {
  final _c = TextEditingController();
  final List<double> _list = [];

  double get _total => _list.fold(0, (s, e) => s + e);

  String _fmt(double v) =>
      v == v.truncateToDouble() ? v.toInt().toString() : v.toStringAsFixed(2);

  void _add() {
    final v = double.tryParse(_c.text);
    if (v == null) return;
    setState(() => _list.add(v));
    _c.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Angka'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        ),
      ),
      body: Column(
        children: [
          if (_list.isNotEmpty)
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
                  const Text('Total',
                      style: TextStyle(
                          fontSize: 11, color: kHitam, fontWeight: FontWeight.w600)),
                  Text(_fmt(_total),
                      style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: kHitam,
                          height: 1.1)),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _c,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true, signed: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
                    ],
                    onSubmitted: (_) => _add(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700, color: kHitam),
                    decoration: const InputDecoration(hintText: 'Masukkan angka'),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _add,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: kHijau,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add, color: kHitam),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          Expanded(
            child: _list.isEmpty
                ? const Center(
                    child: Text('Belum ada angka',
                        style: TextStyle(color: kAbu, fontSize: 13)))
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: _list.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${i + 1}',
                              style: const TextStyle(fontSize: 12, color: kAbu)),
                          Text(_fmt(_list[i]),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700, color: kHitam)),
                          GestureDetector(
                            onTap: () => setState(() => _list.removeAt(i)),
                            child: const Icon(Icons.close, size: 16, color: kAbu),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
