import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vocal_looper_app/auth/auth_cubit.dart';
import '../widgets/separated_widget.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Sign in'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? "Unknown error"),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is SignedInState) {
            context.go('/');
          }
        },
        builder: (context, state) {
          if (state is SigningState) {
            return Center(child: CircularProgressIndicator());
          }
          return SignInForm();
        },
      )
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  State<SignInForm> createState() {
    return _SignInFormState();
  }
}

class _SignInFormState extends State<SignInForm> {
  String? signInErrorMessage;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    return Form(
      child: ListView(
        padding: EdgeInsets.all(30),
        children: [
          SeparatedWidget(
            widget: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }
                if (!value.contains('@')) {
                  return 'Invalid email';
                }
                return null;
              },
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }
                return null;
              },
            ),
          ),
          SeparatedWidget(
            widget: Center(
              child: SizedBox(
                width: 90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    await authCubit.signInWithEmail(
                      _emailController.text,
                      _passwordController.text
                    );
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            height: 30,
          ),
          Center(
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () => context.go('/sign-up'),
                child: Text(
                  'Or create new account',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
