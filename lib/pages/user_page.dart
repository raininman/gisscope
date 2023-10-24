import 'package:flutter/material.dart';
import 'package:gisscope/components/post_item.dart';
import 'package:gisscope/data/model/user.dart';
import 'package:gisscope/provider/post_provider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  final User user;
  const UserPage({super.key, required this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = context.read<PostProvider>().getPostsByUserId(widget.user.id);
    return Scaffold(
        body: CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: UserAppBar(
            offset: scrollController.hasClients ? scrollController.offset : 0,
            user: widget.user,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return PostItem(post: posts[index]);
            },
            childCount: posts.length,
          ),
        ),
      ],
    ));
  }
}

class UserAppBar extends StatelessWidget {
  final User user;
  final double offset;
  var expanded = true;
  UserAppBar({super.key, required this.offset, required this.user});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final progress = offset / width;
    expanded = progress < 0.04;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: width - (expanded ? 0 : width - 260),
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: AnimatedContainer(
              padding: EdgeInsets.only(
                  top: expanded
                      ? 0
                      : MediaQuery.of(context).viewPadding.top + 24),
              alignment: expanded ? null : Alignment.center,
              width: expanded ? width : 180,
              height: expanded ? width : 180,
              duration: const Duration(milliseconds: 200),
              child: Image.asset('assets/temp/user1.jpg', fit: BoxFit.cover),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Column(
              children: [
                Text(user.username),
                Text(user.location!.name),
              ],
            ),
          )
        ],
      ),
    );
  }
}
