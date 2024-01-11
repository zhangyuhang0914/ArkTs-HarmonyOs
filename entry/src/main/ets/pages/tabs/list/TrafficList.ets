import { StateComponent } from '../../../components/StateComponent'
import { RefreshFooter } from '../../../components/RefreshFooter'
import { ViewStateConstant } from '../../../constants/ViewStateConstant'
import { LogUtils } from '../../../utils/LogUtils'
import TabViewModel from '../../../viewmodel/TabViewModel'
import { CommonItem } from './component/CommonItem'

@Component
export struct TrafficList {
  @State viewState: string = ViewStateConstant.VIEW_STATE_LOADING
  @State isRefreshing: boolean = false
  @State dataList: Array<any> = []
  @State showLoading: boolean = false
  @State viewModel: any = null
  @Consume @Watch("onFindTabSelectedIndex") currentIndex: number
  private hasInit = false

  aboutToAppear() {
    this.viewModel = new TabViewModel({ flag: 'top', activeId: this.currentIndex })
    this.viewModel.observeState((state) => this.viewState = state)
    this.initData()
    if (this.hasInit) {
      this.loadNet()
    }
  }

  /**
   * 懒加载处理逻辑
   */
  onFindTabSelectedIndex() {
    LogUtils.debug("Focus-onTrafficTabSelectedIndex", `FindIndex:${this.currentIndex}`)
    this.viewModel.activeId = this.currentIndex
    this.initData()
  }

  initData() {
    if (!this.hasInit && this.currentIndex == 0) {
      this.loadNet()
      this.hasInit = true
    }
  }

  loadNet() {
    this.viewModel.getListData((result) => {
      this.isRefreshing = false
      this.showLoading = false
      console.log('pageIndex', this.viewModel.pageIndex)
      if (this.viewModel.pageIndex == 1) {
        this.dataList = result
      } else {
        this.dataList = [...this.dataList, ...result]
      }
    })
  }

  build() {
    Column() {
      StateComponent({
        viewState: this.viewState,
        retryCallback: () => {
          this.loadNet()
        }
      }) {
        Refresh({ refreshing: $$this.isRefreshing, offset: 100, friction: 100 }) {
          Column() {
            List({ space: 10, initialIndex: 0 }) {
              ForEach(this.dataList, (item, index) => {
                ListItem() {
                  CommonItem({ item: item, pageNum: index + 1 })
                }
              })
              ListItem() {
                RefreshFooter({ showFooter: this.showLoading })
              }
            }
            .height('100%')
            .padding({ bottom: '100' })
            .listDirection(Axis.Vertical) // 排列方向
            .divider({
              strokeWidth: 1,
              color: '#eeeeee'
            }) // 每行之间的分界线
            .onReachEnd(() => {
              console.log('onReachEnd')
              this.showLoading = true
              this.loadNet()
            })
          }
        }
        .onRefreshing(() => {
          console.log('onRefreshing')
          this.viewModel.pageIndex = 1
          this.loadNet()
        }).height('100%').padding({ left: 10, right: 10 })
      }
    }.width('100%').height('100%')
  }
}