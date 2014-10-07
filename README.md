# Adelanto

[![CI Status](http://img.shields.io/travis/aceontech/Adelanto.svg?style=flat)](https://travis-ci.org/aceontech/Adelanto)
[![Version](https://img.shields.io/cocoapods/v/Adelanto.svg?style=flat)](http://cocoadocs.org/docsets/Adelanto)
[![License](https://img.shields.io/cocoapods/l/Adelanto.svg?style=flat)](http://cocoadocs.org/docsets/Adelanto)
[![Platform](https://img.shields.io/cocoapods/p/Adelanto.svg?style=flat)](http://cocoadocs.org/docsets/Adelanto)

## Usage

### ADLVersionManager

ADLVersionManager can be used to display the app's current version and build number
in the iOS Settings panel. In order for this to work, you need to add a
```Settings.bundle``` to your app and add the following section to its ```Root.plist```:

```xml
<dict>
    <key>DefaultValue</key>
    <string></string>
    <key>Type</key>
    <string>PSTitleValueSpecifier</string>
    <key>Title</key>
    <string>Version</string>
    <key>Key</key>
    <string>adl_appVersion</string>
</dict>
```

Modify your ```AppDelegate.m```:

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Add the following line:
    [ADLVersionManager saveVersionFromMainBundle];
    return YES;
}
```

## Requirements

iOS 7+

## Installation

Adelanto is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Adelanto"
```

## Author

Alex Manarpies | [aceontech.com](http://www.aceontech.com) | [@aceontech](https://twitter.com/aceontech)

## License

Adelanto is available under the MIT license. See the LICENSE file for more info.
