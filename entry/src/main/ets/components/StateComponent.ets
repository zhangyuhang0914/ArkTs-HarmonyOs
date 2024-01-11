import { ViewStateConstant } from '../constants/ViewStateConstant'
import { CommonSkeleton } from '../skeleton/CommonSkeleton'

@Component
export struct StateComponent {
  @Prop viewState: string
  // 页面内容区域组件
  @BuilderParam viewContent: () => void
  // 重试的回调方法
  retryCallback?: () => void
  // 是否骨架屏幕
  private showSkeleton: Boolean = false

  build() {
    Stack() {
      if (this.viewState !== ViewStateConstant.VIEW_STATE_SUCCESS) {
        this.holdContent()
      } else {
        this.viewContent()
      }
    }.width('100%').height('100%')
  }

  /**
   * 占位组件
   */
  @Builder
  holdContent() {
    if (this.showSkeleton && this.viewState === ViewStateConstant.VIEW_STATE_LOADING) {
      CommonSkeleton()
    } else {
      Column() {
        LoadingProgress().width($r('app.float.size_36')).height($r('app.float.size_36')).color('#3598DB')
        // Image(this.convertImage())
        //   .width($r('app.float.size_28'))
        //   .height($r('app.float.size_28'))
        Text(this.convertValue())
          .fontSize($r('app.float.size_text_15'))
          .fontColor($r("app.color.color_666"))
          .margin($r('app.float.size_10'))
          .padding({ bottom: $r('app.float.size_70') })
        if (this.viewState != ViewStateConstant.VIEW_STATE_LOADING)
          Button($r('app.string.press_retry'))
            .width($r('app.float.size_120'))
            .height($r('app.float.size_35'))
            .backgroundColor($r('app.color.color_main_background'))
            .fontColor($r('app.color.color_fff'))
            .onClick(() => {
              this.retryCallback?.()
            })
      }
      .width('100%').height('100%').alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.Center)
    }
  }

  /**
   * 转换图片
   * @returns
   */
  convertImage() {
    switch (this.viewState) {
      case ViewStateConstant.VIEW_STATE_LOADING:
        return $r('app.media.loading')
        break
      case ViewStateConstant.VIEW_STATE_ERROR:
        return $r('app.media.loading_error')
        break
      case ViewStateConstant.VIEW_STATE_NETWORK_ERROR:
        return $r('app.media.network_error')
        break
      case ViewStateConstant.VIEW_STATE_EMPTY:
        return $r('app.media.empty')
        break
      default:
        return $r('app.media.loading')
        break
    }
  }

  /**
   * 转换文案
   * @returns
   */
  convertValue() {
    switch (this.viewState) {
      case ViewStateConstant.VIEW_STATE_LOADING:
        return $r('app.string.loading')
        break
      case ViewStateConstant.VIEW_STATE_ERROR:
        return $r('app.string.load_error')
        break
      case ViewStateConstant.VIEW_STATE_NETWORK_ERROR:
        return $r('app.string.net_error')
        break
      case ViewStateConstant.VIEW_STATE_EMPTY:
        return $r('app.string.load_empty')
        break
      default:
        return $r('app.string.load_success')
        break
    }
  }
}