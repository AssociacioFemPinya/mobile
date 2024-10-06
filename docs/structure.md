# Project Structure Documentation

This repository follows a structured approach to organizing a Flutter project, adhering to clean architecture principles. Below is an overview of the directory structure and the purpose of each directory and key files.

## Directory Structure

```
lib/
├── core/
│   ├── error/
│   ├── network/
│   ├── usecases/
│   ├── utils/
│   └── navigation/
│       └── route_names.dart
├── features/
│   ├── feature_name/
│   │   ├── data/
│   │   │   ├── sources/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── useCases/
│   │   │   ├── enums/
│   │   │   ├── repositories/
│   │   ├── presentation/
│   │   │   ├── blocs/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   │   └── routes.dart
│   │   └── assets/
│   │       ├── images/
│   │       ├── icons/
│   │       └── fonts/
├── main.dart
├── injection_container.dart
└── routes.dart
```

## Structure Overview

### `core/`

Contains fundamental modules and utilities used across the application.

- **`error/`**: Placeholder for error handling classes and exceptions.
- **`network/`**: Manages network-related functionality such as API clients and connectivity checks.
- **`usecases/`**: Defines application-specific use cases.
- **`utils/`**: Utility classes and helper functions.
- **`navigation/`**:
  - **`route_names.dart`**: Centralized route names used throughout the application.

### `features/`

Contains self-contained modules or features of the application.

#### `feature_name/`

Represents a specific feature module.

- **`data/`**:
  - **`sources/`**: Data sources like remote API clients or local storage handlers.
  - **`models/`**: Data models specific to this feature.
  - **`repositories/`**: Implements repositories that define data operations for this feature.

- **`domain/`**:
  - **`entities/`**: Domain entities representing core business objects.
  - **`useCases/`**: Use cases encapsulating the application's business logic.
  - **`enums/`**: TODO.
  - **`repositories/`**: Abstract repository interfaces defining contract for data operations.

- **`presentation/`**:
  - **`blocs/`**: BLoC (Business Logic Component) classes for state management.
  - **`pages/`**: Flutter UI pages related to this feature.
  - **`widgets/`**: Reusable UI components specific to this feature.
  - **`routes.dart`**: Feature-specific routing configuration, integrating with the main app router.

- **`assets/`**: Feature-specific assets such as images, icons, and fonts.

### Other Files

- **`main.dart`**: Entry point of the Flutter application, initializes the app and configures the main app structure.

- **`injection_container.dart`**: Manages dependency injection setup using a container (e.g., `get_it`) for providing dependencies across the app.

- **`routes.dart`**: Centralizes routing configuration for the entire application, integrating all feature-specific routes into a main app router.
