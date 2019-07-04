const fs = require('fs');
const path = require('path');

const terminal = require('./terminal');

/**
 * Returns a list of directories inside a given directory
 **/
const getDirectoryList = dir => {
  return fs.readdirSync(dir)
    .map(d => path.join(dir, d))
    .filter(d => fs.lstatSync(d).isDirectory());
};

/**
 * Create a symbolic link
 **/
const createSymLink = (existingFilePath, newFilePath) => {
  terminal.yellow(`    symlink: ${newFilePath} --> ${existingFilePath}`); 
  fs.symlinkSync(existingFilePath, newFilePath);
};

/**
 * Check if file exists
 **/
const fileExists = filePath => {
  return fs.existsSync(filePath);
}

module.exports = {
  getDirectoryList,
  createSymLink,
  fileExists
};
