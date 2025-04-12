# 20Break

20Break is a macOS productivity app designed to help you follow the 20-20-20 method effortlessly. By reminding you every 20 minutes to look at something 20 meters away for 20 seconds, 20Break reduces eye strain during extended screen use. It integrates seamlessly into your workflow with a sleek UI.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [How It Works](#how-it-works)
- [Installation](#installation)
- [Configuration](#configuration)
- [Requirements](#requirements)
- [Caveats & Disclaimer](#caveats--disclaimer)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## Overview

20Break sits discreetly in your macOS menu bar and automates periodic reminders following the 20-20-20 rule. Customizable timers gently encourage short, effective breaks. The app's modern design features custom-rounded corners, achieved through method swizzling.

---

## Features

- **Menu Bar Integration:** Easily accessible right from your macOS menu bar.
- **Custom Rounded Corners:** A clean and modern UI utilizing customized rounded popovers.
- **Automated 20-20-20 Timer:** Automatically prompts you every 20 minutes to take an eye-rest break.
- **Gentle Break Prompts:** Subtle reminders to look away from your screen, improving productivity and eye health.
- **Configurable Durations:** Personalize your work and break intervals through the intuitive settings panel.

---

## How It Works

- **Automatic Session Management:**  
  Start a work session from your menu bar, and 20Break takes care of periodic reminders according to the 20-20-20 rule.
  
- **Custom UI Implementation:**  
  Achieves uniquely rounded popover windows using method swizzling to override private macOS APIs.

- **Persistent Settings:**  
  Preferences are stored using `UserDefaults`, ensuring your customizations persist across sessions.

---

## Installation

1. **Download:**  
   Obtain the latest `.dmg` release from the [Releases](https://github.com/YourUsername/20Break/releases) page.

2. **Install:**  
   Open the downloaded `.dmg` file and drag the **20Break** app into your **Applications** folder. Launch the app from there.

---

## Configuration

- **Timer Customization:**  
  Adjust your preferred work and break durations from the app's built-in settings.

- **UI Personalization:**  
  For further UI tweaks, edit the `kWindowCornerRadius` constant within the source code to modify the rounded corner radius.

---

## Requirements

- **macOS:** Version 12.0 (Monterey) or later  
- **Xcode:** Version 14 or later (if compiling from source)

---

## Caveats & Disclaimer

> **Important:**  
> 20Break utilizes method swizzling to override private macOS APIs (`_cornerMask`, `_cornerMaskChanged`) to achieve its unique interface. This approach is experimental and may stop working with future macOS updates. Use with caution, particularly if you intend to submit the app to the Mac App Store.

---

## Contributing

Contributions, bug reports, and suggestions for improvements are welcome. Please open an issue or submit a pull request.

---

## License

20Break is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
