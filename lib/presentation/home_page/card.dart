import 'package:flutter/material.dart';
import 'package:proj1/domain/models/card.dart';

class CardWidget extends StatefulWidget {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;

  const CardWidget(
      this.text, {
        super.key,
        this.icon = Icons.ac_unit_outlined,
        required this.descriptionText,
        this.imageUrl,
        this.onLike,
        this.onTap,
      });

  factory CardWidget.fromData(
      CardData data, {
        OnLikeCallback onLike,
        VoidCallback? onTap,
      }) =>
      CardWidget(
        data.text,
        descriptionText: data.descriptionText,
        icon: data.icon,
        imageUrl: data.imageUrl,
        onLike: onLike,
        onTap: onTap,
      );

  @override
    State<CardWidget> createState() => _CardState();
}
class _CardState extends State<CardWidget> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlueAccent.withOpacity(.5),
              spreadRadius: 1,
              offset: const Offset(0, 5),
              blurRadius: 5,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  width: 110,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          widget.imageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Placeholder(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          child: Text(
                            'кощко рингбе',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.descriptionText,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => isLiked = !isLiked);
                        widget.onLike?.call(widget.text, isLiked);
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isLiked
                            ? const Icon(Icons.favorite, color: Colors.blueGrey, key: ValueKey<int>(0))
                            : const Icon(Icons.favorite_border, key: ValueKey<int>(1)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}