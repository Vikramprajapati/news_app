class ShowCategoryModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  ShowCategoryModel(this.author, this.title, this.description, this.url,
      this.urlToImage, this.content);

  factory ShowCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShowCategoryModel(json["author"], json["title"], json["description"],
        json["url"], json["urlToImage"], json["content"]);
  }
}
