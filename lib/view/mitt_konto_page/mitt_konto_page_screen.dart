import 'package:evencir_task/constants/text_styles.dart';
import 'package:flutter/material.dart';

class MittKontoPageScreen extends StatelessWidget {
  const MittKontoPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Mitt konto',
            style: AppTextStyles.headingPlayfair,
          ),
        ),
      ),
    );
  }
}
