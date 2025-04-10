class SliderModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  SliderModel(this.author, this.title, this.description, this.url,
      this.urlToImage, this.content);

  factory SliderModel.fromJson(Map<String, dynamic> json){
    return SliderModel(
        json["author"], json["title"], json["description"], json["url"],
        json["urlToImage"], json["content"]);
  }
}
