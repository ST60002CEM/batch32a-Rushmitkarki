import 'package:final_assignment/screen/buttom_screen/calender_screen.dart';
import 'package:final_assignment/screen/buttom_screen/home_screen.dart';
import 'package:final_assignment/screen/buttom_screen/profile_screen.dart';
import 'package:final_assignment/screen/buttom_screen/search_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    const Homescreen(),
    const SearchScreen(),
    const ProfileScreen(),
    const CalenderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 12, 41, 91),
      ),
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          // if you want to change the color of the bottom navigation bar or add more icons
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: 'calender'),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}




































// import 'package:flutter/material.dart';


// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Dashboard',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 12, 41, 91),
//         elevation: 0.0,
//       ),
//       body:  lstBottomScreen[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//           // if you want to change the color of the bottom navigation bar or add more icons
//           type: BottomNavigationBarType.fixed,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.shopping_bag), label: 'cart'),
//           ],
//           currentIndex: _selectedIndex,
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           }),
//       // body: const Column(
//       //     // children: <Widget>[
//       //     //   Center(
//       //     //     // Wrap the Image.asset with Center
//       //     //     child: Image.asset(
//       //     //       'assets/images/logo.png',
//       //     //       width: 100.0,
//       //     //       height: 100.0,
//       //     //     ),
//       //     //   ),
//       //     //   const Expanded(
//       //     //     child: Padding(
//       //     //       padding: EdgeInsets.all(20.0),
//       //     //       child: SingleChildScrollView(
//       //     //         child: Column(
//       //     //           mainAxisAlignment: MainAxisAlignment.center,
//       //     //           children: <Widget>[
//       //     //             Text(' Welcome  to Dashboard Screen'),
//       //     //           ],
//       //     //         ),
//       //     //       ),
//       //     //     ),
//       //     //   ),
//       //     // ],
//       //     ));
//     );
//   }
// }
