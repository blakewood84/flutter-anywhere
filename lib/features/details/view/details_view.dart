import 'package:anywhere_mobile/features/details/cubit/details_cubit.dart';
import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final character = context.read<DetailsCubit>().character;
    final baseUrl = context.read<ICharacterRepository>().baseUrl;

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
                    Card(
                      elevation: 0,
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: 200,
                          maxHeight: 250,
                          minWidth: constraints.maxWidth,
                        ),
                        child: character.image.isNotEmpty
                            ? Image.network(
                                '$baseUrl${character.image}',
                                fit: BoxFit.contain,
                              )
                            : const _NoImage(),
                      ),
                    ),
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
