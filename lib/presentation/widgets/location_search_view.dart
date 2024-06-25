import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/presentation/models/location.dart';
import 'package:flutter_weather/presentation/providers/locations.dart';

class LocationSearchView extends StatelessWidget {
  const LocationSearchView({super.key});

  @override
  Widget build(BuildContext context) => SearchAnchor(
        builder: (_, SearchController controller) =>
            LocationSearchBar(controller),
        viewBuilder: (Iterable<Widget> suggestions) =>
            suggestions.firstOrNull ?? const SizedBox(),
        suggestionsBuilder: (_, SearchController controller) => <Widget>[
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final AsyncValue<List<Location>> locationsValue =
                  ref.watch(locationsProvider(controller.text));
              return locationsValue.maybeMap(
                data: (AsyncData<List<Location>> data) => ListView(
                  children: data.value
                      .map((Location e) => LocationTile(
                            location: e,
                            searchController: controller,
                          ))
                      .toList(),
                ),
                error: (AsyncError<List<Location>> error) =>
                    Text(error.error.toString()),
                orElse: () => const Center(child: CircularProgressIndicator()),
              );
            },
          )
        ],
      );
}

class LocationSearchBar extends ConsumerWidget {
  final SearchController controller;

  const LocationSearchBar(this.controller, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchBar(
      controller: controller,
      onSubmitted: (_) => controller.openView(),
      onChanged: (_) => controller.openView(),
      leading: const Icon(Icons.search),
      trailing: <Widget>[
        AnimatedBuilder(
          animation: controller,
          builder: (_, __) => IconButton(
            onPressed: controller.text.isNotEmpty
                ? () {
                    ref.read(selectedLocationProvider.notifier).state = null;
                    controller.clear();
                  }
                : null,
            icon: const Icon(Icons.clear),
          ),
        )
      ],
    );
  }
}

class LocationTile extends ConsumerWidget {
  final SearchController searchController;
  final Location location;

  const LocationTile(
      {super.key, required this.location, required this.searchController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        searchController.closeView(location.title);
        ref.read(selectedLocationProvider.notifier).state = location;
      },
      title: Text(location.title),
    );
  }
}
