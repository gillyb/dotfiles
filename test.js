const fs = require('fs');

fs.accessSync('./installations/zsh/install', fs.constants.W_OK);
console.log('file is accessable');

process.exit(0);
