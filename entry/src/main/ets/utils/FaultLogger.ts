/**
 * 获取应用程序故障日志
 */

export class QueryFaultLogCallback {
  JSLogCallback (error, value) {
    if (error) {
      console.info('error is ' + error)
    } else {
      console.info("value length is " + value.length)
      let len = value.length
      for (let i = 0; i < len; i++) {
        console.info("log: " + i)
        console.info("Log pid: " + value[i].pid)
        console.info("Log uid: " + value[i].uid)
        console.info("Log type: " + value[i].type)
        console.info("Log timestamp: " + value[i].timestamp)
        console.info("Log reason: " + value[i].reason)
        console.info("Log module: " + value[i].module)
        console.info("Log summary: " + value[i].summary)
        console.info("Log text: " + value[i].fullLog)
      }
    }
  }
}

let queryFaultLogCallback = new QueryFaultLogCallback()
export default queryFaultLogCallback as QueryFaultLogCallback