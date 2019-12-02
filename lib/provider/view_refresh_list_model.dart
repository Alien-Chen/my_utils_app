import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:my_utils_app/provider/view_state_model.dart';
// 用于可下拉刷新 上拉加载的列表
abstract class ViewRefreshListModel<T> extends ViewStateModel {
  int total = 0; // 列表总数
  // 分页第一页页码
  static const int pageNumFirst = 1;
  // 每页条目数目
  static const int pageSize = 10;
  // 加载更多组件控制器
  EasyRefreshController _refreshController = EasyRefreshController();
  
  EasyRefreshController get refreshController => _refreshController;
  // 当前页码
  int _currentPageNum = pageNumFirst;

  // 列表数据
  List<T> list = []; 
  // 第一次进入页面loading
  initData() async {
    // busy = true;
    setBusy();
    await refresh(init: true);
  }

  // 下拉刷新
  Future<List<T>> refresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      List<T> data = await loadData(pageNum: pageNumFirst);
      if (data.isEmpty) {
        refreshController.finishRefresh(success: true);
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        refreshController.finishRefresh(success: true, noMore: false);
        refreshController.finishLoad(success: true, noMore: false);
        setIdle();
      }
      notifyListeners();
      return data;
    } catch (e, s) {
      if (init) list.clear();
      print(e);
      refreshController.finishRefresh(success: false);
      setError(e);
      notifyListeners();
      return null;
    }
  }

  // 上拉加载更多
  Future<List<T>> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.finishLoad(noMore: true, success: true);
      } else {
        onCompleted(data);
        list.addAll(data);
        if (list.length < total) {
          refreshController.finishLoad(noMore: false, success: true);
        } else {
          refreshController.finishLoad(noMore: true, success: true);
        }
        notifyListeners();
      }
      return data;
    } catch(e, s) {
      _currentPageNum--;
      refreshController.finishLoad(success: false);
      return null;
    }
  }

  // 加载数据
  Future<List<T>> loadData({int pageNum});

  onCompleted(List<T> data) {}

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}