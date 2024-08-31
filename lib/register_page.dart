import 'package:flutter/material.dart';
import 'package:login_with_firebase/login_page.dart';
import 'package:login_with_firebase/main.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Register",
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(
              height: 50,
            ),
            const Icon(
              Icons.note_add,
              size: 100,
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                    hintText: 'Email', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: password,
                decoration: const InputDecoration(
                    hintText: 'Password', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      try {
                        await authService.createUserWithEmailAndPassword(
                            email.text, password.text);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Gagal daftar")));
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
