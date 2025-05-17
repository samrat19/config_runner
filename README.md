# 📦 config_runner

**Version:** 0.0.5 
**Published:** May 17, 2025

`config_runner` is a Dart CLI utility designed to simplify the setup of environment configurations and modular code scaffolding for Flutter projects. It automates the generation of environment files (e.g., dev, uat, prod) and creates a boilerplate module structure including repositories, providers, and screens.

---

## ✨ Features

- 🛠️ Generate environment-specific configurations (`dev`, `uat`, `prod`) with base API URLs.
- 🧱 Creates core application files:
  - `environment.dart`
  - `resource.dart`
  - `status.dart`
- ⚙️ Scaffolds module structure with a single command:
    - `repository/`
    - `provider/`
    - `screen/`
- 💉 Built-in support for `injectable`, `get_it`, and `provider`.
- ⚡ Fast and developer-friendly command-line execution.

---

## 🚀 Getting Started

### 1. Installation

Add `config_runner` to your `pubspec.yaml` under `dev_dependencies`:

```yaml
dev_dependencies:
  config_runner: ^0.0.2
```

Install it with:

```bash
flutter pub get
```

---

## ⚙️ Usage

### Generate Environment Config Files

This command generates configuration files for three environments: `dev`, `uat`, and `prod`, each with a base URL placeholder.

```bash
dart run config_runner:config
```

This creates:
```
lib/api/api_url.dart
lib/api/dev_api_url.dart
lib/api/uat_api_url.dart
lib/api/prod_api_url.dart
```

You can then access the appropriate base URL depending on your build flavor or runtime setup.

---

### Generate a New Feature Module

Scaffold a module with repository, provider, and screen folders using:

```bash
dart run config_runner:config module <ModuleName>
```

Example:
```bash
dart run config_runner:config module PJP
```

Creates:
```
lib/modules/pjp/
├── repository/
├── provider/
└── screen/
```

Each folder contains starter boilerplate code to speed up development.

---

## 🧩 Dependencies

`config_runner` requires to work seamlessly with the following packages:

- [`injectable`](https://pub.dev/packages/injectable)
- [`get_it`](https://pub.dev/packages/get_it)
- [`provider`](https://pub.dev/packages/provider)

Make sure these packages are included in your project to take full advantage of the generated code.

---

## 📁 Output Structure

Here’s a high-level overview of what gets generated:

```
lib/
├── api/
│   ├── dev_api_url.dart
│   ├── uat_api_url.dart
│   └── prod_api_url.dart
└── modules/
    └── <module_name>/
        ├── repository/
        ├── provider/
        └── screen/
```

---


## 📫 Support & Contributions

Found a bug? Have a feature request? Want to contribute? Head over to the [GitHub repository](https://github.com/samrat19/config_runner) and open an issue or pull request.

---

## 📝 License

Created by Atri Das  
Copyright (c) 2025 Atri Das.  
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
- Neither the name of the Fun with Flutter nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL FUN WITH FLUTTER BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
