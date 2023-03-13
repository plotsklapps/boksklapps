import 'package:boksklapps/all_imports.dart';

class AboutScreenTablet extends StatelessWidget {
  const AboutScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: StringUtils.kAccount,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                0.0,
                24.0,
                24.0,
                0.0,
              ),
              child: Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <GetShitDoneWidget>[
                        GetShitDoneWidget(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const <Text>[
                                Text(
                                  'BOKSklapps is created by :plotsklapps using Flutter and Dart',
                                  style: TextStyleUtils.kBodyText,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            InkWell(
                              onTap: () async {
                                await launchURL(
                                  'https://github.com/plotsklapps/boksklapps',
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const <Text>[
                                  Text(
                                    'The app is open source and can be found on GitHub',
                                    style: TextStyleUtils.kBodyText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const <Text>[
                                Text(
                                  'BOKSklapps is and will forever be free,',
                                  style: TextStyleUtils.kBodyText,
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await launchURL(
                                  'https://www.buymeacoffee.com/plotsklapps',
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const <Text>[
                                  Text(
                                    'but a donation is very much appreciated',
                                    style: TextStyleUtils.kBodyText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const <Text>[
                                Text(
                                  'Special thanks go out to:',
                                  style: TextStyleUtils.kBodyText,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            InkWell(
                              onTap: () async {
                                await launchURL(
                                  'https://github.com/rrousselGit',
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const <Text>[
                                  Text(
                                    '@remi_rousselet for flutter_riverpod',
                                    style: TextStyleUtils.kBodyText,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await launchURL(
                                  'https://github.com/rydmike',
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const <Text>[
                                  Text(
                                    '@RydMike for flex_color_scheme',
                                    style: TextStyleUtils.kBodyText,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await launchURL('https://github.com/gskinner');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const <Text>[
                                  Text(
                                    '@gskinner for flutter_animate',
                                    style: TextStyleUtils.kBodyText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <ListTile>[
                            ListTile(
                              title: const Text('Version & Packages'),
                              leading: const Icon(Icons.info_outline),
                              onTap: () async {
                                await launchURL(
                                  'https://github.com/plotsklapps/boksklapps/blob/master/pubspec.yaml',
                                );
                              },
                            ),
                            ListTile(
                              title: const Text('Check out the source code'),
                              leading: const Icon(Icons.code),
                              onTap: () async {
                                await launchURL(
                                  'https://github.com/plotsklapps/boksklapps',
                                );
                              },
                            ),
                            ListTile(
                              title: const Text('Buy Me A Coffee'),
                              leading:
                                  const Icon(Icons.monetization_on_outlined),
                              onTap: () async {
                                await launchURL(
                                  'https://buymeacoffee.com/plotsklapps',
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
