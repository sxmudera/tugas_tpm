import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_theme.dart';

class BilanganScreen extends StatefulWidget {
  const BilanganScreen({super.key});
  @override
  State<BilanganScreen> createState() => _State();
}

class _State extends State<BilanganScreen> {
  final _c = TextEditingController();
  Map<String, String>? _r;

  bool _prima(int n) {
    if (n < 2) return false;
    for (int i = 2; i * i <= n; i++) if (n % i == 0) return false;
    return true;
  }

  void _cek() {
    final n = int.tryParse(_c.text);
    if (n == null) {
      setState(() => _r = {'error': 'Masukkan bilangan bulat'});
      return;
    }
    setState(() => _r = {
      'Ganjil / Genap': n.isEven ? 'Genap' : 'Ganjil',
      'Prima':          _prima(n) ? 'Ya' : 'Bukan',
      'Tanda':          n > 0 ? 'Positif' : n < 0 ? 'Negatif' : 'Nol',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Bilangan'),
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
            TextField(
              controller: _c,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*'))],
              onSubmitted: (_) => _cek(),
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: kHitam),
              decoration: const InputDecoration(hintText: '0'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _cek,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: kHijau,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text('Cek',
                    style: TextStyle(
                        color: kHitam, fontWeight: FontWeight.w800, fontSize: 14)),
              ),
            ),
            if (_r != null) ...[
              const SizedBox(height: 32),
              if (_r!.containsKey('error'))
                Text(_r!['error']!,
                    style: const TextStyle(fontSize: 13, color: Color(0xFFCC0000)))
              else
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: kHitam)),
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
