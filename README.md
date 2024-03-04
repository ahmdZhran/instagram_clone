
# Instagram Clone App

## Overview
The Instagram clone app is a mobile application built with Flutter that aims to replicate the core functionalities of the popular social media platform, Instagram. With a sleek and intuitive user interface, users can capture and share photos and videos, explore content from other users, engage with posts through likes and comments, and connect with friends and followers.

## Architecture
The Instagram Clone App follows the MVVM (Model-View-ViewModel) architecture pattern. This architecture separates the user interface, business logic, and data model into three distinct layers, promoting separation of concerns and maintainability of the codebase.

### MVVM Components:
- **Model:** Represents the data and business logic of the application.
- **View:** Represents the user interface components, responsible for rendering UI elements.
- **ViewModel:** Acts as an intermediary between the View and the Model, handling user interactions, data operations, and updating the View accordingly.

## Features

### Native Splash Screen and Custom Splash Screen:
- The app features a native splash screen that enhances the user experience during app launch.
- Utilizes the `flutter_native_splash` package to seamlessly integrate splash screens for both iOS and Android platforms.
- Supports both light and dark mode, ensuring a consistent and visually appealing loading experience across different themes.

### Authentication Feature
The authentication feature allows users to securely sign up, sign in, and reset their password within the application. With a seamless user experience, users can create an account using their email address and password, sign in with their existing credentials, and reset their password if forgotten.

#### Key Functionality:
- **Sign Up:**
  - New users can easily create an account by providing their email address and choosing a password.
  - Upon successful registration, user credentials are securely stored using Firebase Authentication, ensuring data integrity and security.
- **Sign In:**
  - Existing users can sign in to the application using their registered email and password.
  - Firebase Authentication verifies user credentials, granting access to authenticated users only.
- **Forgot Password:**
  - Users who forget their passwords can initiate a password reset process.
  - By providing their registered email address, users receive a password reset link via email to create a new password securely.

#### Technologies Used:
- **State Management:** Utilized the BLoC (Business Logic Component) pattern for efficient state management, ensuring a smooth user experience throughout the authentication process.
- **Firebase Services:**
  - **Firebase Authentication:** Integrated Firebase Authentication to handle user authentication securely, including sign-up, sign-in, and password reset functionalities.
  - **Firebase Cloud Firestore:** Utilized Firebase Cloud Firestore to store user data securely in the cloud, ensuring real-time data synchronization across devices.
- **External App Launcher:** Incorporated the external_app_launcher package to seamlessly launch external apps for password reset functionality, enhancing user convenience.
- **GoRouter:** Employed GoRouter for streamlined navigation between authentication screens, providing users with a cohesive and intuitive user interface.
## Demo
https://github.com/ahmdZhran/instagram_clone/assets/80375430/c486221d-2ced-4ab6-91ed-db27c190cca7

https://github.com/ahmdZhran/instagram_clone/assets/80375430/726a501f-ca51-4ca0-a71d-491c67277865

