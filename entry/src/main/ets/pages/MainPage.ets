import { CommonHeader, CommonFooter } from '../components/CommonComponents'
import { RoutePath } from '../route/RoutePath'
import { Router } from '../route/Router'
import common from '@ohos.app.ability.common';
import UIAbility from '@ohos.app.ability.UIAbility'
import featureAbility from '@ohos.ability.featureAbility';
import uri from '@ohos.uri';

@Entry
@Component
struct MainPage {
  @State handleTopList: Array<any> = [
    {
      catId: 'jtyw',
      catName: '交通要闻',
      url: RoutePath.NewNoticeTab,
      catSrc: $r('app.media.traffic_news')
    },
    {
      catId: 'tzgg',
      catName: '通知公告',
      isParent: 1,
      url: RoutePath.NewNoticeTab,
      catSrc: $r('app.media.notice')
    },
    {
      catId: 'tzdd',
      catName: '厅直动态',
      isParent: 1,
      url: RoutePath.NewNoticeTab,
      catSrc: $r('app.media.hall_dynamics')
    }
  ]
  @State handleBottomList: Array<any> = [
    {
      catId: 'szsm',
      catName: '市州扫描',
      isParent: 1,
      url: RoutePath.NewNoticeTab,
      catSrc: $r('app.media.city_scan')
    },
    {
      catId: 'ztbxx',
      catName: '招标投标',
      isParent: 1,
      url: RoutePath.NewNoticeTab,
      catSrc: $r('app.media.tender_bidding')
    },
    {
      catId: 'ehb',
      catName: '鄂汇办',
      isParent: 1,
      catSrc: $r('app.media.ehb')
    }
  ]
  @State topList: Array<String> = ['jtyw', 'tzgg', 'tzdt']
  @State bottomList: Array<String> = ['szsm', 'ztbxx']
  private context: common.UIAbilityContext

  public launchEhbApp() {
    let want = {
      bundleName: 'cn.cty.hbzw',
      abilityName: 'ehb',
      uri: 'ehb://ehbandroidapp/startapp?packageName=/cn.cty.hbzw'
    }
    console.log('launchEhbApp')
    console.log('want', want)
    try {
      featureAbility.startAbility({
        want: {
          bundleName: ''
        }
      })
      // this.context.startAbility(want, (error) => {
      //   if (error.code) {
      //     // 处理业务逻辑错误
      //     console.log(`startAbility failed, error.code: ${JSON.stringify(error.code)} error.message: ${JSON.stringify(error.message)}`)
      //     return
      //   }
      //   // 执行正常业务
      //   console.log('startAbility succeed')
      // })
    } catch (paramError) {
      // 处理入参错误异常
      console.log('error.code: ' + JSON.stringify(paramError.code) + ' error.message: ' + JSON.stringify(paramError.message))
    }
  }

  build() {
    Column() {
      Flex({ direction: FlexDirection.Column }) {
        CommonHeader()
        Divider().strokeWidth(8).color('#F1F3F5')

        Column() {
          GridRow({ gutter: 16 }) {
            ForEach(this.handleTopList, (item: any, index: number) => {
              GridCol({
                span: { xs: 4, sm: 4, md: 4, lg: 4, xl: 4, xxl: 4 }
              }) {
                Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
                  Image(item.catSrc).width('80%').height('80%').backgroundImageSize({ width: '100%', height: '100%' }).objectFit(ImageFit.Contain)
                  Text(item.catName).fontColor(Color.Black).fontSize($r('app.float.size_text_18'))
                }.width('100%').height('100%').onClick(() => {
                  if (item.catId === 'ehb') {
                    this.launchEhbApp()
                    return
                  }
                  Router.push('pages/tabs/TabPage', {
                    flag: 'top',
                    activeId: index,
                    catId: item.catId
                  })
                })
              }.width($r('app.float.size_150')).height($r('app.float.size_150')).padding($r('app.float.size_10'))
            })
            ForEach(this.handleBottomList, (item: any, index: number) => {
              GridCol({
                span: { xs: 4, sm: 4, md: 4, lg: 4, xl: 4, xxl: 4 }
              }) {
                Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
                  Image(item.catSrc).width('80%').height('80%').backgroundImageSize({ width: '100%', height: '100%' }).objectFit(ImageFit.Contain)
                  Text(item.catName).fontColor(Color.Black).fontSize($r('app.float.size_text_18'))
                }.width('100%').height('100%').onClick(() => {
                  if (item.catId === 'ehb') {
                    this.launchEhbApp()
                    return
                  }
                  Router.push('pages/tabs/TabPage', {
                    flag: 'bottom',
                    activeId: index,
                    catId: item.catId
                  })
                })
              }.width($r('app.float.size_150')).height($r('app.float.size_150')).padding($r('app.float.size_10'))
            })
          }
        }
        .flexGrow(1).margin({ top: $r('app.float.size_50'), left: $r('app.float.size_24'), right: $r('app.float.size_24') })
        CommonFooter().width('100%').height($r('app.float.size_70'))
      }
    }
  }
}