// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/models/post_model.dart';

class TagItem extends StatefulWidget {
  final PostTag tag;
  const TagItem({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  Color? _backgroundColor;
  Color? _textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _backgroundColor == null
              ? _backgroundColor = context.themeConfig.primaryColor
              : _backgroundColor = null;
          _textColor == null
              ? _textColor = context.themeConfig.onPrimaryTextColor
              : _textColor = null;
        });
      },
      style: ElevatedButton.styleFrom(
        textStyle: context.headlineSmall.copyWith(fontSize: 10.0),
        backgroundColor: _backgroundColor,
        foregroundColor: _textColor,
      ),
      child: Text(widget.tag.name),
    );
  }
}

class TagsSelection extends StatelessWidget {
  final void Function(List<PostTag>) updateTagsSelection;
  const TagsSelection({super.key, required this.updateTagsSelection});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags:',
          style: context.headlineSmall.copyWith(fontSize: 14.0),
        ),
        const SizedBox(height: 8.0),
        Builder(
          builder: (context) {
            final List<PostTag> tags = [];
            return SizedBox(
              height: 40.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  log('hehe');
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (tags.contains(existingTags[index])) {
                        tags.remove(existingTags[index]);
                      } else {
                        tags.add(existingTags[index]);
                      }
                      log(tags.toString());
                      updateTagsSelection(tags);
                    },
                    child: TagItem(
                      tag: existingTags[index],
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 4.0),
                itemCount: existingTags.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
