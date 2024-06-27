import 'package:final_assignment/features/home/presentation/view/bottom_view/chat_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/explore_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/search_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int selectedIndex = 0;
  List<Widget> lstScreen = [
    const DashboardView(),
    const ExploreView(),
    const SearchView(),
    const ChatView(),
    const ProfileView(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstScreen[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildNavItem(Icons.home, "Home", 0),
              _buildNavItem(Icons.calendar_month_outlined, "Appointment", 1),

              const SizedBox(width: 48), // Space for the FAB
              _buildNavItem(Icons.chat, "Chat", 3),
              _buildNavItem(Icons.person, "Profile", 4),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onItemTapped(2);
        },
        child: const Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: selectedIndex == index ? Colors.blue : Colors.grey),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
