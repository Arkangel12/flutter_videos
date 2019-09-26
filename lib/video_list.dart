import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';

import 'video_widget.dart';

class VideoList extends StatelessWidget {
  final List<Post> posts = [
    Post(
        id: 13,
        isVideo: true,
        userName: 'Argel',
        videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
        content: 'Content from ',
    ),
    Post(
      id: 21,
      isVideo: false,
      userName: 'Guille',
      videoUrl: '',
      content: 'Content from ',
    ),
    Post(
      id: 33,
      isVideo: false,
      userName: 'Anya',
      videoUrl: '',
      content: 'Content from ',
    ),
    Post(
      id: 42,
      isVideo: true,
      userName: 'Argel',
      videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      content: 'Content from ',
    ),
    Post(
      id: 29,
      isVideo: false,
      userName: 'Guilli',
      videoUrl: '',
      content: 'Content from ',
    ),
    Post(
      id: 74,
      isVideo: true,
      userName: 'Carlos',
      videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      content: 'Content from ',
    ),
    Post(
      id: 54,
      isVideo: true,
      userName: 'Carlo',
      videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      content: 'Content from ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InViewNotifierList(
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
                deltaBottom > (0.5 * viewPortDimension);
          },
          children: [
            for(Post post in posts)
              Container(
                width: double.infinity,
                height: 300.0,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 50.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final InViewState inViewState = InViewNotifierList.of(context);

                    inViewState.addContext(context: context, id: '${post.id}');

                    return AnimatedBuilder(
                      animation: inViewState,
                      builder: (BuildContext context, Widget child) {
                        if (post.isVideo)
                          return VideoWidget(
                            play: inViewState.inView('${post.id}'),
                            url: post.videoUrl,
                          );
                        else
                          return Container(child: Text('User: ${post.userName}, Content: ${post.content}${post.userName} '));
                      },
                    );
                  },
                ),
              ),
          ]
        ),
        // This is just to know then does the video its gonna be playing, it's not needed.
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 2.0,
            color: Colors.redAccent,
          ),
        )
      ],
    );
  }
}

class Post {
  final int id;
  final bool isVideo;
  final String userName;
  final String videoUrl;
  final String content;

  Post({this.id, this.isVideo, this.userName, this.videoUrl, this.content});
}
