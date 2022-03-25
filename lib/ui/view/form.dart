import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/form_data.dart';
import 'package:my_app/services/data_service.dart';
import 'package:my_app/ui/cubit/form_cubit.dart';

class MyAppPage extends StatefulWidget {
  const MyAppPage({Key? key}) : super(key: key);

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  final dataservice = DataService();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormCubit(dataservice),
      child: const FormApp(),
    );
  }
}

class FormApp extends StatefulWidget {
  const FormApp({Key? key}) : super(key: key);

  @override
  State<FormApp> createState() => _FormAppState();
}

class _FormAppState extends State<FormApp> {
  Map<String, String> fieldValues = {};

  final TextEditingController _formController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sending Data')),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _formController,
                decoration: const InputDecoration(
                  labelText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required.';
                  }
                  return null;
                }, // InputDecoration
                onSaved: (value) {
                  setState(() {
                    fieldValues['Name'] = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _formController,
                decoration: const InputDecoration(
                  labelText: 'Occupation',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required.';
                  }
                  return null;
                }, // InputDecoration
                onSaved: (value) {
                  setState(() {
                    fieldValues['Occupation'] = value!;
                  });
                },
              ),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<FormCubit>()
                    .postData(FormModel(title: _formController.text));
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
          ],
        ), //TextFormField
      ),
    );
  }
}
