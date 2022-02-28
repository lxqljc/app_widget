import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';

/// User: luoxiaoquan
/// Date: 2022/2/11
/// description: 小组件管理类
class AppWidgetManager {
  /// 初始化
  static void init({required String groupId}) {
    // 设置组id（仅iOS需要设置）
    HomeWidget.setAppGroupId(groupId);
    // app启动拦截scheme
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
    // app处于后台拦截scheme
    HomeWidget.widgetClicked.listen(_launchedFromWidget);
    // 注册原生widget点击事件广播监听
    HomeWidget.registerBackgroundCallback(_backgroundCallback);
    // 定时器初始化
    Workmanager().initialize(_callbackDispatcher, isInDebugMode: false);
  }

  /// 拦截scheme业务处理（打开页面）
  static void _launchedFromWidget(Uri? uri) {
    if (uri != null) {
      print('uri--->$uri');
    }
  }

  /// 后台监听原生Widget点击事件（广播事件）
  static Future<void> _backgroundCallback(Uri? data) async {
    print('data--->$data');
    if (data?.host == 'titleclicked') {
      // 处理业务逻辑(HomeWidget.saveWidgetData或HomeWidget.updateWidget)
    }
  }

  /// 定时任务调度(Android's WorkManager and iOS' performFetchWithCompletionHandler)
  static void _callbackDispatcher() {
    Workmanager().executeTask((String taskName, Map<String, dynamic>? inputData) {
      print('taskName-->$taskName-----inputData-->$inputData');
      return Future<bool>.value(true);
    });
  }
}
