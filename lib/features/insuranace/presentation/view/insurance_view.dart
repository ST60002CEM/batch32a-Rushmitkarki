import 'package:final_assignment/features/insuranace/presentation/viewmodel/insurance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InsuranceView extends ConsumerStatefulWidget {
  const InsuranceView({super.key});

  @override
  ConsumerState createState() => _InsuranceViewState();
}

class _InsuranceViewState extends ConsumerState<InsuranceView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(insuranceViewModelProvider.notifier).getInsurance(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insuranceState = ref.watch(insuranceViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Insurance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            insuranceState.isLoading
                ? CircularProgressIndicator()
                : insuranceState.error != null
                    ? Text(insuranceState.error ?? 'An error occured')
                    : Expanded(
                        child: ListView.builder(
                          itemCount: insuranceState.insurance.length,
                          itemBuilder: (context, index) {
                            final insurance = insuranceState.insurance[index];
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(insuranceViewModelProvider.notifier)
                                    .initializeKhalti(
                                        insurance.insuranceid ?? '',
                                        insurance.insurancePrice);
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  // height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Name: ${insurance.insuranceName}'),
                                      Text(
                                          'description: ${insurance.insuranceDescription}'),
                                      Text(
                                          'price: ${insurance.insurancePrice}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
