# Instagram Clone App
## Overview
- The Instagram clone app is a mobile application built with Flutter that aims to replicate the core functionalities of the popular social media platform, Instagram. With a sleek and intuitive user interface, users can capture and share photos and videos, explore content from other users, engage with posts through likes and comments, and connect with friends and followers.
## Architecture:
The Instagram Clone App follows the MVVM (Model-View-ViewModel) architecture pattern. This architecture separates the user interface, business logic, and data model into three distinct layers, promoting separation of concerns and maintainability of the codebase. In MVVM:
- **Model:** Represents the data and business logic of the application.
- **View:** Represents the user interface components, responsible for rendering UI elements.
- **ViewModel:** Acts as an intermediary between the View and the Model, handling user interactions, data operations, and updating the View accordingly.
## Features
- **Native Splash Screen and custom Splash screen:**
  - The app features a native splash screen that enhances the user experience during app launch.
  - Utilizes the `flutter_native_splash` package to seamlessly integrate splash screens for both iOS and Android platforms.
  - Supports both light and dark mode, ensuring a consistent and visually appealing loading experience across different themes.
