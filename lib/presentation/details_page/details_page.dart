import 'package:flutter/material.dart';
import '../../domain/models/card.dart';

class DetailsPage extends StatelessWidget {
  final CardData data;

  const DetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final String imageToShow = data.detailsImageUrl ?? data.imageUrl ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(data.text),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  imageToShow,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Placeholder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      data.text,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Text(
                    data.detailsText,
                    style: Theme.of(context).textTheme.bodyLarge,
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