const path = require('path');
const childProcess = require('child_process');
const fs = require('fs');

const terminal = require('./terminal');
const files = require('./files');

const DRY_RUN = process.env['DRY_RUN'] && process.env['DRY_RUN'] === 'true';
const VERBOSE = process.env['VERBOSE'] && process.env['VERBOSE'] === 'true';

const currentPath = path.resolve(__dirname);
const installationsPath = path.join(currentPath, './../installations');

// Go through installations directory
const installDirs = files.getDirectoryList(installationsPath);

(async () => {

  const install = async dirName => {
    terminal.blue(`\nInstalling ${dirName}:`);
    const installPath = path.join(dirName, 'install');
    try {
      // First check if installation file is executable
      try {
        // This throws an error if there's no access
        fs.accessSync(installPath, fs.constants.X_OK);
      }
      catch (ex) {
        terminal.red('\ninstall file is not executable\n');
        terminal.yellow('Run `chmod +x ' + installPath + '`\n');

        process.exit(1);
      }

      // If we got here, then we have permission to execute the installation file
      await terminal.runShellFile(installPath);
    }
    catch (ex) {
      terminal.red('\nERROR :: Failed to install ' + dirName + '\n');
      terminal.red(ex.toString());

      let continueInstallation = false;
      await terminal.confirmAction('Would you like to continue with installation process?', () => {
        continueInstallation = true;
        return Promise.resolve();
      });

      if (!continueInstallation)
        process.exit(1);
    }
  };

  const shouldInstall = async dirName => {
    // check for description in directory
    const descriptionFile = path.join(dirName, 'DESCRIPTION');
    if (files.fileExists(descriptionFile)) {
      terminal.cyan(terminal.separator() +
                    fs.readFileSync(descriptionFile).toString() +
                    terminal.separator());
    }
    else {
      terminal.cyan(terminal.separator() +
                    dirName.substr(dirName.lastIndexOf('/') + 1) +
                    '\n' + 
                    terminal.separator());
    }

    await terminal.confirmAction('Would you like to install?', () => {
      if (DRY_RUN) {
        terminal.yellow('  --> dry run: skipping installation');
        return Promise.resolve();
      }

      return install(dirName);
    });
  }

  for (let i=0; i<installDirs.length; i++) {
    const dirName = installDirs[i];
    await shouldInstall(dirName);
  }

  terminal.green('\n\nAll Done :)\n\n');

  process.exit(0);
})();
