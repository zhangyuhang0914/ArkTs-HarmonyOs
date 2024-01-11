import { BackHeader } from '../../components/CommonComponents'
import { LogUtils } from '../../utils/LogUtils'
import TabViewModel from '../../viewmodel/TabViewModel'
import { TrafficList } from'./list/TrafficList'
import { NoticeList } from './list/NoticeList'
import { TrendsList } from './list/TrendsList'
import { ScanList } from './list/ScanList'
import { InvestList } from './list/InvestList'
import router from '@ohos.router'

@Entry
@Component
struct NewNoticeTab {
  @Provide currentIndex: number = router.getParams()['activeId']
  @Provide catId: string = router.getParams()['catId']
  @Provide title: string = '交通要闻'
  @State viewModel: any = null
  @State flag: string = router.getParams()['flag']
  private  controller: TabsController = new TabsController()

  aboutToAppear() {
    this.viewModel = new TabViewModel({ flag: this.flag, activeId: this.currentIndex })
    console.log('flag', this.flag)
    this.title = this.flag === 'top' ? this.viewModel.tabTopTitle[this.currentIndex].title : this.viewModel.tabBottomTitle[this.currentIndex].title
  }

  build() {
    Column() {
      BackHeader({ title: '湖北交通运输厅', alpha: 1 })
      Stack() {
        if (['jtyw', 'tzgg', 'tzdd'].includes(this.catId)) {
          Tabs({ index: this.currentIndex, barPosition: BarPosition.Start, controller: this.controller }) {
            TabContent() {
              TrafficList()
            }.tabBar(this.TabBuilder(0, this.viewModel.tabTopTitle[0].title))

            TabContent() {
              NoticeList()
            }.tabBar(this.TabBuilder(1, this.viewModel.tabTopTitle[1].title))

            TabContent() {
              TrendsList()
            }.tabBar(this.TabBuilder(2, this.viewModel.tabTopTitle[2].title))
          }
          .barHeight($r("app.float.size_50"))
          .barMode(BarMode.Fixed)
          .onChange((index: number) => {
            this.currentIndex = index
            this.viewModel.activeId = this.currentIndex
            this.title = this.viewModel.tabTopTitle[this.currentIndex].title
          })
        } else {
          Tabs({ index: this.currentIndex, barPosition: BarPosition.Start, controller: this.controller }) {
            TabContent() {
              ScanList()
            }.tabBar(this.TabBuilder(0, this.viewModel.tabBottomTitle[0].title))

            TabContent() {
              InvestList()
            }.tabBar(this.TabBuilder(1, this.viewModel.tabBottomTitle[1].title))
          }
          .barHeight($r("app.float.size_50"))
          .barMode(BarMode.Fixed)
          .onChange((index: number) => {
            this.currentIndex = index
            this.viewModel.activeId = this.currentIndex
            this.title = this.viewModel.tabBottomTitle[this.currentIndex].title
          })
        }
      }
    }
    .width("100%")
    .height("100%")
  }

  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? $r('app.color.color_main_text') : $r('app.color.color_black'))
        .fontSize($r('app.float.size_text_15'))
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .height($r("app.float.size_45"))
        .flexGrow(1)
        .textAlign(TextAlign.Center)
      Divider()
        .strokeWidth(2)
        .color($r("app.color.color_main_background"))
        .opacity(this.currentIndex === index ? 1 : 0)
        .width('85%')
        .lineCap(LineCapStyle.Round)
    }
    .width('100%') //解决Tab连接处白色线条间隙
    .height($r("app.float.size_50"))
    .backgroundColor($r("app.color.color_white"))
    .justifyContent(FlexAlign.Center)
  }
}