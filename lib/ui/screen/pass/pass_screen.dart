import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_final_project/data/repositories/pass/pass_repository.dart';
import 'package:ux_final_project/ui/screen/pass/view_model/pass_view_model.dart';
import 'package:ux_final_project/ui/screen/pass/widgets/pass_content.dart';
import 'package:ux_final_project/ui/state/user_pass_state.dart';



class PassScreen extends StatelessWidget {
  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PassViewModel(
        passRepository: context.read<PassRepository>(),
        userPassState: context.read<UserPassState>()
      ),
      child:  PassContent(),
    );
  }
}
