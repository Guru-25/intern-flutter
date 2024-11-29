import 'package:kathiravan_fireworks/imports.dart';
import 'package:kathiravan_fireworks/services/auth_service.dart';
import 'package:kathiravan_fireworks/services/session_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    if (await SessionService.isLoggedIn()) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    }
  }

  Future<void> _handleLogin() async {
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');

    setState(() => _isLoading = true);

    try {
      if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all fields'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final success = await AuthService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (success) {
        await SessionService.saveLoginSession(_emailController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Home()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid credentials'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: const AppNameWidget(),
              ),
              const SizedBox(height: 100),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
              ),
              const SizedBox(height: 30.0),
              Center(
                child: MaterialButton(
                  height: 60,
                  color: Colors.black,
                  minWidth: size.width * 0.8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onPressed: _isLoading ? null : _handleLogin,
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const TextBuilder(
                        text: 'Login',
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextBuilder(
                    text: "Don't have an account? ",
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Register()));
                    },
                    child: const TextBuilder(
                      text: 'Sign Up',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
