import 'package:final_assignment/features/home/presentation/view/dashboard_view.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

    final lstViews = [
      const DashboardView(),
      const SizedBox.expand(
        child: Center(
          child: Text(
            'Booking',
          ),
        ),
      ),
      const SizedBox.expand(
        child: Center(
          child: Text(
            'Batch',
          ),
        ),
      ),
      const SizedBox.expand(
        child: Center(
          child: Text(
            'Profile ',
          ),
        ),
      )
    ];
    return Scaffold(
      body: lstViews[homeState],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Calander',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: homeState,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        onTap: (index) {
          ref.read(homeViewModelProvider.notifier).changeIndex(index);
        },
      ),
    );
  }
}
