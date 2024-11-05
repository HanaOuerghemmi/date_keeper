import 'package:date_keeper/core/core.dart';
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
  bool _isSubmitting = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      context.read<CharacterBloc>().add(
        CharacterEvent.createCharacter(
          //fileImage: _image!,
          characterEntity: CharacterEntity(
            name: name,
            relationship: relationship,
            profilePicture: _image != null ? _image!.path : '',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterBloc, CharacterState>(
      listener: (context, state) {
        state.when(
          initial: () => {},
          loading: () => setState(() {
            _isSubmitting = true;
          }),
          loaded: () {
            setState(() {
              _isSubmitting = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Character created successfully!')),
            );
            Navigator.of(context).pop(); // Close the dialog after success
          },
          error: (error) {
            setState(() {
              _isSubmitting = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to create character: $error')),
            );
          },
        );
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text('Create Character'),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: _image == null
                          ? Container(
                              decoration: BoxDecoration(
                                color: greyColor.withOpacity(0.4),
                                shape: BoxShape.circle,
                              ),
                              height: 100,
                              width: double.infinity,
                              child: Icon(
                                Icons.add_a_photo,
                                size: 35,
                                color: primaryColor,
                              ),
                            )
                          : Image.file(_image!, height: 150, fit: BoxFit.cover),
                    ),
                    mediumPaddingVert,
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
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Relationship'),
                      onChanged: (value) {
                        setState(() {
                          relationship = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 24),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : () => _submitForm(context),
                        child: _isSubmitting
                            ? SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text('Submit'),
                      ),
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

void showCreateCharacterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CreateCharacterPage();
    },
  );
}
