import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dashboard View'),
            const Spacer(),
            // Reload button
            IconButton(
              onPressed: () {
                showMySnackBar(message: 'Refreshing...');
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Dashboard View')),
    );
  }
}
