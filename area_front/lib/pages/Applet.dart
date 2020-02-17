// Core
import 'package:area_front/models/applets/Params.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:flutter/material.dart';

// Models
import 'package:area_front/models/applets/Applet.dart';

class AppletsDetailsPage extends StatelessWidget {
  const AppletsDetailsPage(this.applet, {Key key}) : super(key: key);

  final Applet applet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
          child: Column(
        children: <Widget>[
          AreaTitle(applet.title),
          AreaText(applet.description),
          ListofParams(applet.params)
        ],
      )),
    );
  }
}

class ListofParams extends StatefulWidget {
  ListofParams(this.params, {Key key}) : super(key: key);

  final List<AppletParam> params;

  @override
  _ListofParamsState createState() => _ListofParamsState();
}

class _ListofParamsState extends State<ListofParams> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 4 * 3),
      child: Row(
        children: <Widget>[
          ParamColumn(
            title: 'Service',
            content: [
              AppletParam(
                  name: 'toto',
                  category: 'reaction',
                  type: 'string',
                  value: 'tutu')
            ],
          ),
          ParamColumn(title: 'Reaction', content: []),
        ],
      ),
    ));
  }
}

class ParamColumn extends StatelessWidget {
  const ParamColumn(
      {Key key, @required this.title, @required this.content, this.applet})
      : super(key: key);

  final String title;
  final List<AppletParam> content;
  final Applet applet;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Expanded(
              child: Card(
                  child: Text(
            this.title,
            textAlign: TextAlign.center,
          ))),
        ]),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: content.length,
            itemBuilder: (context, index) {
              final AppletParam param = content[index];
              return Card(
                  child: ListTile(
                      title: Text(param.name),
                      subtitle: TextField(
                        controller: TextEditingController(text: param.value),
                        onSubmitted: (text) {
                          print('Send a request');
                        },
                      )
                      ));
            })
      ]),
    ));
  }
}
