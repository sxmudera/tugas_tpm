import 'package:flutter/material.dart';
import 'dart:async';
import '../app_theme.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});
  @override
  State<StopwatchScreen> createState() => _State();
}

class _State extends State<StopwatchScreen> {
  Timer? _t;
  int _ms = 86399000;
  bool _running = false;
  final List<int> _laps = [];
  final int _limit24Jam = 86400000;

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  void _toggle() {
    if (_running) {
      _t?.cancel();
      setState(() => _running = false);
    } else {
      _t = Timer.periodic(const Duration(milliseconds: 10), (_) {
        setState(() {
          _ms += 10;
          // Jika sudah mencapai atau melewati 24 jam
          if (_ms >= _limit24Jam) {
            _ms =
                0; // Balik ke nol tapi tidak di-cancel timernya (tetap lanjut)
          }
        });
      });
      setState(() => _running = true);
    }
  }

  void _reset() {
    _t?.cancel();
    setState(() {
      _ms = 0;
      _running = false;
      _laps.clear();
    });
  }

  String _fmt(int ms) {
    final h = (ms ~/ 3600000).toString().padLeft(2, '0');
    final m = ((ms % 3600000) ~/ 60000).toString().padLeft(2, '0');
    final s = ((ms % 60000) ~/ 1000).toString().padLeft(2, '0');
    final cs = ((ms % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$h:$m:$s.$cs';
  }

  Widget _btn(String label, VoidCallback? onTap, {bool accent = false}) =>
      Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: onTap == null
                  ? const Color(0xFFEEEEEE)
                  : accent
                  ? kHijau
                  : kHitam,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: onTap == null
                    ? kAbu
                    : accent
                    ? kHitam
                    : kPutih,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: _running ? kHijau : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24),
              child: Text(
                _fmt(_ms),
                style: const TextStyle(
                  fontSize: 38, // Diperkecil agar format HH:MM:SS.cs muat
                  fontWeight: FontWeight.w900,
                  color: kHitam,
                  fontFamily: 'monospace',
                  letterSpacing: -1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _btn(_running ? 'Pause' : 'Start', _toggle, accent: true),
                const SizedBox(width: 8),
                _btn(
                  'Lap',
                  _running ? () => setState(() => _laps.insert(0, _ms)) : null,
                ),
                const SizedBox(width: 8),
                _btn('Reset', _reset),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _laps.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada lap',
                        style: TextStyle(color: kAbu, fontSize: 13),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: _laps.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFEEEEEE),
                      ),
                      itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lap ${_laps.length - i}',
                              style: const TextStyle(fontSize: 12, color: kAbu),
                            ),
                            Text(
                              _fmt(_laps[i]),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: kHitam,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
