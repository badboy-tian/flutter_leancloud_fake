import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leancloud_fake/utils/file_picker.dart';
import 'dart:io';
import 'package:leancloud_fake/bmob/bmob_file_manager.dart';
import 'package:leancloud_fake/data_plugin.dart';
import 'package:leancloud_fake/bmob/type/bmob_file.dart';
import 'package:leancloud_fake/bmob/response/bmob_error.dart';
import '../bean/blog.dart';
import 'package:leancloud_fake/bmob/response/bmob_saved.dart';
import 'package:leancloud_fake/bmob/response/bmob_handled.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FilePage extends StatefulWidget {
  @override
  _FilePageState createState() => new _FilePageState();
}

class _FilePageState extends State<FilePage> {
  String _fileName;
  String _path;
  String _url;
  BmobFile _bmobFile;
  Map<String, String> _paths;
  String _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    _path = image.path;

    if (!mounted) return;

    setState(() {
      _fileName = _path != null ? _path.split('/').last : _paths != null ? _paths.keys.toString() : '...';
      // DataPlugin.toast("所选文件：$_fileName");
      print(_fileName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('File Picker example app'),
        ),
        body: new Center(
            child: new Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: new RaisedButton(
                    onPressed: () => _openFileExplorer(),
                    color: Colors.blue[400],
                    child: new Text(
                      "选择文件",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: new RaisedButton(
                    onPressed: () => _uploadFile(_path),
                    color: Colors.blue[400],
                    child: new Text(
                      "上传文件",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: new RaisedButton(
                    onPressed: () => _addFile(_bmobFile),
                    color: Colors.blue[400],
                    child: new Text(
                      "添加文件到表中",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: new RaisedButton(
                    onPressed: () async{
                      //http://lc-aR85Xr2p.cn-n1.lcfile.com/P7keAM78Nb4fXiRj7OViJGIago9CL807CbG5nDaT.jpg
                      Directory appDocDir = await getApplicationDocumentsDirectory();
                      String appDocPath = appDocDir.path;
                      print(appDocPath);
                      _downloadFile(_url, "$appDocPath/download-${DateTime.now().toString()}.png");
                    },
                    color: Colors.blue[400],
                    child: new Text(
                      "下载文件",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: new RaisedButton(
                    onPressed: () => _deleteFile(_bmobFile.objectId),
                    color: Colors.blue[400],
                    child: new Text(
                      "删除文件",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                new Builder(
                  builder: (BuildContext context) => new Container(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: new Scrollbar(
                      child: _path != null || _paths != null
                          ? new ListView.separated(
                              itemCount: _paths != null && _paths.isNotEmpty ? _paths.length : 1,
                              itemBuilder: (BuildContext context, int index) {
                                final bool isMultiPath = _paths != null && _paths.isNotEmpty;
                                final String name = 'File $index: ' + (isMultiPath ? _paths.keys.toList()[index] : _fileName ?? '...');
                                final path = isMultiPath ? _paths.values.toList()[index].toString() : _path;

                                return new ListTile(
                                  title: new Text(
                                    name,
                                  ),
                                  subtitle: new Text(path),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => new Divider(),
                            )
                          : new Container(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  ///上传文件，上传文件涉及到android的文件访问权限，调用此方法前需要开发者们先适配好应用在各个android版本的权限管理。
  _uploadFile(String path) {
    if (path == null) {
      DataPlugin.toast("请先选择文件");
      return;
    }
    DataPlugin.toast("上传中，请稍候……");
    File file = new File(path);
    BmobFileManager.upload(file).then((BmobFile bmobFile) {
      _bmobFile = bmobFile;
      _url = bmobFile.url;
      print("$bmobFile");
      DataPlugin.toast("上传成功：$bmobFile");
    }).catchError((e) {
      DataPlugin.toast(BmobError.convert(e).error);
    });
  }

  ///添加文件到表中
  _addFile(BmobFile bmobFile) {
    if (bmobFile == null) {
      DataPlugin.toast("请先上传文件");
      return;
    }
    Blog blog = Blog();
    blog.pic = bmobFile;
    blog.save().then((BmobSaved bmobSaved) {
      DataPlugin.toast("添加成功：" + bmobSaved.objectId);
    }).catchError((e) {
      DataPlugin.toast(BmobError.convert(e).error);
    });
  }

  ///下载文件，直接使用dio下载，下载文件涉及到android的文件访问权限，调用此方法前需要开发者们先适配好应用在各个android版本的权限管理。
  _downloadFile(String url, String path) async {
    if (url == null) {
      DataPlugin.toast("请先上传文件");
      return;
    }
    Dio dio = Dio();
    Response<dynamic> response = await dio.download(url, path);
    print(response.toString());
    print(response.data);
    DataPlugin.toast("下载结束");
  }

  ///删除文件
  _deleteFile(String objId) {
    if (objId == null) {
      DataPlugin.toast("请先上传文件");
      return;
    }
    BmobFileManager.delete(objId).then((BmobHandled bmobHandled) {
      DataPlugin.toast("删除成功：" + bmobHandled.msg);
    }).catchError((e) {
      DataPlugin.toast(BmobError.convert(e).error);
    });
  }
}
