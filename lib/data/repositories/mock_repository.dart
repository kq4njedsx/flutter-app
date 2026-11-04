import 'package:flutter/material.dart';
import 'package:proj1/domain/models/card.dart';
import 'api_interface.dart';

class MockRepository extends ApiInterface {
  @override
  Future<List<CardData>?> loadData({String? q}) async {

    return [
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
  }
}