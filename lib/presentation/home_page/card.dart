import 'package:flutter/material.dart';
import 'package:proj1/domain/models/card.dart';

class CardWidget extends StatelessWidget {
  final CardData data;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;
  final bool isLiked;

  const CardWidget({
    super.key,
    required this.data,
    this.onLike,
    this.onTap,
    this.isLiked = false,
  });

  factory CardWidget.fromData(
      CardData data, {
        OnLikeCallback onLike,
        VoidCallback? onTap,
        bool isLiked = false,
      }) {
    return CardWidget(
      data: data,
      onLike: onLike,
      onTap: onTap,
      isLiked: isLiked,
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = data.imageUrl?.trim();
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.5)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: SizedBox(
                  width: 100,
                  child: hasImage
                      ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('IMAGE ERR [$imageUrl]: $error');
                      return const Icon(Icons.person, size: 50);
                    },
                  )
                      : const Icon(Icons.person, size: 50),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (data.descriptionText.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          data.descriptionText,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.blueGrey : Colors.black,
                ),
                onPressed: () {
                  onLike?.call(data.id, data.text, isLiked);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}