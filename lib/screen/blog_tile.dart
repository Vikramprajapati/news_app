import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/screen/article_view.dart';

class BlogTile extends StatelessWidget {
  String imageUrl, desc, title, url;

  BlogTile(
      {required this.imageUrl,
      required this.desc,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(blogUrl: url),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      imageUrl: imageUrl,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          desc,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
