# nodejs-executable-app

[Blog post](https://codesnip.sh/posts/building-standalone-nodejs-executables)

Build single executable applications for Node.js.

This repo demonstrates how to use the new Node.js API to create an executable
application from a bundle.

I only tested for Linux and Darwin targets. I took a stab at implementing it
(see `build_sea_windows` in `build.sh`, but it's not tested, so I have the
script print an error to alert you. Note that emitting Windows executables is
supported by the Node.js API (see [docs]), so it might work. If someone with a
Windows machine wants to test (and maybe tune) it, that would be cool.

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
