import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  List<Doctor> _doctors = [];
  List<Doctor> _filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some dummy data using asset images
    _doctors = [
      Doctor(
          name: "Dr. John Doe",
          speciality: "Cardiologist",
          imagePath: "assets/images/doctor4.jpeg"),
      Doctor(
          name: "Dr. Jane Smith",
          speciality: "Pediatrician",
          imagePath: "assets/images/doctor2.jpg"),
      Doctor(
          name: "Dr. Mike Johnson",
          speciality: "Neurologist",
          imagePath: "assets/images/doctor3.jpeg"),
    ];
    _filteredDoctors = _doctors;
  }

  void _filterDoctors(String query) {
    setState(() {
      _filteredDoctors = _doctors
          .where((doctor) =>
              doctor.name.toLowerCase().contains(query.toLowerCase()) ||
              doctor.speciality.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Doctors'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Doctors',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterDoctors,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = _filteredDoctors[index];
                return MyCard(
                  title: doctor.name,
                  subtitle: doctor.speciality,
                  imagePath: doctor.imagePath,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Doctor {
  final String name;
  final String speciality;
  final String imagePath;

  Doctor(
      {required this.name, required this.speciality, required this.imagePath});
}

class MyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const MyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (imagePath.isNotEmpty)
            Image.assets(
              imagePath,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
          ),
        ],
      ),
    );
  }
}
