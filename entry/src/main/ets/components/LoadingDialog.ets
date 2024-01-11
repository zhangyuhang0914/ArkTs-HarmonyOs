/**
 * 通用loading
 */
import { LogUtils } from '../utils/LogUtils'

@CustomDialog
export struct LoadingDialog {
  @State loadingTips: string = '加载中...'
  @State rotateAngle: number = 0
  //弹窗控制器
  controller: CustomDialogController

  aboutToAppear() {
    this.rotateAngle = 360
    LogUtils.debug("Loading展示")
  }

  build() {
    Stack() {
      Column() {
        LoadingProgress().width($r('app.float.size_50')).height($r('app.float.size_50')).color('#3598DB')
        // Image($r('app.media.loading'))
        //   .height($r('app.float.size_50'))
        //   .width($r("app.float.size_50"))
        //   .rotate({ angle: this.rotateAngle })
        //   .animation({
        //     duration: 500,
        //     iterations: -1,
        //     curve: Curve.Friction
        //   })
        Text(this.loadingTips)
          .fontSize($r('app.float.size_text_15'))
          .margin({ top: $r('app.float.size_10') })
      }
      .justifyContent(FlexAlign.Center)
      .height($r('app.float.size_150'))
      .width($r('app.float.size_150'))
      .backgroundColor($r('app.color.color_white'))
      .border({ radius: $r('app.float.size_5') })
    }
  }
}