import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/home/presentation/view/mycard.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/doctor_view_model.dart';
import 'package:final_assignment/features/search/presentation/viewmodel/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        ref.read(searchViewModelProvider.notifier).resetState();
      }
    });

    // Fetch doctors initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchViewModelProvider.notifier).fetchDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchViewModelProvider);
    final searchViewModel = ref.watch(searchViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Doctors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final query = await showSearchDialog(context, (value) {
                ref
                    .read(searchViewModelProvider.notifier)
                    .searchDoctors(query: value);
              });
              if (query != null) {
                searchViewModel.searchDoctors(query: query);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () async {
              final sortOrder = await showSortDialog(context);
              if (sortOrder != null) {
                searchViewModel.searchDoctors(sortOrder: sortOrder);
              }
            },
          ),
        ],
      ),
      body: searchState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : searchState.error.isNotEmpty
              ? Center(child: Text('Error: ${searchState.error}'))
              : GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: searchState.doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = searchState.doctors[index];
                    return MyCard(
                      title: doctor.doctorName,
                      subtitle: doctor.doctorField,
                      imageUrl:
                          '${ApiEndPoints.doctorImageUrl}${doctor.doctorImage}',
                      onFavoritePressed: () {
                        ref
                            .read(doctorViewModelProvider.notifier)
                            .favorite(doctor.doctorid);
                      },
                    );
                  },
                ),
    );
  }

  Future<String?> showSearchDialog(
    BuildContext context,
    Function(String) onChanged,
  ) async {
    final TextEditingController searchController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'Enter doctor name'),
            controller: searchController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref
                    .read(searchViewModelProvider.notifier)
                    .searchDoctors(query: searchController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  Future<String?> showSortDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('low price'),
                onTap: () {
                  Navigator.of(context).pop('asc');
                },
              ),
              ListTile(
                title: const Text('high price'),
                onTap: () {
                  Navigator.of(context).pop('desc');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
