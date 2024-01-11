import { TabModelItemList } from '../../../../model/NoticeModel'
import { Router } from '../../../../route/Router'
import { RoutePath } from '../../../../route/RoutePath'

@Component
export struct CommonItem {
  private item: TabModelItemList
  @Prop pageNum: number
  @Consume title: string
  @Consume catId: string
  build() {
    Flex({ direction: FlexDirection.Column }) {
      Text(this.item.DOCTITLE)
        .fontSize(16)
        .padding({ top: 10, bottom: 10 })
      Row() {
        Image($r('app.media.timeout_icon')).width(16).height(16)
        Text(this.item.DOCRELTIME).fontSize(14).fontColor('#a0a0a0').padding({ left: 8, right: 8 })
      }.padding({ bottom: 10 })
    }.onClick(() => {
      Router.push('pages/tabs/list/component/CommonDetail', {
        title: this.title,
        pageNum: this.pageNum,
        catId: this.catId,
        item: this.item
      })
    })
  }
}