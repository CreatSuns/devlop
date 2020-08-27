import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttersh/consts/consts.dart';
import 'package:fluttersh/routes/application.dart';
import 'package:fluttersh/routes/routes.dart';
import 'package:tableview/sliver_tableview.dart';
import 'package:tableview/tableview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List images = [
    Image.asset(imageNamed('1.jpeg'), fit: BoxFit.fill,),
    Image.asset(imageNamed('2.jpg'), fit: BoxFit.fill,),
    Image.asset(imageNamed('3.jpg'), fit: BoxFit.fill,)
  ];

  Widget topWidget() {
    return SizedBox(
      height: 200,
      child: Swiper(
        itemCount: images.length,
        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
            builder: DotSwiperPaginationBuilder(
                color: Colors.black54, activeColor: Colors.white)),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return images[index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: CustomScrollView(
        slivers: [
          SliverTableView(delegate: SliverTableDelegate(sectionNumber: 1, numberRowOfSection: null, rowView: null),)
        ],
      )
      TableView(
        tableHeaderView: topWidget(),
        sectionNumber: 1,
        numberRowOfSection: (BuildContext context, int index) {
          return 1;
        },
        rowView: (BuildContext context, int section, int row) {
          return Text('a');
        },
      ),
    );
  }
}
