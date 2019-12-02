import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_utils_app/ui/widget/smart_refresh/footer.dart';
import 'package:my_utils_app/ui/widget/smart_refresh/header.dart';

class SmartRefresher extends StatelessWidget {
  final EasyRefreshController controller;
  final Function onRefresh;
  final Function onLoading;
  final List<Widget> children;
  const SmartRefresher({Key key, this.controller, this.onLoading, this.onRefresh, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
          // emptyWidget: historyList.length == 0 ? NoDataPage() : null,
          controller: controller,
          header: MyEasyHeader(//自定义的头部样式
            extent: 40.0,
            triggerDistance: 45.0,
            enableInfiniteRefresh: false,
            refreshText: '下拉刷新',
            refreshReadyText: '释放更新',
            refreshingText: '努力刷新中',
            refreshedText: '刷新成功',
            refreshFailedText: '刷新失败',
            noMoreText: '没有更多数据了',
            bgColor: Color(0xffeeeeee),
            textColor: Color(0xff909090),
            infoColor: Colors.white,
            float: false,
            showInfo: false,
            enableHapticFeedback: true,
          ),
          footer: MyEasyFooter( // 自定义的根部样式
            extent: 40.0,
            triggerDistance: 45.0,
            enableInfiniteLoad: false,
            loadText: '上拉加载',
            loadReadyText: '释放加载',
            loadingText: '加载中...',
            loadedText: '加载成功',
            loadFailedText: '加载失败',
            noMoreText: '- end -',
            enableHapticFeedback: true,
            bgColor: Color(0xffeeeeee),
            textColor: Color(0xff909090),
            showInfo: false,
          ),
          onRefresh: onRefresh,
          slivers: children,
          onLoad: onLoading
        );
  }
}