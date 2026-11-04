import 'package:flutter/material.dart';
import 'package:proj1/domain/models/card.dart';

class CardWidget extends StatefulWidget {
  final CardData data;
  final Function(String title, bool isLiked) onLike;
  final VoidCallback onTap;

  const CardWidget({
    super.key,
    required this.data,
    required this.onLike,
    required this.onTap,
  });

  factory CardWidget.fromData(
      CardData data, {
        required Function(String title, bool isLiked) onLike,
        required VoidCallback onTap,
      }) {
    return CardWidget(
      data: data,
      onLike: onLike,
      onTap: onTap,
    );
  }

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.5)),
      ),
      child: InkWell(
        onTap: widget.onTap,
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
                  child: widget.data.imageUrl != null
                      ? Image.network(
                    widget.data.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 50),
                  )
                      : const Icon(Icons.person, size: 50),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.data.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.data.descriptionText.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.data.descriptionText,
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
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.blueGrey : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                  widget.onLike(widget.data.text, _isLiked);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}