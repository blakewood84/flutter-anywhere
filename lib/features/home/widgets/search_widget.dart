import 'package:anywhere_mobile/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchEnabled = context.select((HomeCubit cubit) => cubit.state.searchEnabled);
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: searchEnabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            SearchBar(
              leading: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              elevation: MaterialStateProperty.all(.5),
              onChanged: (value) {
                context.read<HomeCubit>().searchCharacters(value);
              },
            ),
          ],
        ),
      ),
      secondChild: const SizedBox.shrink(),
    );
  }
}
