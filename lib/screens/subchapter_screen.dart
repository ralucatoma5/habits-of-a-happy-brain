import 'package:flutter/material.dart';
import 'package:habits/const.dart';

class SubchapterScreen extends StatelessWidget {
  SubchapterScreen({Key? key}) : super(key: key);
  final nrw = 1;
  final verticalBlock = SizeConfig.safeBlockVertical!;
  final horizontalBlock = SizeConfig.safeBlockHorizontal!;
  final safeareaVertical = SizeConfig.safeBlockVertical!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0.8,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: EdgeInsets.only(
                  top: verticalBlock * 4, right: horizontalBlock * 2),
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/dopamine.png',
                  height: verticalBlock * 6,
                ),
              ),
            ),
            expandedTitleScale: 1.15,
            centerTitle: false,
            title: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: horizontalBlock * 70,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: nrw > 3 ? safeareaVertical * 4 : 0, left: 0),
                  child: Text('Dopamine ',
                      style: TextStyle(
                        color: blue,
                        fontSize: verticalBlock * 3.3,
                        fontWeight: FontWeight.w800,
                      )),
                )),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: nrw > 3 ? verticalBlock * 12 : verticalBlock * 8,
          leading: IconButton(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalBlock * 4, vertical: verticalBlock * 3),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.adaptive.arrow_back,
                size: verticalBlock * 3, color: blue),
          ),
          centerTitle: false,
          leadingWidth: verticalBlock * 3,
          expandedHeight: nrw > 3 ? verticalBlock * 17 : verticalBlock * 12,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalBlock * 8,
                            vertical: verticalBlock),
                        child: Text(
                            'Dopamine promotes survival by telling your body where to invest its energy. A hungry lion expects a reward when she sees an isolated gazelle. Dopamine unleashes your reserve tank of energy when you see a way to meet a need. Even when you’re just sitting still, dopamine motivates you to scan a lot of detail to find a pattern that’s somehow relevant to your needs.',
                            style: readingText));
                  }),
              Padding(
                padding: EdgeInsets.only(
                  right: horizontalBlock * 8,
                  left: horizontalBlock * 8,
                  bottom: verticalBlock * 6,
                ),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: verticalBlock * 0.5, horizontal: 0.0),
                          leading: Container(
                            width: verticalBlock * 2.5,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: blue),
                          ),
                          title: Text('In your work', style: readingText));
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: verticalBlock * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: verticalBlock * 14,
                      height: verticalBlock * 6,
                      child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalBlock * 3.8,
                                  vertical: verticalBlock * 1.5),
                              backgroundColor:
                                  const Color(0xff006FA9).withOpacity(0.4),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              side: BorderSide(color: blue, width: 2)),
                          child: Text('Previous',
                              style: TextStyle(
                                  color: blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: horizontalBlock * 4))),
                    ),
                    SizedBox(
                      width: verticalBlock * 14,
                      height: verticalBlock * 6,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: blue,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        child: Text('Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: horizontalBlock * 4)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
