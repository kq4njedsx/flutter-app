import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'flutter is kinda based'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color _color = Colors.lightBlueAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(widget.title),
      ),
      body: const MyWidget(),

    );
  }
}

class _CardData{
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  _CardData(
      this.text, {
      required this.descriptionText,
      this.icon = Icons.ac_unit_outlined,
      this.imageUrl,
  });
}

class MyWidget extends StatelessWidget{
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context){
    final data = [
      _CardData(
          'snowflke',
          descriptionText: 'weeeee',
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS24Vqd3aHMiT9M1z88m1x5qDegNWLXZFsFohpgsEOCZiN6npNnOOfk3Jb8&s=10',
      ),
      _CardData(
          'Hi.',
          descriptionText: 'hiiiiiii',
          icon: Icons.hail,
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3pVwVLs6qIQd7AwQTjr5STZ9kZdldzZJDh_86gT-ckJ3ARSRBPAeANmc&s=10',
      ),
      _CardData(
          'achtung',
          descriptionText: 'waaa',
          icon: Icons.warning,
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR50ZIXd30xGPlZTwEPDP76d-I5rd0pjUDGYjN22GemeIUBtWuRkzUmeBKW&s=10',
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((e) => _Card.fromData(e)).toList(),
        ),
      )
    );
  }
}

class _Card extends StatelessWidget {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  const _Card(
      this.text, {
      this.icon = Icons.ac_unit_outlined,
      required this.descriptionText,
      this.imageUrl,
  });
  factory _Card.fromData(_CardData data) => _Card(
    data.text,
    descriptionText: data.descriptionText,
    icon: data.icon,
    imageUrl: data.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:16),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 2,),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlueAccent.withOpacity(.5),
            spreadRadius: 1,
            offset: const Offset(0, 5),
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 140,
                width: 100,
                child: Image.network(
                    imageUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_,__,___) => const Placeholder(),
                ),
              ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    descriptionText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(icon),
          ),
        ],
      ),
    );
  }
}