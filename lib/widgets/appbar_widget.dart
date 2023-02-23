import 'package:boksklapps/all_imports.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: <IconButton>[
        IconButton(
          icon: IconUtils.kHome,
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              '/home_screen',
            );
          },
        ),
      ],
    );
  }
}
