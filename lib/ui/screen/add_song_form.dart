// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_app/model/song.dart';
import 'package:my_app/ui/provider/song_provider.dart';
import 'package:provider/provider.dart';

enum EditingMode { addProduct, editProduct }

class AddSongForm extends StatefulWidget {
  const AddSongForm({super.key, required this.mode, this.song});
  final EditingMode mode;
  final Song? song; // Pass the song to edit (nullable)

  @override
  State<AddSongForm> createState() => _AddSongFormState();
}

class _AddSongFormState extends State<AddSongForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _albumController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the form fields if in edit mode
    if (widget.mode == EditingMode.editProduct && widget.song != null) {
      _titleController.text = widget.song!.title;
      _artistController.text = widget.song!.artist;
      _albumController.text = widget.song!.album;
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final songProvider = Provider.of<SongProvider>(context, listen: false);

        if (widget.mode == EditingMode.addProduct) {
          // Add a new song
          songProvider.addSong(
            _titleController.text,
            _artistController.text,
            _albumController.text,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Song added successfully!')),
          );
        } else if (widget.mode == EditingMode.editProduct &&
            widget.song != null) {
          // Update an existing song
          final updatedSong = Song(
            id: widget.song!.id, // Keep the same ID
            title: _titleController.text,
            artist: _artistController.text,
            album: _albumController.text,
          );
          songProvider.updateSong(updatedSong);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Song updated successfully!')),
          );
        }

        _formKey.currentState!.reset();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save song: $e')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    Navigator.of(context).pop(); // Close the dialog after submission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mode == EditingMode.editProduct ? 'Edit Song' : 'Add New Song',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _artistController,
                decoration: const InputDecoration(labelText: 'Artist'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an artist';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _albumController,
                decoration: const InputDecoration(labelText: 'Album'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an album';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        widget.mode == EditingMode.editProduct
                            ? 'Update Song'
                            : 'Add Song',
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
