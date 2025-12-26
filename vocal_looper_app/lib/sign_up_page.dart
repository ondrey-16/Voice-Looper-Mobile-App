import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextFormField(decoration: InputDecoration(labelText: 'Name')),
            SizedBox(height: 20),
            TextFormField(decoration: InputDecoration(labelText: 'Last Name')),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            /*TODO Change birth date form field*/
            TextFormField(
              decoration: InputDecoration(labelText: 'Birth Date'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: Text('Send'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
