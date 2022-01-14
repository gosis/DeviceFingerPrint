# DeviceFingerPrintSDK
Library to create/return unique device identifier

## Install as xcframework
- Compile AggregateFramework target to create .xcframework
- Locate created xcframework in top level xcframework folder
- Drag the xcframework to your project /frameworks folder
- Don't forget to select Copy files if needed and check to add to your projects target
- See usage section

## Install as dependency
- Copy DeviceFingerPrintSDK folder to the top level of your project (same folder as your .xcodeproj)
- Drag and drop `DeviceFingerPrintSDK.xcodeProj` file to top level of your project in Xcode project navigator
- In your project go to General -> Frameworks, Libraries and embed content
- Tap the + button to add new framework
- Locate `DeviceFingerPrintSDK` and select it
- See usage section

# Usage 
- Add `import DeviceFingerPrintSDK` on top swift class where `deviceId` will be used  
- Call `Device.deviceId(forceReplace: false)` to return existing `deviceId` or create a new one
- Call `Device.deviceId(forceReplace: true)` to force creation of a new `deviceId`



# Import as xcframework
- More convenient and future proof approach to import and distribute dependencies
- Supports simulator, devices with a single xcframework file
- Can be compiled starting Xcode 12

## Pros
- No need for separate frameworks for simulator and device
- Supports arm64
- No need to strip architectures when submitting to app store

## Cons
- All dependencies for xcframework must contain arm 64 slices.

# Import as framework (dependency)
- Easier drag and drop approach
- Xcode compiles framework for you when you compile main project

## Pros
- Can include old objective - C dependencies only having 32 bit slices
- Can easily adjust/fix issues in source code
- Can see documentation in source code

## Cons 
- Will loose support from apple as xcframework will be preffered
- Exposes source code, must use lipo to distribute framework without source code


# Device Id
- DeviceId property is a UUID stored in devices keychain
- When user provisions a new device a new deviceId must generated via `Device.deviceId(forceReplace: true)`
- Device id can be used to uniquely identify a user session for his device 
- Between app reinstalls `deviceId` persists in keychain 
- Only when user logs in `deviceId` must be changed
- Device Id is not accessible by other apps, but it can be if we provide shared access group to its keychain item
