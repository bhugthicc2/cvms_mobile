import 'package:cvms_mobile/core/widgets/custom_banner_toast.dart';
import 'package:flutter/material.dart';

// Assuming you converted your snack bar to a helper:

class TestSnackbarPage extends StatelessWidget {
  const TestSnackbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test SnackBar')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            BannerToast.show(
              context,
              message: 'Toast test',
              type: BannerToastType.success,
            );
          },
          child: const Text('Show Custom SnackBar'),
        ),
      ),
    );
  }
}
