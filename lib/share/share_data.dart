import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareData extends StatefulWidget {
  const ShareData({Key? key}) : super(key: key);

  @override
  _ShareDataState createState() => _ShareDataState();
}

class _ShareDataState extends State<ShareData> {
  String text = '';
  String subject = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Share text:',
              labelStyle: TextStyle(color: Colors.blue),
              hintText: 'Enter some text and/or link to share',
            ),
            maxLines: 2,
            onChanged: (String value) => setState(() {
              text = value;
            }),
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Share subject:',
              labelStyle: TextStyle(color: Colors.blue),
              hintText: 'Enter subject to share (optional)',
            ),
            maxLines: 2,
            onChanged: (String value) => setState(() {
              subject = value;
            }),
          ),
          RaisedButton(
            color: Colors.orangeAccent[100],
            child: const Text('Share'),
            onPressed: text.isEmpty ? null : () => _onShareData(context),
          )
        ],
      ),
    );
  }

  _onShareData(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }
}
