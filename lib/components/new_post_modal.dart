import 'package:flutter/material.dart';
import 'package:gisscope/components/app_text_field.dart';
import 'package:gisscope/provider/app_repo.dart';
import 'package:gisscope/provider/post_provider.dart';
import 'package:gisscope/styles/app_colors.dart';
import 'package:gisscope/styles/app_text.dart';
import 'package:provider/provider.dart';

class NewPostModal extends StatelessWidget {
  const NewPostModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          )),
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Insert Message',
            style: AppText.headerSemibold,
          ),
          SizedBox(
            height: 16,
          ),
          AppTextField(
            hint: "Message",
            onChange: (value) {
              context.read<PostProvider>().message = value;
            },
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Add Image',
            style: AppText.headerSemibold,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Center(
              child: Text("Upload from gallery"),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Or",
            style: AppText.headerSemibold,
          ),
          SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            child: Text(
              "Camera",
              style: AppText.body1,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<PostProvider>()
                  .createPost(context.read<AppRepo>().token!)
                  .then((value) => Navigator.of(context).pop());
            },
            child: Text(
              "Upload Post",
              style: AppText.body1,
            ),
          ),
        ],
      ),
    );
  }
}
