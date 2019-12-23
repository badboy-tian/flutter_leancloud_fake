import 'package:leancloud_fake/bmob/bmob.dart';
import 'package:leancloud_fake/bmob/table/bmob_object.dart';
import 'package:leancloud_fake/bmob/table/bmob_user.dart';
import 'package:leancloud_fake/bmob/table/bmob_installation.dart';
import 'package:leancloud_fake/bmob/table/bmob_role.dart';
import 'package:leancloud_fake/bmob/response/bmob_error.dart';
import 'package:leancloud_fake/bmob/type/bmob_file.dart';

class BmobUtils {
  ///获取BmobObject对象的表名
  static String getTableName(dynamic object) {
    /*if (!(object is BmobObject)) {
      throw new BmobError(1002, "The object is not a BmobObject.");
    }*/
    String tableName;
    if (object.runtimeType.toString().contains("User")) {
      tableName = Bmob.BMOB_TABLE_USER;
    } else if (object is BmobInstallation) {
      tableName = Bmob.BMOB_TABLE_INSTALLATION;
    } else if (object is BmobRole) {
      tableName = Bmob.BMOB_TABLE_TOLE;
    } else if(object is BmobFile) {
      tableName = Bmob.BMOB_TABLE_FILE;
    }else {
      tableName = object.runtimeType.toString();
    }
    return tableName;
  }
}
