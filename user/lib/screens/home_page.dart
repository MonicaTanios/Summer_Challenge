import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/post_bloc/bloc.dart';
import '../widgets/post_widget.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController _filterTextEditController = TextEditingController();
  PostBloc postBloc;
  @override
  void initState() {
    super.initState();
    _filterTextEditController.addListener(_onFilerChanged);
    postBloc = BlocProvider.of<PostBloc>(context)..add(LoadPosts());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _filterTextEditController,
                onSubmitted: (_) => _onFilterSubmitted(),
              ),
              Container(
                width: 500,
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is AllPostsLoading) {
                      return Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CircularProgressIndicator()],
                          ),
                        ),
                      );
                    } else if (state is AllPostsLoaded) {
                      return ListView.builder(
                          itemCount: state.posts.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PostWidget(post: state.posts[index]);
                          });
                    } else {
                      return Text('Please Check your internet Connection');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFilterSubmitted() {
    postBloc.add(FilterChanged(filter: _filterTextEditController.text));
  }
  void _onFilerChanged(){
    if (_filterTextEditController.text == ''){
        BlocProvider.of<PostBloc>(context).add(LoadPosts());
    }
  }

  @override
  void dispose() {
   _filterTextEditController.dispose();
    super.dispose();
  }
}
