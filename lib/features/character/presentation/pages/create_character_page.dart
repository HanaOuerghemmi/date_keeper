import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/presentation/bloc/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateCharacterPage extends StatefulWidget {
  @override
  _CreateCharacterPageState createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<CreateCharacterPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String relationship = '';
  String description = '';
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm(
    BuildContext context,
  ) {
    if (_formKey.currentState!.validate()) {
      context.read<CharacterBloc>().add(CharacterEvent.createCharacter(
          characterEntity:
              CharacterEntity(name: name, relationship: relationship)));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Character created successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterBloc, CharacterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Create Character')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name TextField
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),

                    // Relationship TextField
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Relationship'),
                      onChanged: (value) {
                        setState(() {
                          relationship = value;
                        });
                      },
                    ),

                    // Description TextField
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 4,
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),

                    SizedBox(height: 16),

                    // Image Picker
                    GestureDetector(
                      onTap: _pickImage,
                      child: _image == null
                          ? Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Icon(Icons.add_a_photo, size: 50),
                            )
                          : Image.file(_image!, height: 150, fit: BoxFit.cover),
                    ),

                    SizedBox(height: 24),

                    // Submit Button
                    ElevatedButton(
                      onPressed: () => _submitForm(context),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
