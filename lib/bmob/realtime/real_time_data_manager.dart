import 'client.dart';

import 'dart:async';
import 'package:leancloud_fake/bmob/response/bmob_error.dart';
import 'package:leancloud_fake/bmob/realtime/change.dart';

class RealTimeDataManager {
  static RealTimeDataManager instance;

  RealTimeDataManager();

  ///单例
  static RealTimeDataManager getInstance() {
    if (instance == null) {
      instance = new RealTimeDataManager();
    }
    return instance;
  }

  ///数据监听
  Future listen({onConnected, onDisconnected, onDataChanged, onError}) async {
    Client client = Client();
    client.listen(connectedCallback: (Client client) {
      onConnected(client);
    }, disconnectedCallback: (Client client) {
      onDisconnected(client);
    }, dataChangedCallback: (Change change) {
      onDataChanged(change);
    }, errorCallback: (BmobError error) {
      onError(error);
    });
  }
}
