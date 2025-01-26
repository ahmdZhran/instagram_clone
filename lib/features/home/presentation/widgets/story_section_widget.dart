import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StorySectionWidget extends StatelessWidget {
  const StorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 70.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  if (index == 0) {}
                },
                child: Stack(
                  children: [
                    Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/profile_image/post2.jpg'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    if (index == 0) 
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.w,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
