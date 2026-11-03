import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj1/domain/models/card.dart';
import 'package:proj1/presentation/details_page/details_page.dart';
import 'card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color _color = Colors.lightBlueAccent;

  void _showSnackBar(String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'лайк карточке $title ${isLiked ? 'поставлен' : 'не поставлен -_-'}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          backgroundColor: Colors.lightBlueAccent,
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = [
      CardData(
        'snowflke',
        descriptionText: 'weeeee',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS24Vqd3aHMiT9M1z88m1x5qDegNWLXZFsFohpgsEOCZiN6npNnOOfk3Jb8&s=10',
        detailsImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYQhiozBVFvnyW6IIapf4lhVnrR2HZHba1BwR--L-6Iwx-Vs_cbwtK5w&s=10',
        detailsText: "i'm rigbe ye car",
      ),
      CardData(
        'Hi.',
        descriptionText: 'hiiiiiii',
        icon: Icons.hail,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3pVwVLs6qIQd7AwQTjr5STZ9kZdldzZJDh_86gT-ckJ3ARSRBPAeANmc&s=10',
        detailsImageUrl: 'https://media.tenor.com/_sIZvkcIW0wAAAAM/rigbycat-rigby.gif',
        detailsText: 'ultimate bathroom break',
      ),
      CardData(
        'achtung',
        descriptionText: 'waaa',
        icon: Icons.warning,
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR50ZIXd30xGPlZTwEPDP76d-I5rd0pjUDGYjN22GemeIUBtWuRkzUmeBKW&s=10',
        detailsImageUrl: 'https://i.pinimg.com/236x/eb/84/ce/eb84ce23a2e7ff5cda719cf4d569b983.jpg',
        detailsText: 'swag',
      ),
    ];

    return Scaffold(
      appBar: AppBar(backgroundColor: _color, title: Text(widget.title)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: data
                .map(
                  (e) => CardWidget.fromData(
                e,
                onLike: (title, isLiked) => _someActionOrSnackBar(title, isLiked), // подставь свой _showSnackBar
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(data: e),
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
  }

  void _someActionOrSnackBar(String title, bool isLiked) {
    _showSnackBar(title, isLiked);
  }
}