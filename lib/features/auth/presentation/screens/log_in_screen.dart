import 'package:flutter/material.dart';
import '../../../../core/widgets/padding_wrapper_widget.dart';
import '../../widgets/login_screen_styles.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: PaddingWrapperWidget(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: HeadInstagramTitle(), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
