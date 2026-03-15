import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../data/kelompok_data.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _State();
}

class _State extends State<LoginScreen> {
  final _u = TextEditingController();
  final _p = TextEditingController();
  bool _hide = true;
  String? _err;

  void _login() {
    final user = authenticate(_u.text.trim(), _p.text.trim());
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
      );
    } else {
      setState(() => _err = 'Username atau password salah.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: kHijau,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: const Text(
                    'TUGAS 2',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: kHitam,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Selamat\nDatang.',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: kHitam,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 36),
                const Text('Username',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kHitam)),
                const SizedBox(height: 6),
                TextField(
                  controller: _u,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 15, color: kHitam),
                  decoration: const InputDecoration(hintText: 'Masukkan username'),
                ),
                const SizedBox(height: 14),
                const Text('Password',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kHitam)),
                const SizedBox(height: 6),
                TextField(
                  controller: _p,
                  obscureText: _hide,
                  onSubmitted: (_) => _login(),
                  style: const TextStyle(fontSize: 15, color: kHitam),
                  decoration: InputDecoration(
                    hintText: 'Masukkan password',
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => _hide = !_hide),
                      child: Icon(
                        _hide ? Icons.visibility_off : Icons.visibility,
                        size: 18,
                        color: kAbu,
                      ),
                    ),
                  ),
                ),
                if (_err != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Text(_err!,
                        style: const TextStyle(fontSize: 12, color: Color(0xFFCC0000))),
                  ),
                ],
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _login,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: kHijau,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        color: kHitam,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
