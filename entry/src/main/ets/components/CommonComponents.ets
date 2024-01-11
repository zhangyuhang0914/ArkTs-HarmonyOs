import router from '@ohos.router'
import window from '@ohos.window'
import { LogUtils } from '../utils/LogUtils'

/**
 * 通用Header组件
 */
@Component
export struct CommonHeader{
  @State statusBarHeight: number = 0

  aboutToAppear() {
    this.setSystemStatusBar()
  }

  // 设置系统状态栏
  setSystemStatusBar() {
    let context = getContext(this)
    window.getLastWindow(context, (error, data) => {
      //1、设置系统状态栏
      let avoidArea = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      //这里为什么要自己设置一个高度？因为系统返回的高度太高了，并不能正确的返回系统状态栏的高度，自己二次设置一个接近的值
      avoidArea.topRect.height = 90
      this.statusBarHeight = avoidArea.topRect.height
      let bottomHeight = avoidArea.bottomRect.height
      //2、设置系统状态栏颜色---该API废弃了，统一返回801，目前没找到好的方法设置状态栏文字的颜色，放弃了。。。。。。
      const systemBarProperties: window.SystemBarProperties = {
        //顶部状态栏颜色
        statusBarColor: "#00ff0000",
        statusBarContentColor: "#ffff00",
        isStatusBarLightIcon: true
      }
      data.setWindowSystemBarProperties(systemBarProperties, (err, result) => {
        LogUtils.debug("设置状态栏结果码", `${err.code}`)
        if (err.code == 0) {
          LogUtils.debug("状态栏设置成功")
        } else {
          LogUtils.debug("状态栏设置失败", `${err.message}`)
        }
      })
    })
  }

  build() {
    Column() {
      Stack() {
        Image($r('app.media.header'))
        Stack({ alignContent: Alignment.Center }) {
          Text('湖北省交通运输厅')
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .fontSize(24)
            .padding({ top: 24 })
        }
        .width("100%")
        .height($r('app.float.size_50'))
      }
      .width("100%")
      .height('100%')
    }
    .width('100%')
    .height(this.statusBarHeight)
  }
}

/**
 * 通用Footer组件
 */
@Component
export struct CommonFooter{
  build() {
    Row() {
      Image($r('app.media.footer'))
    }
      .width('100%')
      .height('100%')
  }
}

/**
 * 通用返回Header组件
 */
@Component
export struct BackHeader {
  @Prop title: string
  @Prop alpha: number
  @State statusBarHeight: number = 0
  private titleAlignment: TextAlign = TextAlign.Center
  private backButton: boolean = true
  private onBackClick?: () => void

  aboutToAppear() {
    this.setSystemStatusBar()
  }

  // 设置系统状态栏
  setSystemStatusBar() {
    let context = getContext(this)
    window.getLastWindow(context, (error, data) => {
      //1、设置系统状态栏
      let avoidArea = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      //这里为什么要自己设置一个高度？因为系统返回的高度太高了，并不能正确的返回系统状态栏的高度，自己二次设置一个接近的值
      avoidArea.topRect.height = 90
      this.statusBarHeight = avoidArea.topRect.height
      LogUtils.debug("顶部状态栏的高度", `${this.statusBarHeight}`)
      let bottomHeight = avoidArea.bottomRect.height
      LogUtils.debug("底部系统导航栏的高度", `${bottomHeight}`)
      //2、设置系统状态栏颜色---该API废弃了，统一返回801，目前没找到好的方法设置状态栏文字的颜色，放弃了。。。。。。
      const systemBarProperties: window.SystemBarProperties = {
        //顶部状态栏颜色
        statusBarColor: "#ffffff",
        statusBarContentColor: "#ffffff",
        isStatusBarLightIcon: true
      }
      data.setWindowSystemBarProperties(systemBarProperties, (err, result) => {
        LogUtils.debug("设置状态栏结果码", `${err.code}`)
        if (err.code == 0) {
          LogUtils.debug("状态栏设置成功")
        } else {
          LogUtils.debug("状态栏设置失败", `${err.message}`)
        }
      })
    })
  }

  build() {
    Column() {
      Blank()
        .backgroundColor($r('app.color.color_main_background'))
        .opacity(this.alpha)
      Stack({ alignContent: Alignment.Start }) {
        Stack()
          .width('100%')
          .height($r('app.float.size_50'))
          .opacity(this.alpha)
          .backgroundColor($r('app.color.color_main_background'))
        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
          Text(this.title)
            .flexGrow(1)
            .textAlign(this.titleAlignment)
            .fontColor($r('app.color.color_white'))
            .fontSize($r('app.float.size_text_18'))
            .align(Alignment.Center)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .height($r('app.float.size_50'))
        .margin({ left: $r('app.float.size_50'), right: $r('app.float.size_50') })
        .alignSelf(ItemAlign.Center)
        if (this.backButton) {
          Stack() {
            Image($r('app.media.ic_public_arrow_left'))
              .height($r('app.float.size_24'))
              .width($r('app.float.size_24'))
              .align(Alignment.Center)
              .onClick(() => {
                this.onBackClick?.()
                router.back()
              })
          }
          .height($r('app.float.size_50'))
          .width($r('app.float.size_50'))
        }
      }
      .height($r('app.float.size_50'))
      .width("100%")
    }.height(this.statusBarHeight)
  }
}
