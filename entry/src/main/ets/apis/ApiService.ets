import { AxiosHeaders } from '@ohos/axios'
import httpClient from '../http/Request'
import axiosClient from '../http/AxiosRequest'

let baseUrl = 'http://jtt.hubei.gov.cn/webspiderweb'

/**
 * 列表-axios客户端请求
 * @param url, page
 * @returns
 */
export function getHandleList(params: any) {
  return httpClient.get<any>({
    url: baseUrl + `/api/haiyun/all?url=${params.url}&page=${params.page}`,
    showLoading: true
  })
}

/**
 * 详情-axios客户端请求
 * @param date
 * @returns
 */
export function getHandleDetail(params: any) {
  return httpClient.get<any>({
    url: baseUrl + `/api/haiyun/info?url=${params.url}&contentUrl=${params.contentUrl}&page=${params.page}&docId=${params.docId}`,
    showLoading: true
  })
}