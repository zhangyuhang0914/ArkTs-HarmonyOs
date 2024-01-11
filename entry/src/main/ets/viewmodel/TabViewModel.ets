import { BaseViewModel, ResultCallback } from './BaseViewModel'
import { getHandleList } from '../apis/ApiService'
import showToast from '../utils/ToastUtils'

export class TabViewModel extends BaseViewModel {
  constructor(param) {
    super()
    this.flag = param.flag
    this.activeId = param.activeId
  }
  tabTopTitle = [
    {
      index: 0,
      title: '交通要闻',
      apiUrl: '/bmdt/jtyw/list.json'
    },
    {
      index: 1,
      title: '通知公告',
      apiUrl: '/bmdt/tzgg/list.json'
    },
    {
      index: 2,
      title: '厅直动态',
      apiUrl: '/bmdt/tzdt/list.json'
    }
  ]
  tabBottomTitle = [
    {
      index: 0,
      title: '市州扫描',
      apiUrl: '/bmdt/szsm/list.json'
    },
    {
      index: 1,
      title: '招标投标',
      apiUrl: '/bmdt/ztbxx/list.json'
    }
  ]
  flag: string = 'top'
  activeId: number = 0
  pageIndex: number = 1
  async getListData(resultCallback: ResultCallback) {
    await this.httpRequest().promise(getHandleList({ url: this.flag === 'top' ? this.tabTopTitle[this.activeId].apiUrl : this.tabBottomTitle[this.activeId].apiUrl, page: this.pageIndex }).then((result) => {
      result = JSON.parse(result)
      if (result.code === 0) {
        this.pageIndex++
        resultCallback(result.data)
      } else {
        showToast(result.msg || '网络请求失败，请稍后重试')
      }
    }), this.pageIndex == 1 ? true : false)
  }
}

// let tabViewModel = new TabViewModel()
// export default tabViewModel as TabViewModel
export default TabViewModel
