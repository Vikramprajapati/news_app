import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  String blogUrl;

  ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final WebViewController _controller;

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            _isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            _isLoading = false; // Hide loading indicator
          });
        },
      ))
      ..loadRequest(Uri.parse(widget.blogUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("News"),
              Text(
                "Adda",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(width: 30,)
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(child: WebViewWidget(controller: _controller)));
  }
}
