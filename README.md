dotfiles
==

Install all my apps and configuration settings on a new computer.  
```
$ curl -L https://github.com/gillyb/dotfiles/raw/master/online-install.sh | bash
```


Not using the online installation you can just run
```
$ ./install.sh
```

This will install node, brew and brew-cask and start
the installation process.


Adding a new installation:  
* Create a folder in 'installations'
* Add a 'DESCRIPTION' file with the description of the installation
* Add an executable file called 'install' that will run the installation.
