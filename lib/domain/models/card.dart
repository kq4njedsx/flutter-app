import 'package:flutter/material.dart';

typedef OnLikeCallback = void Function(String title, bool isLiked)?;

class CardData {
  final String text;
  final String descriptionText;
  final String detailsText;
  final IconData icon;
  final String? imageUrl;
  final String? detailsImageUrl;

  CardData(
      this.text, {
        required this.descriptionText,
        required this.detailsText,
        this.icon = Icons.ac_unit_outlined,
        this.imageUrl,
        this.detailsImageUrl,
      });
}