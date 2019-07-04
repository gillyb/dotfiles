const readline = require('readline');
const childProcess = require('child_process');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

/**
 * This is for running a shell/bash file.
 * It will run in a child process and pass all
 * output/input to the current process shell.
 **/
const runShellFile = (filename) => {
  return new Promise((resolve, reject) => {
    const child = childProcess.spawn(filename);
    rl.on('line', data => {
      // We need to append the '\n' so the child process will receive the 'enter' key as well
      child.stdin.write(data + '\n');
    });
    child.stdout.on('data', data => {
      process.stdout.write(data);
    });
    child.on('close', () => {
      resolve();
    });
    child.on('error', () => {
      console.log('An error occurred');
      reject();
    });
  });
};

/**
 * Asks the user a question, and checks their response.
 * If they type 'y' or 'yes' (case insensitive) then it
 * will invoke 'action'.
 * 'action' must be a callback that returns a promise!
 *
 * If the user types anything else, then it will still
 * resolve the promise (since this isn't an actual 'failure')
 **/
const confirmAction = (question, action) => {
  return new Promise((resolve, reject) => {
    rl.question(question + ' [yes/no]\n', answer => {
      const isYes = answer.toLowerCase() === 'y' || answer.toLowerCase() === 'yes';
      if (isYes) {
        return action().then(() => {
          return resolve(true);
        });
      }

      return resolve(false);
    });
  });
};

/**
 * Text styles in the terminal
 **/
const colorMap = {
  black: "\033[30m",
  gray: "\033[1;30m",
  red: "\033[31m",
  green: "\033[32m",
  yellow: "\u001b[33m",
  blue: "\033[34m",
  cyan: "\033[36m",
  underline: "\033[4m",
  reset: "\033[0m",
  clearLine: "\r\033[K",
  bold: "\033[1m"
};

const separator = () => (new Array(process.stdout.columns + 1)).join('=');

const black = (str) => console.log(colorMap.black + str + colorMap.reset);
const gray = (str) => console.log(colorMap.gray + str + colorMap.reset);
const red = (str) => console.log(colorMap.red + str + colorMap.reset);
const green = (str) => console.log(colorMap.green + str + colorMap.reset);
const yellow = (str) => console.log(colorMap.yellow + str + colorMap.reset);
const blue = (str) => console.log(colorMap.blue + str + colorMap.reset);
const cyan = (str) => console.log(colorMap.cyan + str + colorMap.reset);
const underline = (str) => console.log(colorMap.underline + str + colorMap.reset);
const reset = () => console.log(colorMap.reset);
const clearLine = (str) => console.log(colorMap.clearLine + str + colorMap.reset);
const bold = (str) => console.log(colorMap.bold + str + colorMap.reset);


module.exports = {
  confirmAction, runShellFile,
  black, gray, red, green, yellow, blue, cyan, underline,
  reset, clearLine, bold,
  separator
};
