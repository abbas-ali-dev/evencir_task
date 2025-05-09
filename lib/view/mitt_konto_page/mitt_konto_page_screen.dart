import 'package:evencir_task/constants/text_styles.dart';
import 'package:flutter/material.dart';

class MittKontoPageScreen extends StatelessWidget {
  const MittKontoPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Mitt konto',
                style: AppTextStyles.headingPlayfair,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Abbas Ali',
                        style: AppTextStyles.subHeadingPoppins
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        'myname@gmail.com',
                        style: AppTextStyles.subHeadingPoppins
                            .copyWith(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        '07XXXXXXXX',
                        style: AppTextStyles.subHeadingPoppins
                            .copyWith(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Kontoinstallningar',
                style: AppTextStyles.bodyPoppins,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text(
                'Mina betalmetoder',
                style: AppTextStyles.bodyPoppins,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text(
                'Support',
                style: AppTextStyles.bodyPoppins,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
