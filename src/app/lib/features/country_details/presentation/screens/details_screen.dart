import 'package:flutter/material.dart';
import '../../../../shared/models/country.dart';
import '../widgets/details_body.dart';

class DetailsScreen extends StatelessWidget {
  final Country country;

  const DetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 700 ? 24.0 : 20.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                16,
                horizontalPadding,
                20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: DetailsBody(
                    country: country,
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
