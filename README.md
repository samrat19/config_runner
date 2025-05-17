# 📦 config_runner

**Version:** 0.0.3  
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

## 📄 License

> ⚠️ License not specified. Check the [GitHub repository](https://github.com/samrat19/config_runner) for updates.

---

## 📫 Support & Contributions

Found a bug? Have a feature request? Want to contribute? Head over to the [GitHub repository](https://github.com/samrat19/config_runner) and open an issue or pull request.

---
