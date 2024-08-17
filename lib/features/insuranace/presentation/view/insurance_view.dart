import 'package:final_assignment/app/constants/api_endpoint.dart';
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
  Widget build(BuildContext context) {
    final insuranceState = ref.watch(insuranceViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Insurance Plans'),
        elevation: 0,
      ),
      body: insuranceState.isLoading
          ? Center(child: CircularProgressIndicator())
          : insuranceState.error != null
              ? Center(child: Text(insuranceState.error ?? 'An error occurred'))
              : _buildInsuranceList(insuranceState),
    );
  }

  Widget _buildInsuranceList(insuranceState) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: insuranceState.insurance.length,
      itemBuilder: (context, index) {
        final insurance = insuranceState.insurance[index];
        return _buildInsuranceCard(insurance);
      },
    );
  }

  Widget _buildInsuranceCard(insurance) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          ref.read(insuranceViewModelProvider.notifier).initializeKhalti(
                insurance.insuranceid ?? '',
                insurance.insurancePrice,
              );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              child: Image.network(
                ApiEndPoints.insuranceImageUrl +
                    (insurance.insuranceImage ?? ''),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insurance.insuranceName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    insurance.insuranceDescription,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price: \$${insurance.insurancePrice}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(insuranceViewModelProvider.notifier)
                              .initializeKhalti(
                                insurance.insuranceid ?? '',
                                insurance.insurancePrice,
                              );
                        },
                        child: Text('Select Plan'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
