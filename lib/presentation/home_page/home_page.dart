import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj1/domain/models/card.dart';
import 'package:proj1/data/repositories/potter_repository.dart';
import 'package:proj1/presentation/details_page/details_page.dart';
import 'card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PotterRepository _repository = PotterRepository();
  final TextEditingController _searchController = TextEditingController();

  String? _searchQuery;

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
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<CardData>?>(
                future: _repository.loadData(q: _searchQuery),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    final data = snapshot.data!;
                    if (data.isEmpty) {
                      return const Text('Ничего не найдено');
                    }
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: data
                            .map(
                              (e) => CardWidget.fromData(
                            e,
                            onLike: (title, isLiked) => _showSnackBar(title, isLiked),
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
                    );
                  }
                  return const Text('Ошибка загрузки данных');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}