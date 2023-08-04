import 'package:anywhere_mobile/features/details/cubit/details_cubit.dart';
import 'package:character_repository/character_repository.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart' show FastCachedImage, FastCachedImageConfig;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final character = context.read<DetailsCubit>().character;
    final description = character.description.split('-').length > 1
        ? character.description.split('-')[1].trim()
        : character.description;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          character.title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const _CharacterImage(),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 0,
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            description,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CharacterImage extends StatelessWidget {
  const _CharacterImage();

  @override
  Widget build(BuildContext context) {
    final baseUrl = context.read<ICharacterRepository>().baseUrl;
    final character = context.read<DetailsCubit>().character;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 0,
          child: Container(
            constraints: BoxConstraints(
              minHeight: 200,
              maxHeight: 250,
              minWidth: constraints.maxWidth,
            ),
            child: character.image.isNotEmpty
                ? FastCachedImage(
                    url: '$baseUrl${character.image}',
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 100),
                    loadingBuilder: (context, progress) {
                      if (FastCachedImageConfig.isCached(imageUrl: '$baseUrl${character.image}')) {
                        return const SizedBox.shrink();
                      }

                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    },
                  )
                : const _NoImage(),
          ),
        );
      },
    );
  }
}

class _NoImage extends StatelessWidget {
  const _NoImage();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.account_circle,
          size: 120,
        ),
        Text('No Image Available')
      ],
    );
  }
}
