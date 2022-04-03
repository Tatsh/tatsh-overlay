module.exports = {
  logConfig: {
    filename: '/var/log/zwave-js/zwave-js',
    forceConsole: false,
    logToFile: true,
    level: 'error',
  },
  storage: {
    cacheDir: '/var/cache/zwave-js',
    deviceConfigPriorityDir: '/var/lib/zwave-js',
  },
  securityKeys: require('./zwave-js-server.keys.js'),
}
