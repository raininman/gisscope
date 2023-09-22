import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 41, 71, 1),
      body: Column(
        children: [
          const Text(
            "Hello, welcome back!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Login to continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              filled: true,
              fillColor: Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              filled: true,
              fillColor: Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                print("Forgot");
              },
              style: TextButton.styleFrom(
                foregroundColor: Color.fromRGBO(194, 194, 194, 1),
              ),
              child: const Text("Forgot password?"),
            ),
          ),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                print("Login");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(251, 213, 18, 1),
                foregroundColor: Colors.black,
              ),
              child: const Text("Log in"),
            ),
          ),
          const SizedBox(
            height: 88,
          ),
          const Text(
            "Or sign in with",
            style: TextStyle(
                color: Color.fromRGBO(216, 216, 216, 1), fontSize: 16),
          ),
          const SizedBox(
            height: 24.5,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
            onPressed: () {
              print("google");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/google.png",
                  width: 22,
                  height: 22,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("Login with Google")
              ],
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
            onPressed: () {
              print("facebook");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/facebook.png",
                  width: 22,
                  height: 22,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("Login with Facebook")
              ],
            ),
          ),
          const SizedBox(
            width: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have account? ",
                style: TextStyle(
                  color: Color.fromRGBO(167, 167, 167, 1),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(251, 213, 18, 1)),
                onPressed: () {
                  print("sign up");
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
