import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../../core/utls/text_styles.dart';
import '../custom_circular_avatar.dart';

class PostSectoin extends StatelessWidget {
  const PostSectoin({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 540.0,
      borderRadius: 25.0,
      linearGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.white.withOpacity(0.2),
        ],
      ),
      border: 0,
      blur: 20,
      borderGradient: const LinearGradient(
        colors: [Colors.pink, Colors.teal],
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                horizontalTitleGap: 10,
                dense: true,
                leading: const CustomCircularAvatar(
                  widthOfContainer: 40,
                  heightOfImage: 50,
                  widthOfImage: 50,
                  margin: EdgeInsets.all(2),
                ),
                title: Text(
                  'ahmed__21',
                  style: CustomTextStyles.normalTextStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('1 min'),
                trailing: const Icon(Icons.more_horiz),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 8.0,
                    ),
                  ],
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/profile_image/profile.png",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
