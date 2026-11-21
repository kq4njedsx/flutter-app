import 'package:flutter/material.dart';
import 'package:proj1/data/repositories/api_interface.dart';
import 'package:proj1/domain/models/card.dart';
import 'package:proj1/domain/models/home.dart';

class MockRepository extends ApiInterface {
  @override
  Future<HomeData?> loadData({Function(String?)? onError, String? q, int page = 1}) async {
    return HomeData(
      nextPage: null,
      data: [
        CardData(
          'snowflke',
          descriptionText: 'weeeee',
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR24Vqd3aHMIT9M1z88m1x5qDegNWLXZFsFohpgsE0CZiN6npFk3Jb8&s=10',
          detailsImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLYQhiozBVFvnyW6IIapf4lhVrr2HZHba1WB--L-6IWx-Vs_GbwtZ_9x_S',
          detailsText: "i'm rigbe ye car",
        ),
        CardData(
          'Hi.',
          descriptionText: 'hiiiiii',
          icon: Icons.hail,
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3pVwVls6qCIW7AwQTjr9KZd1dzZJDh_86gT-ckJ3ARSRBPAEAnMc&s=10',
          detailsImageUrl: 'https://media.tenor.com/_sIZvkcIW@wAAAAM/rigbycat-rigby.gif',
          detailsText: 'break',
        ),
      ],
    );
  }
}
