import 'package:leancloud_fake/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_fake/data_plugin.dart';
import 'package:leancloud_fake/bmob/response/server_time.dart';
import 'package:leancloud_fake/bmob/response/bmob_error.dart';
import 'package:leancloud_fake/bmob/bmob_date_manager.dart';
import '../bean/blog.dart';
import 'package:leancloud_fake/bmob/type/bmob_date.dart';
import 'package:leancloud_fake/bmob/response/bmob_saved.dart';

class TimePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OtherState();
  }
}

class _OtherState extends State<TimePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("其他操作"),
      ),
      body: new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            RaisedButton(
                onPressed: () {
                  _getServerTime();
                },
                color: Colors.blue[400],
                child: new Text('获取服务器时间',
                    style: new TextStyle(color: Colors.white))),
            RaisedButton(
                onPressed: () {
                  _addDate();
                },
                color: Colors.blue[400],
                child: new Text('添加时间类型',
                    style: new TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }

  ///获取服务器时间
  _getServerTime() {
    BmobDateManager.getServerTimestamp().then((ServerTime serverTime) {
      showSuccess(context, "${serverTime.timestamp}\n${serverTime.datetime}");
    }).catchError((e) {
      showError(context, BmobError.convert(e).error);
    });
  }

  ///添加时间数据
  _addDate() {
    DateTime dateTime = DateTime.now();
    BmobDate bmobDate = BmobDate();
    bmobDate.setDate(dateTime);
    Blog blog = Blog();
    blog.time = bmobDate;
    blog.title = "添加时间类型";
    blog.content = "测试时间类型的请求";
    blog.save().then((BmobSaved bmobSaved) {
      showSuccess(context, bmobSaved.objectId);
    }).catchError((e) {
      showError(context, BmobError.convert(e).error);
    });
  }
}
