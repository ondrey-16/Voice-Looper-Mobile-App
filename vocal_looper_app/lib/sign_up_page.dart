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
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatelessWidget {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        padding: EdgeInsets.all(30),
        children: [
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Nickname'),
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              controller: _textController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Birth Date'),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                );

                if (date != null) {
                  _textController.text = date.toString().split(" ")[0];
                }
              },
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ),
          SeparatedWidget(
            widget: TextFormField(
              decoration: InputDecoration(labelText: 'Confirm password'),
              obscureText: true,
            ),
          ),
          Center(
            child: SizedBox(
              width: 90,
              child: ElevatedButton(
                onPressed: () => context.go('/'),
                child: Text(
                  'Send',
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

class SeparatedWidget extends StatelessWidget {
  final Widget widget;
  const SeparatedWidget({super.key, required this.widget});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: 60), child: widget);
  }
}
