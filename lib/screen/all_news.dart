import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_news_app/model/article_model.dart";
import "package:flutter_news_app/model/slider_model.dart";
import "package:flutter_news_app/screen/article_view.dart";
import "package:flutter_news_app/service/news.dart";
import "package:flutter_news_app/service/slider_data.dart";

class AllNews extends StatefulWidget {
  String news;

  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  getNews() async {
    NewsService newsService = NewsService();
    await newsService.getData();
    articles = newsService.news;
    setState(() {
      _loading = false;
    });
  }

  getSliders() async {
    SliderNewsService service = SliderNewsService();
    await service.getSlider();
    sliders = service.sliderList;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getNews();
    getSliders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.news + " News",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.builder(
                  itemCount: widget.news == "Breaking"
                      ? sliders.length
                      : articles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: AllNewsSection(
                            image: widget.news == "Breaking"
                                ? sliders[index].urlToImage!
                                : articles[index].urlToImage!,
                            title: widget.news == "Breaking"
                                ? sliders[index].title!
                                : articles[index].title!,
                            desc: widget.news == "Breaking"
                                ? sliders[index].description!
                                : articles[index].description!,
                            url: widget.news == "Breaking"
                                ? sliders[index].url!
                                : articles[index].url!));
                  },
                ),
              ));
  }
}

class AllNewsSection extends StatelessWidget {
  String image, title, desc, url;

  AllNewsSection(
      {required this.image,
      required this.title,
      required this.desc,
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
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(desc,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
