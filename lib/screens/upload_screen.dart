// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/provider/story_provider.dart';
import 'package:provider/provider.dart';

import '../routes/page_manager.dart';

class UploadScreen extends StatelessWidget {
  final Function() selectLocation;

  const UploadScreen({
    super.key,
    required this.selectLocation,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<StoryProvider>();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String? locationData;

    onGalleryView() async {
      final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
      final isLinux = defaultTargetPlatform == TargetPlatform.linux;
      if (isMacOS || isLinux) return;
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        provider.setImagePath(pickedFile.path);
        provider.setImageFile(pickedFile);
      }
    }

    Widget showImage() {
      final imagePath = context.read<StoryProvider>().imagePath;
      return kIsWeb
          ? Image.network(
              imagePath.toString(),
              fit: BoxFit.contain,
              width: 50,
            )
          : Image.file(
              File(imagePath.toString()),
              fit: BoxFit.contain,
              width: 50,
            );
    }

    onUpload() async {
      final ScaffoldMessengerState scaffoldMessengerState =
          ScaffoldMessenger.of(context);
      final imagePath = provider.imagePath;
      final imageFile = provider.imageFile;
      if (imagePath == null || imageFile == null) {
        scaffoldMessengerState.showSnackBar(
          const SnackBar(
            content: Text('Please select an image to upload.'),
            backgroundColor: Colors.red, // Optional: to highlight the error
          ),
        );
        return;
      }
      final fileName = imageFile.name;
      final bytes = await imageFile.readAsBytes();
      final newBytes = await provider.compressImage(bytes);

      if (formKey.currentState!.validate()) {
        locationData = provider.selectedLocation;
        if (locationData != null && locationData!.contains(',')) {
          final latLng = locationData!
              .split(',')
              .map((e) => double.tryParse(e.trim()))
              .toList();
          double? latitude = latLng[0];
          double? longitude = latLng[1];

          if (latitude == null || longitude == null) {
            scaffoldMessengerState.showSnackBar(
              const SnackBar(
                content: Text('Something went wrong please try again'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            await provider.upload(
              newBytes,
              fileName,
              descriptionController.text,
              latitude,
              longitude,
            );
          }
        } else {
          scaffoldMessengerState.showSnackBar(
            const SnackBar(
              content: Text('Please select a location'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }

      if (provider.uploadResponse != null) {
        provider.setImageFile(null);
        provider.setImagePath(null);
      }
      scaffoldMessengerState.showSnackBar(
        SnackBar(content: Text(provider.message)),
      );
    }

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    foregroundImage: AssetImage('assets/avatar.png'),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Reyhan',
                    style: myTextTheme.headline4,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Add your picture and select your location',
                style: myTextTheme.subtitle2!.copyWith(
                  color: textDarkGrey,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  context.watch<StoryProvider>().imagePath == null
                      ? InkWell(
                          onTap: () {
                            onGalleryView();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(17),
                            width: 58,
                            decoration: BoxDecoration(
                              border: Border.all(color: textDarkGrey),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.upload_file_outlined,
                                color: textDarkGrey,
                              ),
                            ),
                          ),
                        )
                      : showImage(),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      selectLocation();
                      final pageManager = Provider.of<PageManager<String>>(
                          context,
                          listen: false);
                      locationData = await pageManager.waitForResult();
                      if (locationData!.isNotEmpty) {
                        provider.setLocationSelected(true, locationData!);
                      }
                      print('lokasi $locationData');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(17),
                      width: 58,
                      decoration: BoxDecoration(
                        border: Border.all(color: textDarkGrey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.location_on,
                          color: provider.isLocationSelected
                              ? primaryYellow2
                              : textDarkGrey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: textDarkGrey),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Type something here',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Harap masukkan caption anda';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    onUpload();
                  },
                  icon: context.watch<StoryProvider>().isUploading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.upload,
                          color: Colors.white,
                        ),
                  label: const Text(
                    'Upload Story',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
