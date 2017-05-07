# GLXSegmentedControl
[![CocoaPods](https://img.shields.io/cocoapods/v/GLXMacDrawerController.svg)](https://cocoapods.org/pods/GLXSegmentedControl) [![license MIT](http://img.shields.io/badge/license-MIT-orange.png)](http://opensource.org/licenses/MIT) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Description
- Written in Swift.
- Auto layout based.
- Supports both layer backed and non-layer backed views.
- Supports instantiation via storyboards.
- Still a work in progress so new features are coming very soon. Contributions are welcome.

## Installation

### Carthage
Add 
`github "glenmax-ltd/GLXMacDrawerController"` 
to your Cartfile.

### CocoaPods
Add 
`pod 'GLXMacDrawerController'` 
to your Podfile.

### Manual
Drag `GLXMacDrawerController.swift` into your Xcode project.

## Initialisation

### Storyboards

#### Step 1
Add 3 new `NSViewController` scenes to your storyboard.

#### Step 2
Change the class of the first view controller to `GLXMacDrawerController`

#### Step 3
Ctrl-drag from the `GLXMacDrawerController` to the other two view controllers (one at a time). When prompted, select 'Custom' for the segue type.

#### Step 4
Now select the created segues and ensure that they have an identifier of "center_controller" for the center controller and "left_controller" for the left controller.

That's it! You are now good to go ;)

### Programatically
If you prefer to instantiate a drawer controller yourself you can use a convenience initialiser `init(leftController:,centerController:)`. Alternatively, you can use any other `NSViewController` initialisers and then set left and center view controllers yourself.

### Usage
Drawer controller adds a computed property to the `NSViewController` which lets you access it.

To open a drawer call `self.drawer?.open(animated:)`. To close it call `self.drawer?.close(animated:)`.

By default sibling `NSView`s are transparent and expose the contents of the views behind them. This is clearly not a desired behaviour. To prevent it, center view controller is placed inside of `NSBox`. Its background color can be changed via the `self.drawer?.centerViewBackgroundColor` property.

