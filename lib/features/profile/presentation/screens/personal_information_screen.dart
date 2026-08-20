import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/profile/domain/entities/profile_entity.dart';
import 'package:medicine_cabinet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:medicine_cabinet/features/profile/presentation/cubit/profile_state.dart';

class PersonalInformationScreen extends StatefulWidget {
  final ProfileEntity profile;

  const PersonalInformationScreen({
    super.key,
    required this.profile,
  });

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
            Navigator.pop(context);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ProfileUpdating;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).primaryColor,
                        backgroundImage: widget.profile.photoUrl != null
                            ? NetworkImage(widget.profile.photoUrl!)
                            : null,
                        child: widget.profile.photoUrl == null
                            ? Text(
                          widget.profile.name.isNotEmpty
                              ? widget.profile.name[0].toUpperCase()
                              : 'U',
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(Icons.camera_alt,
                              size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller:
                  TextEditingController(text: widget.profile.email),
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                    final newName = _nameController.text.trim();
                    if (newName.isNotEmpty) {
                      context.read<ProfileCubit>().updateUserProfile(
                        name: newName,
                      );
                    }
                  },
                  child: isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text('Save Changes'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}