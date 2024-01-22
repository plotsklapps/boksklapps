import 'package:boksklapps/theme/text_utils.dart';
import 'package:flutter/material.dart';

// This is the Widget used in the TutorialScreen to display the punch.
// They are clickable and will display a modal bottom sheet with a short
// description and the punch name, number, and 'how to' GIF.

class PunchGlove extends StatelessWidget {
  const PunchGlove({
    required this.punchNumber,
    required this.punchName,
    required this.punchGIF,
    required this.punchPNG,
    super.key,
  });

  final String punchNumber;
  final String punchName;
  final String punchGIF;
  final String punchPNG;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<Widget>(
          showDragHandle: true,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.96,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      punchName,
                      style: TextUtils.fontXL,
                    ),
                    const Divider(thickness: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.asset(
                                punchGIF,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    punchPNG,
                                    height: 64,
                                    width: 64,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    punchNumber,
                                    style: TextUtils.fontXXL,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: SizedBox(
        height: 48,
        width: 48,
        child: Image.asset(punchPNG),
      ),
    );
  }
}
