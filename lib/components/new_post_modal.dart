import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gisscope/components/app_text_field.dart';
import 'package:gisscope/config/app_strings.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/post_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:gisscope/styles/app_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewPostModal extends StatelessWidget {
  const NewPostModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          )),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            AppStrings.insertMessage,
            style: AppText.headerSemibold,
          ),
          const SizedBox(
            height: 16,
          ),
          AppTextField(
            hint: AppStrings.message,
            onChange: (value) {
              context.read<PostProvider>().message = value;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            AppStrings.addImage,
            style: AppText.headerSemibold,
          ),
          const SizedBox(
            height: 16,
          ),
          Consumer<PostProvider>(
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  context.read<PostProvider>().pickImage(ImageSource.gallery);
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.white,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: value.imagePath == null
                      ? const Center(
                          child: Text(
                            AppStrings.uploadFromGallery,
                            style: AppText.body1,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          child: Stack(
                            children: [
                              Image.file(
                                File(value.imagePath!),
                              ),
                              IconButton(
                                  onPressed: () {
                                    value.deleteImage();
                                  },
                                  icon: const Icon(
                                    Icons.highlight_remove,
                                    color: AppColors.white,
                                  ))
                            ],
                          ),
                        ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            AppStrings.or,
            style: AppText.headerSemibold,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.white,
              side: const BorderSide(width: 2, color: AppColors.white),
            ),
            onPressed: () {
              context.read<PostProvider>().pickImage(ImageSource.camera);
            },
            child: const Text(
              AppStrings.camera,
              style: AppText.body1,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.black,
            ),
            onPressed: () {
              context
                  .read<PostProvider>()
                  .createPost(context.read<AppRepo>().token!)
                  .then((value) => Navigator.of(context).pop());
            },
            child: const Text(
              AppStrings.uploadPost,
              style: AppText.body1,
            ),
          ),
        ],
      ),
    );
  }
}
