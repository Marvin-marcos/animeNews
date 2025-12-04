import 'package:filmes_hobby/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
const AuthScreen({super.key});


@override
State<AuthScreen> createState() => _AuthScreenState();
}


class _AuthScreenState extends State<AuthScreen> {
final _emailCtrl = TextEditingController();
final _passCtrl = TextEditingController();
final _auth = FirebaseAuth.instance;
bool _loading = false;


Future<void> _login() async {
setState(() => _loading = true);
try {
await _auth.signInWithEmailAndPassword(
email: _emailCtrl.text.trim(),
password: _passCtrl.text,
);
if (!mounted) return;
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
} on FirebaseAuthException catch (e) {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Erro')));
} finally {
setState(() => _loading = false);
}
}


Future<void> _register() async {
setState(() => _loading = true);
try {
await _auth.createUserWithEmailAndPassword(
email: _emailCtrl.text.trim(),
password: _passCtrl.text,
);
if (!mounted) return;
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
} on FirebaseAuthException catch (e) {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Erro')));
} finally {
setState(() => _loading = false);
}
}


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('animeNews - Login')),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
children: [
TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
TextField(controller: _passCtrl, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
const SizedBox(height: 20),
if (_loading) const CircularProgressIndicator(),
ElevatedButton(onPressed: _login, child: const Text('Entrar')),
TextButton(onPressed: _register, child: const Text('Criar conta')),
],
),
),
);
}
}