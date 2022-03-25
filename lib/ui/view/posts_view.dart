// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/services/data_service.dart';
import 'package:my_app/ui/cubit/post_cubit.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final dataservice = DataService();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAppCubit(dataservice),
      child: PostsView(),
    );
  }
}

class PostsView extends StatefulWidget {
  const PostsView({
    Key? key,
  }) : super(key: key);

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  @override
  void initState() {
    context.read<MyAppCubit>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('MyApp')),
      body: BlocBuilder<MyAppCubit, MyAppState>(
        builder: (context, state) {
          if (state is MyAppStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MyAppStateLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                // ignore: omit_local_variable_types
                final post = state.posts[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(post.id.toString()),
                    ),
                    title: Text(
                      post.title,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      post.body,
                      maxLines: 1,
                    ),
                  ),
                );
              },
            );
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }
}
