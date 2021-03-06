import 'package:flutter/material.dart';
import '../models/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(1.2, 2.4),
            color: Colors.black12,
            blurRadius: .64,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: post.uri != null
                ? Image.network(
                    post.uri,
                    fit: BoxFit.contain,
                    cacheWidth: 512,
                  )
                : Container(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            post.status,
            style: TextStyle(fontSize: 14),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: ClipOval(
                      child: Image.network(post.userProfilePicture),
                    ),
                  ) ??
                  Container(),
              SizedBox(width: 16),
              Column(
                children: [
                  Text(
                    '@${post.username}',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '#${post.hashtag}',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
