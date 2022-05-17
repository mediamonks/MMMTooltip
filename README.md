# MMMTooltip

[![Build](https://github.com/mediamonks/MMMTooltip/actions/workflows/build.yml/badge.svg)](https://github.com/mediamonks/MMMTooltip/actions/workflows/build.yml)

Simple, auto-layout based, customizable tooltip.

(This is a part of `MMMTemple` suite of iOS libraries we use at [MediaMonks](https://www.mediamonks.com/).)

## Installation

Podfile:

```ruby
source 'https://github.com/mediamonks/MMMSpecs.git'
source 'https://cdn.cocoapods.org/'
...
pod 'MMMTooltip'
```

SPM:

```swift
.package(url: "https://github.com/mediamonks/MMMTooltip", .upToNextMajor(from: "0.1.0"))
```

## Example

![MMMTooltip](https://github.com/mediamonks/MMMTooltip/raw/main/Example.gif)

## Usage

A very simple example, have a look at the docs for `MMMTooltip.Style` and
`MMMTooltip.attachToView` for more info.

```swift
let tip = MMMTooltip.attachToView(
	button, // We attach the tooltip to the button.
	contentView: label, // We have a simple label as the contentView, can be any UIView.
	style: .init(location: .topCenter), // Location is the position for the arrow.
	animation: .fadeAndSlide(duration: 0.4, distance: 10), // Use the fadeAndSlide animation.
	dismissal: .timer(interval: 3) // Auto-dismiss after 3 seconds.
)

// Now we can manually dismiss using:
tip?.dismiss(animated: true)
```

## Ready for liftoff? 🚀

We're always looking for talent. Join one of the fastest-growing rocket ships in
the business. Head over to our [careers page](https://media.monks.com/careers)
for more info!
