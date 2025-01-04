import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/widgets/custom_text_form_field.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../../domain/entities/comment_entity/comment_entity.dart';

class CommentActionsBottomSheetWidget extends StatelessWidget {
  final CommentEntity comment;
  final VoidCallback onDelete;
  final Function(String) onEdit;
  const CommentActionsBottomSheetWidget({
    super.key,
    required this.comment,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.edit, color: AppColors.primaryColor),
          title: Text(context.translate(AppStrings.edit)),
          onTap: () {
            _showEditDialog(context, comment.commentText).then((value) {
              if (value != null) {
                onEdit(value);
              }
            });
          },
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

  Future<String?> _showEditDialog(BuildContext context, String initialText) {
    final TextEditingController controller =
        TextEditingController(text: initialText);

    return showDialog<String>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 20,
          child: AlertDialog(
            title: Text(context.translate(AppStrings.editComment),
                style: CustomTextStyle.pacifico14),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: context.translate(
                  AppStrings.enterYourUpdatedComment,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: Text(context.translate(AppStrings.cancel)),
              ),
              TextButton(
                //TOdO refactor this pop method from extension to make it accept params
                onPressed: () => Navigator.pop(context, controller.text),
                child: Text(context.translate(AppStrings.save)),
              ),
            ],
          ),
        );
      },
    );
  }
}
