import 'package:flutter/material.dart';
import 'package:habits/const.dart';
import 'package:habits/models/chapter.dart';
import 'package:habits/screens/subchapter_screen.dart';

class ChapterScreen extends StatelessWidget {
  final int index;

  ChapterScreen(this.index, {super.key});

  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
      Positioned(
          top: verticalBlock * 6,
          left: horizontalBlock * 5,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.adaptive.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      Padding(
        padding: EdgeInsets.only(
            top: verticalBlock * 22, left: horizontalBlock * 15),
        child: Container(
          width: horizontalBlock * 85,
          color: const Color(0xffF7F7F7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: verticalBlock * 2.5,
                    horizontal: horizontalBlock * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                          width: horizontalBlock * 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1.',
                                  style: TextStyle(
                                      fontSize: verticalBlock * 4,
                                      fontWeight: FontWeight.w800)),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: verticalBlock * 2.5,
                                ),
                                child: Text('Your Inner Mammal',
                                    style: TextStyle(
                                        fontSize: verticalBlock * 3,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: verticalBlock * 28),
                    Text('About the chapter',
                        style: TextStyle(
                          fontSize: verticalBlock * 3,
                          fontWeight: FontWeight.w700,
                        )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: verticalBlock * 2),
                      child: Text(
                          'Your feelings are unique, but the chemicals that cause your feelings are the same as everyone else’s. Your life experience is unique, but it overlaps with everyone’s because the same basic survival needs command your brain’s attention.',
                          style: TextStyle(
                              fontSize: verticalBlock * 2.5,
                              letterSpacing: 0.4,
                              height: 1.4,
                              color: const Color(0xff848181))),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: verticalBlock * 3, vertical: verticalBlock * 3),
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                  ),
                ),
                child: Text(
                  'Finished Chapter',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: verticalBlock * 2,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
          top: verticalBlock * 15,
          left: 0,
          child: Hero(
            tag: index,
            child: Container(
              height: verticalBlock * 30,
              width: horizontalBlock * 50,
              decoration: BoxDecoration(
                boxShadow: [containerShadow],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                child: Image.asset(
                  'assets/images/chapter1.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )),
      Positioned(
        top: verticalBlock * 50,
        right: 0,
        left: 0,
        child: SizedBox(
          height: verticalBlock * 15,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: horizontalBlock * 5, bottom: verticalBlock * 2),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: verticalBlock * 2, vertical: verticalBlock),
                    width: verticalBlock * 20,
                    decoration: BoxDecoration(
                      boxShadow: [containerShadow],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/images/dopamine.png',
                            height: verticalBlock * 3,
                          ),
                        ),
                        Text(
                          'Dopamine',
                          style: TextStyle(
                              color: blue,
                              fontSize: verticalBlock * 2,
                              fontWeight: FontWeight.w800),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(Icons.adaptive.arrow_forward),
                            iconSize: verticalBlock * 2,
                            color: blue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SubchapterScreen()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      )
    ])));
  }
}
