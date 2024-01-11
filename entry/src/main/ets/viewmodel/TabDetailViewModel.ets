import { BaseViewModel, ResultCallback } from './BaseViewModel'
import { getHandleDetail } from '../apis/ApiService'
import showToast from '../utils/ToastUtils'

export class TabDetailViewModel extends BaseViewModel {
  private docId: string
  private url: string
  private contentUrl: string
  private pageNum: number
  constructor(params) {
    super()
    this.docId = params.docId
    this.url = params.url
    this.contentUrl = params.contentUrl
    this.pageNum = params.pageNum
  }
  async getDetailInfo(resultCallback: ResultCallback) {
    console.log('url', this.url)
    console.log('contentUrl', this.contentUrl)
    console.log('pageNum', this.pageNum)
    console.log('docId', this.docId)
    await this.httpRequest().promise(getHandleDetail({
      url: this.url,
      contentUrl: this.contentUrl,
      page: this.pageNum,
      docId: this.docId
    }).then((result) => {
      resultCallback(result)
    }))
  }
}

// let tabDetailViewModel = new TabDetailViewModel()
// export default tabDetailViewModel as TabDetailViewModel
export default TabDetailViewModel