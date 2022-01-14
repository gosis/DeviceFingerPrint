# ``DeviceFingerPrintSDK``

SDK to access deviceId for device identification


## Install as dependency (framework)

- Drag and drop DeviceFingerPrintSDK into your xcode project workspace
- Don't forget to select `Copy items if needed` flag
- Got to your Project workspace select General -> Frameworks, Libraries and embed content
- Tap plus button under Frameworks, Libraries and embed content and locate DeviceFingerPrintSDK
- See usage section of this document

## Install as xcframework

- Compile AggregateFramework target in DeviceFingerPrintSDK project to create xcframework
- Output xcframework will be created in top level xcframework folder
- Drag  .xcframework file to your projects  /frameworks folder in Project navigator
- See usage section of this document

# Usage 

- Add `import DeviceFingerPrintSDK` or  at the top of swift class where you want to use deviceId
- Use `Device.deviceId(forceReplace: false)` to create deviceId or return existing deviceId
- Use `Device.deviceId(forceReplace: true)` to create and return a new deviceId



# Delivery options

- Starting Xcode 12 xcframework is a better future proof solution
- Below Xcode 12 framework dependency is the most convenient approach
- If installment as dependency is not possible below Xcode 11 you have to lipo a fat framework

## Pros for xcframework
- Doesn't need to be recompiled for different architectures, simulator or device
- One size fits all solution

## Cons for xcframework
- Cannot be compiled if source contains a dependency (pod) that only contains 32 bit slice 

## Pros for dependency
- Easy drag and drop setup
- Can inspect/adjust source code if needed
- Framework supports dependencies (pods) with only 32 bit slices

## Cons for dependency 
- Exposes source code
- Can go wrong because of Xcode bugs when dragging and dropping or adding files


# Device Id
- Device id is a unique UUID used to identify device for provisioned user
- If user reprovisions his device (logs off and back in again) the deviceId must be regenrated using `Device.deviceId(forceReplace: true)`
- DeviceId doesn't change if user reinstalls his app and it's unique for this app using this device in this login session
