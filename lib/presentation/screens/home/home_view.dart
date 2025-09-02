import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';
import 'package:remedio_certeiro/core/states/state_handler.dart';
import 'package:remedio_certeiro/core/states/view_state_enum.dart';
import 'package:remedio_certeiro/presentation/screens/home/home_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/home/widgets/empty_medicine_widget.dart';
import 'package:remedio_certeiro/presentation/screens/home/widgets/medicine_hour_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchMedicineHours(isFirstFetch: true);
    });
  }

  void _retryFetch() {
    context.read<HomeViewModel>().fetchMedicineHours(isFirstFetch: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Texts.appName),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, Routes.profile),
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return StateHandler(
            state: viewModel.state,
            errorMessage: viewModel.errorMessage,
            onRetry: _retryFetch,
            emptyWidget: const EmptyMedicineWidget(),
            successWidget: _buildContent(viewModel),
            showLoadingOnTop: viewModel.isFirstLoad && viewModel.state == ViewStateEnum.loading,
          );
        },
      ),
    );
  }

  Widget _buildContent(HomeViewModel viewModel) {
    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            side: const BorderSide(color: Colors.yellow, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.transparent,
          ),
          onPressed: () => Navigator.pushNamed(context, Routes.myMedicineList),
          child: const Text(
            Texts.myMedicines,
            style: TextStyle(color: Colors.black),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<HomeViewModel>().fetchMedicineHours();
            },
            child: ListView.builder(
                itemCount: viewModel.medicineHours.length,
                itemBuilder: (context, index) {
                  final medicine = viewModel.medicineHours[index];
                  final int medicineId = medicine['id'];
                  final nextDoseTime = DateTime.parse(medicine['nextDoseTime']);
                  final uniqueKey = ValueKey('${medicineId}_${nextDoseTime.minute}');
                  return MedicineHourCard(
                    key: uniqueKey,
                    medicine: medicine,
                    isLoading: viewModel.loadingStates[medicineId] ?? false,
                    isRenewing: viewModel.renewingStates[medicineId] ?? false,
                    onDelete: () => viewModel.deleteMedicine(medicineId),
                    onRenew: () => viewModel.renewDosage(medicineId, medicine['name']),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
