import 'package:flutter/material.dart';
import 'package:flutter_dashboard_demo/transparent_page_route.dart';

showFormPage(BuildContext context) {
  Navigator.of(context).push(
    TransparentPageRoute(
      builder: (context) => Builder(
        builder: (context) {
          final size = MediaQuery.of(context).size;
          final maxHeight = size.height - 200;

          return Container(
            constraints: size.width > 600 ? BoxConstraints(maxHeight: maxHeight, maxWidth: 600) : null,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Form"),
              ),
              body: FormPage(),
            ),
          );
        },
      ),
    ),
  );
}

// Define a custom Form widget.
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  FormPageState createState() {
    return FormPageState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class FormPageState extends State<FormPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    final children = [
      TextFormField(
        decoration: InputDecoration(
          hintText: 'Enter your email',
          labelText: 'Email',
          filled: true,
        ),
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: 'Some other thing',
          labelText: 'Thing',
          filled: true,
        ),
      ),
    ];

    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 50,
          left: 0,
          right: 0,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16);
                },
                itemCount: children.length,
                itemBuilder: (context, index) => children[index],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('GUARDAR'),
          ),
        ),
      ],
    );
  }
}
