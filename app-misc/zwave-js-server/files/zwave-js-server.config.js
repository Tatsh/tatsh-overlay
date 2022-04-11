module.exports = {
  logConfig: {
    filename: '/var/log/zwave-js-server/zwave-js-server',
    forceConsole: false,
    logToFile: true,
    level: 'error',
  },
  storage: {
    cacheDir: '/var/cache/zwave-js-server',
    deviceConfigPriorityDir: '/var/lib/zwave-js-server',
  },
  securityKeys: require('./zwave-js-server.keys.js'),
}
