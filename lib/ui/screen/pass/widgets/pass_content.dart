import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/models/pass_model.dart';
import 'package:ux_final_project/ui/screen/pass/view_model/pass_view_model.dart';
import 'package:ux_final_project/ui/screen/pass/widgets/active_pass_view.dart';
import 'package:ux_final_project/ui/screen/pass/widgets/error_state.dart';
import 'package:ux_final_project/ui/screen/pass/widgets/purchase_view.dart';
import 'package:ux_final_project/ui/utils/async_value.dart';


class PassContent extends StatefulWidget {
  const PassContent({super.key});

  @override
  State<PassContent> createState() => _PassContentState();
}

class _PassContentState extends State<PassContent> {
  PassType _selectedPass = PassType.day;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<PassViewModel>().fetchPassData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PassViewModel>();
    final passValue = viewModel.passValue;
    final plans = viewModel.passPlans;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F0E1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: switch (passValue.state) {
            AsyncValueState.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            AsyncValueState.error => ErrorState(
              onRetry: () => context.read<PassViewModel>().fetchPassData(),
            ),
            AsyncValueState.success =>
              passValue.data != null
                  ? ActivePassView(
                      pass: passValue.data!,
                      passLabel: viewModel.planFor(passValue.data!.type).title,
                      onCancel: () =>
                          context.read<PassViewModel>().cancelPass(),
                    )
                  : PurchaseView(
                      plans: plans,
                      selectedPass: _selectedPass,
                      onSelectedPassChanged: (passType) {
                        setState(() {
                          _selectedPass = passType;
                        });
                      },
                      onConfirm: () =>
                          context.read<PassViewModel>().buyPass(_selectedPass),
                    ),
          },
        ),
      ),
    );
  }
}
