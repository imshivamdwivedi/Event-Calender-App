import 'package:flutter/material.dart';

class SliverExperiment extends StatefulWidget {
  const SliverExperiment({Key? key}) : super(key: key);

  @override
  _SliverExperimentState createState() => _SliverExperimentState();
}

class _SliverExperimentState extends State<SliverExperiment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  Text('Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  Text('Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ],
              ),
              background: Image.network(
                'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                fit: BoxFit.cover,
              )),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.format_list_bulleted))
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                    ),
                    title: Text("Parneet"),
                  ),
              childCount: 10),
        )
      ]),
    );
  }
}
