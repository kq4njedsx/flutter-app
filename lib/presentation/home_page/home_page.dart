import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/components/extensions/context_x.dart';
import 'package:proj1/components/utils/debounce.dart';
import 'package:proj1/presentation/common/svg_objects.dart';
import 'package:proj1/presentation/details_page/details_page.dart';
import 'package:proj1/presentation/home_page/bloc/bloc.dart';
import 'package:proj1/presentation/home_page/bloc/events.dart';
import 'package:proj1/presentation/home_page/bloc/state.dart';
import 'package:proj1/presentation/home_page/like_bloc/like_bloc.dart';
import 'package:proj1/presentation/home_page/like_bloc/like_event.dart';
import 'package:proj1/presentation/home_page/like_bloc/like_state.dart';
import 'package:proj1/presentation/home_page/locale_bloc/locale_bloc.dart';
import 'package:proj1/presentation/home_page/locale_bloc/locale_events.dart';
import 'package:proj1/presentation/home_page/locale_bloc/locale_state.dart';

import 'card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: Body()));
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SvgObjects.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
      context.read<LikeBloc>().add(const LoadLikesEvent());
    });

    scrollController.addListener(_onNextPageListener);
  }

  void _onNextPageListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.9) {
      final bloc = context.read<HomeBloc>();
      if (!bloc.state.isPaginationLoading && bloc.state.data?.nextPage != null) {
        bloc.add(
          HomeLoadDataEvent(
            search: searchController.text,
            nextPage: bloc.state.data?.nextPage,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$title ${isLiked ? context.locale.liked : context.locale.disliked}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          backgroundColor: Colors.lightBlueAccent,
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  void _onLike(String? id, String title, bool isLiked) {
    if (id != null) {
      context.read<LikeBloc>().add(ChangeLikeEvent(id));
      _showSnackBar(context, title, !isLiked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CupertinoSearchTextField(
                  controller: searchController,
                  placeholder: context.locale.search,
                  onChanged: (search) {
                    Debounce.run(() {
                      context.read<HomeBloc>().add(
                        HomeLoadDataEvent(search: search),
                      );
                    });
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () =>
                  context.read<LocaleBloc>().add(const ChangeLocaleEvent()),
              child: SizedBox.square(
                dimension: 50,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: BlocBuilder<LocaleBloc, LocaleState>(
                    builder: (context, state) {
                      return state.currentLocale.languageCode == 'ru'
                          ? const SvgRu()
                          : const SvgUk();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.error != null) {
                  return Text(
                    state.error ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: Colors.red),
                  );
                }

                if (state.isLoading) {
                  return const CircularProgressIndicator();
                }

                final homeData = state.data;
                if (homeData == null || homeData.data == null) {
                  return const CircularProgressIndicator();
                }

                final characters = homeData.data!;
                if (characters.isEmpty) {
                  return const Text('Ничего не найдено');
                }

                return BlocBuilder<LikeBloc, LikeState>(
                  builder: (context, likeState) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<HomeBloc>().add(
                          HomeLoadDataEvent(search: searchController.text),
                        );
                        return Future.value();
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        itemCount: characters.length,
                        itemBuilder: (context, index) {
                          final item = characters[index];
                          return CardWidget.fromData(
                            item,
                            isLiked:
                            likeState.likedIds?.contains(item.id) == true,
                            onLike: _onLike,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(data: item),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => state.isPaginationLoading
              ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}