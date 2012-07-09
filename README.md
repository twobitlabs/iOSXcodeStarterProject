# iOS Xcode Starter Project

An iOS Starter Project configured for unit/functional testing and analytics that we use to start our pjects at  [Two Bit Labs](http://twobitlabs.com)

### Features

* ARC enabled with Storyboards 
* Univesal app to support both iPhone and iPad
* [AnalyticsKit](https://github.com/twobitlabs/AnalyticsKit) to support optional integration of analytics providers like TestFlight, Flurry, Apsalar, Localytics, etc... Only the TestFlight SDK is included by default.
* Specta, Expecta, and OCMock to support TDD and BDD style iOS Development with Mock objects
* Seperate unit test and functional test target to separate out fast running tests from slow running tests
* MagicalRecord which makes working with Core Data enjoyable
* Development, Debug, and Release configurations (with support for multiple app id's) so you can install both the developemnt and release versions of the app on your devices side by side
* An NSURLCache configured with sensible memory defaults
* Code that triggers periodic memory warnings in the simulator so your app behaves more like it does on device
* A customized user agent string for UIWebViews
* An app delegate method to enable and disable the network activity indicator that counts the number of callers so it doesn't become disabled until the last caller disables it

### Getting Started

```bash
cd ~/src # or wherever you keep your code
bash <(curl -Lo- http://bit.ly/ios-starter-project)
```

### Contributors

Add your name here if you send us a pull request

* [Two Bit Labs](http://twobitlabs.com)
* [Todd Huss](http://twobitlabs.com)
* [Christopher Pickslay](http://twobitlabs.com)
* [Susan Detwiler](http://twobitlabs.com)

