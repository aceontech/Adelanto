//
// Created by Alex Manarpies on 07/10/14.
//

#import <Foundation/Foundation.h>

/**
* Convenience methods for displaying the app's current version and build number in its settings bundle.
* Make sure to add the following section to your Settings.bundle/Root.plist:
*   <dict>
*       <key>DefaultValue</key>
*       <string></string>
*       <key>Type</key>
*       <string>PSTitleValueSpecifier</string>
*       <key>Title</key>
*       <string>Version</string>
*       <key>Key</key>
*       <string>adl_appVersion</string>
*   </dict>
*/
@interface ADLVersionManager : NSObject

/**
* Parses the main bundle's info and persists the version for a settings bundle to use.
* Default key is: adl_appVersion
*/
+ (void)saveVersionFromMainBundle;

/**
* Parses the main bundle's info and persists the version for a settings bundle to use.
*/
+ (void)saveVersionFromMainBundleWithKey:(NSString *)key;

@end