import router from '@ohos.router'
import TabDetailViewModel from '../../../../viewmodel/TabDetailViewModel'
import { TabModelItemList } from '../../../../model/NoticeModel'
import { ViewStateConstant } from '../../../../constants/ViewStateConstant'
import { BackHeader } from '../../../../components/CommonComponents'
import { LoadingDialog } from '../../../../components/LoadingDialog'

@Entry
@Component
struct CommonDetail {
  private title: string = router.getParams()['title'] || ''
  private pageNum: number = router.getParams()['pageNum']
  private catId: number = router.getParams()['catId']
  private item: TabModelItemList = router.getParams()['item']
  private catIdUrl: string = '/bmdt/'
  private scroller: Scroller = new Scroller()
  @State viewState: string = ViewStateConstant.VIEW_STATE_LOADING
  @State content: string = ''
  @State viewModel: any = null
  // loading
  @State showLoading: boolean = false
  loadingDialogControlle: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog(),
    autoCancel: false,
    gridCount: 2,
    cancel: () => { this.showLoading = false }
  })

  aboutToAppear() {
    let currentNum = this.pageNum / 10
    const currentPage = currentNum.toString().indexOf('.') === -1 ? currentNum : Math.ceil(currentNum)
    this.viewModel = new TabDetailViewModel({
      docId: this.item.DOCID,
      url: `${this.catIdUrl + this.catId}/list.json`,
      contentUrl: `${this.catIdUrl + this.catId}/zw.json`,
      pageNum: currentPage
    })
    this.viewModel.observeState((state) => this.viewState = state)
    this.loadingDialogControlle.open()
    this.showLoading = true
    this.initData()
  }

  initData() {
    this.viewModel.getDetailInfo((result) => {
      this.loadingDialogControlle.close()
      this.showLoading = false
      this.content = result
      console.log('getDetailInfo', this.content)
    })
  }

  docReletime(value): string {
    if (!value) return ''
    let time = value.match(/^\d{4}-\d{2}-\d{2}/)
    return time ? time[0] : ''
  }

  build() {
    Column() {
      Flex({ direction: FlexDirection.Column }) {
        BackHeader({ title: this.title as string, alpha: 1 })
        Scroll(this.scroller) {
          Column() {
            Text(this.item.DOCTITLE).width('100%').fontSize($r('app.float.size_text_20')).textAlign(TextAlign.Start)
            Text(this.docReletime(this.item.DOCRELTIME))
              .width('100%')
              .fontColor('#888888')
              .fontSize($r('app.float.size_text_15'))
              .margin({ top: $r('app.float.size_10'), bottom: $r('app.float.size_10') })
              .textAlign(TextAlign.Start)
            Divider().strokeWidth(1).color($r('app.color.color_black'))
            RichText(this.content).height('100%').padding({ top: $r('app.float.size_12'), bottom: $r('app.float.size_12') })
          }.padding($r('app.float.size_12'))
        }
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)
      }.height('100%')
    }.height('100%')
  }
}