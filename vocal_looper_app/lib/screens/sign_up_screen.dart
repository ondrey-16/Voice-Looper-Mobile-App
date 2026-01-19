import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/separated_widget.dart';
import '../auth/auth_cubit.dart';
import '../models/user.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('signUpPage'),
      appBar: AppBar(
        key: const Key('signUpPageAppBar'),
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
          return SignUpForm(key: const Key('signUpForm'));
        },
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  String? signUpErrorMessage;

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthdateController = TextEditingController();
  DateTime _birthdate = DateTime.now();
  final _passwordController = TextEditingController();
  final List _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];

  int _formStep = 0;

  Widget _formStep1() => Form(
    key: _formKeys[0],
    child: Column(
      children: [
        SeparatedWidget(
          widget: TextFormField(
            key: const Key('nameField'),
            controller: _nameController,
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
            key: const Key('lastNameField'),
            controller: _lastNameController,
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
            key: const Key('nicknameField'),
            controller: _nicknameController,
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
            key: const Key('birthdateField'),
            controller: _birthdateController,
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
                _birthdateController.text = date.toString().split(" ")[0];
                _birthdate = date;
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
        Center(
          child: SizedBox(
            key: const Key('signUpNextButton'),
            width: 120,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () async {
                if (!(_formKeys[0].currentState?.validate() ?? false)) {
                  return;
                }
                setState(() {
                  _formStep = 1;
                });
              },
              child: Text(
                'Next',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _formStep2(AuthCubit authCubit) => Form(
    key: _formKeys[1],
    child: Column(
      children: [
        SeparatedWidget(
          widget: TextFormField(
            key: const Key('emailField'),
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
            key: const Key('passwordField'),
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
            key: const Key('confirmPasswordField'),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 120,
              child: ElevatedButton(
                key: const Key('signUpPreviousButton'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  setState(() {
                    _formStep = 0;
                  });
                },
                child: Text(
                  'Previous',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                key: const Key('signUpSubmitButton'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  if (!(_formKeys[1].currentState?.validate() ?? false)) {
                    return;
                  }
                  final user = UserData(
                    name: _nameController.text,
                    lastName: _lastNameController.text,
                    nickname: _nicknameController.text,
                    email: _emailController.text,
                    birthDate: _birthdate,
                  );
                  await authCubit.signUp(user, _passwordController.text);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  @override
  void dispose() {
    _birthdateController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    return IndexedStack(
      index: _formStep,
      children: [_formStep1(), _formStep2(authCubit)],
    );
  }
}
