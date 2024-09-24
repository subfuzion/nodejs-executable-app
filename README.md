# nodejs-executable-app

Build single executable applications for Node.js.

This repo demonstrates how to use the new Node.js API to create an executable
application from a bundle.

I only tested on Linux and MacOS, but not on Windows, which is why I have the
script report an error for that target. Just note that emitting Windows 
executables is actually supported by the Node.js API (see [docs]).

Notes

* Webpack is used for bundling. I plan to demonstrate with other bundlers.
* The entry point for the webpack config for my example is `./bin/app`, which
  was an executable Node.js script with a shebang line. Update the config to
  point to whatever your app's entry point is.
* The SEA config file uses `disableExperimentalSEAWarning` to suppress the
  experimental warning displayed when running a generated executable. This
  only works for Node.js `20.2.0` and later.

[docs]:
https://nodejs.org/api/single-executable-applications.html#single-executable-applications

[issue]:
https://github.com/nodejs/node/issues/50547
