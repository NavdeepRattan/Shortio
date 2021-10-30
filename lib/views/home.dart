import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shortsio/helper/category.dart';
import 'package:shortsio/models/article_model.dart';
import 'package:shortsio/helper/news.dart';
import 'package:shortsio/models/category_model.dart';

import 'article_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final appBar = AppBar(
    title: Text(
      "Shortio",
      style: TextStyle(color: Colors.blueGrey[500]),
    ),
    centerTitle: true,
    elevation: 0,
  );
  List<ArticleModel> articles;
  List<CategoryModel> category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass
        .getNews(); //using news object we are calling newsClass function
    articles = newsClass.newsList; // storing into list articles
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffD6E0F0).withOpacity(.9),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFDFAF6).withOpacity(.25),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      height: 80,
                      padding: EdgeInsets.all(9),
                      child: ListView.builder(
                          itemCount: category.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageUrl: category[index].imageUrl,
                              categoryName: category[index].categoryName,
                            );
                          }),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.87,
                      padding: EdgeInsets.all(16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            // return HeadlineTile(
                            //     imageUrl: articles[index].urlToImage,
                            //     title: articles[index].title,
                            //     desc: articles[index].description,
                            //     url: articles[index].url);
                            return HeadlineCard(
                                imageUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url);
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class HeadlineCard extends StatefulWidget {
  final String imageUrl, title, desc, url;
  HeadlineCard(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});

  @override
  _HeadlineCardState createState() => _HeadlineCardState();
}

class _HeadlineCardState extends State<HeadlineCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        height: 400,
        margin: EdgeInsets.only(bottom: 10),
        child: Card(
          shadowColor: Colors.blueAccent.withOpacity(0.5),
          elevation: 5,
          color: Colors.white70.withOpacity(.6),
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Stack(
                children: [
                  Ink.image(
                    image: NetworkImage(imageUrl),
                    height: 220,
                    child: InkWell(
                      onTap: () {},
                    ),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black,
                      letterSpacing: .8),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  desc,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.only(right: 16),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.black26,
                ),
                alignment: Alignment.center,
                child: Text(
                  categoryName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          )),
    );
  }
}
