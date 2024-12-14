import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../../domain/entities/comment_entity/comment_entity.dart';

class CommentActionsBottomSheetWidget extends StatelessWidget {
  final CommentEntity comment;
  final VoidCallback onDelete;

  const CommentActionsBottomSheetWidget(
      {super.key, required this.comment, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.edit, color: AppColors.primaryColor),
          title: Text(context.translate(AppStrings.edit)),
          onTap: () => context.pop(),
        ),
        ListTile(
          leading: const Icon(Icons.delete, color: Colors.red),
          title: Text(context.translate(AppStrings.delete)),
          onTap: () async {
            Navigator.pop(context);
            final confirm = await _confirmDelete(context);
            if (confirm == true) {
              onDelete();
            }
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.cancel, color: AppColors.greyColor),
          title: Text(context.translate(AppStrings.cancel)),
          onTap: () => context.pop(),
        ),
      ],
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.translate(AppStrings.deleteComment),
            style: CustomTextStyle.pacifico14),
        content: Text(context.translate(AppStrings.areYourSureToDeleteCo)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.translate(AppStrings.cancel))),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.translate(AppStrings.delete),
                style: CustomTextStyle.pacifico14
                    .copyWith(color: AppColors.redColor)),
          ),
        ],
      ),
    );
  }
}
