import 'dart:developer' as devtools;

import 'package:anywhere_mobile/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  static final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    devtools.log('rebuild');
    final searchEnabled = context.select((HomeCubit cubit) => cubit.state.searchEnabled);
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: searchEnabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            SearchBar(
              controller: _controller,
              elevation: MaterialStateProperty.all(.5),
              leading: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              trailing: [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    context.read<HomeCubit>().clearSearch();
                  },
                ),
              ],
              onChanged: (query) {
                context.read<HomeCubit>().searchCharacters(query);
              },
            ),
          ],
        ),
      ),
      secondChild: const SizedBox.shrink(),
    );
  }
}
