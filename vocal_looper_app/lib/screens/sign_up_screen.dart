import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/separated_widget.dart';
import '../auth/auth_cubit.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Sign up'),
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
          return SignUpForm();
        },
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm();
  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  String? signUpErrorMessage;

  final _dataController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _dataController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(30),
        children: [
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name is required";
                }
                return null;
              },
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Last name is required";
                }
                return null;
              },
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Nickname'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Nickname is required";
                }
                final regex = RegExp(r'[<>/?;:.,"[\]{}=+)(*&^%$#@!~`\\|]');
                if (regex.hasMatch(value) || value.contains("'")) {
                  return 'Nickname can include letters, digits or -,_ characters';
                }
                return null;
              },
            ),
          ),
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
              controller: _dataController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Birth Date'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                );

                if (date != null) {
                  _dataController.text = date.toString().split(" ")[0];
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Birth date is required";
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
                if (value.length < 4 || value.length > 32) {
                  return 'Password must include 4-32 characters';
                }
                return null;
              },
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Confirm password'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password confirmation is required";
                }
                if (value != _passwordController.text) {
                  return "Passwords are not the same";
                }
                return null;
              },
            ),
          ),
          Center(
            child: SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  if (!(_formKey.currentState?.validate() ?? false)) {
                    return;
                  }

                  await authCubit.signUp(
                    _emailController.text,
                    _passwordController.text,
                  );
                },
                child: Text(
                  'Submit',
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
