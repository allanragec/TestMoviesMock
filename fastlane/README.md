fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios startCharlesWithUI
```
fastlane ios startCharlesWithUI
```
Run Charles With UI
### ios startCharlesWithoutUI
```
fastlane ios startCharlesWithoutUI
```
Run Charles Without UI
### ios stopCharles
```
fastlane ios stopCharles
```

### ios uitests
```
fastlane ios uitests
```
Runs all UI tests

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
