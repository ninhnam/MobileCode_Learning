import 'package:flutter/material.dart';
import 'package:local_event_app/app_state.dart';
import 'package:local_event_app/model/event.dart';
import 'package:local_event_app/styleguide.dart';
import 'package:provider/provider.dart';

import '../../model/category.dart';
import '../event_details/event_details_page.dart';
import 'category_widget.dart';
import 'event_widget.dart';
import 'home_page_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Stack(
          children: [
            HomePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      children: [
                        Text(
                          "LOCAL EVENTS",
                          style: fadedTextStyle,
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.person_outline,
                          color: Color(0x99FFFFFF),
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      "What's Up",
                      style: whiteHeadingTextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Consumer<AppState>(
                        builder: (context, appState, _) =>
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (final category in categories)
                                    CategoryWidget(category: category)
                                ],
                              ),
                            )),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [Consumer<AppState>(
                            builder: (context, appState, _) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (final event in events.where((e) => e
                                    .categoryIds
                                    .contains(appState.selectedCategoryId)))
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>
                                                EventDetailsPage(event: event)));
                                      },
                                      child: EventWidget(event: event))
                              ],
                            ))],
                      ),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
