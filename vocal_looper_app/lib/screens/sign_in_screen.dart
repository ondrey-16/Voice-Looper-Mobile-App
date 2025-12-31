import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      body: SignInForm(),
    );
  }
}

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        padding: EdgeInsets.all(30),
        children: [
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Nickname or email'),
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
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
                  onPressed: () => context.go('/'),
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
