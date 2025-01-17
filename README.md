# X-center Video App
## Overview
X-center Video App is a mobile application built using the Flutter framework. The app provides an engaging experience where users can:
1. Authenticate using email and password through Firebase.
2. View a home screen with 15-20 static videos that are vertically scrollable and playable on each scroll.
3. Comment on videos, with comments stored locally using the Hive database.
4. Auto-generate comments after 5 seconds if the user does not input any.
5. Share specific videos.
6. Experience seamless app state management with `flutter_bloc`.

## Features

### User Authentication
- Registration: Users can register using their email, password, and full name.
- Login: Users can log in using their email and password.
- Authentication is managed using Firebase.

### Home Screen
- Displays 15-20 static videos that can be scrolled vertically.
- Each video starts playing automatically when in view.

### Commenting System
- Users can comment on specific videos.
- Comments are stored locally using the Hive database.
- If no comment is entered within 5 seconds, a bot auto-generates a random comment for the video.

### Video Sharing
- Users can share specific videos via social media or other platforms.

### State Management
- The app uses `flutter_bloc` for efficient and scalable state management.

## Installation Instructions
### Prerequisites
1. Flutter: Ensure Flutter is installed on your system. You can download it from [flutter.dev](https://flutter.dev/).
2. Firebase Setup: Configure a Firebase project and download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS).
   or, we can setup firebase through firebase cli where this documentation will help us-> https://firebase.flutter.dev/docs/cli/

3. Dependencies**: The app uses several Flutter packages:
  firebase_auth: For user authentication.
  hive: For local database storage.
  flutter_bloc: For state management.
  video_player: For video playback.
  share_plus: For video sharing.
  flutter_screenutil: for screen UI adjustment and responsivenes
  equatable: it aslo includes in flutter_bloc
  firebase_core: Initialize Firebase in a Flutter project as we can used like this: 
    void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
  cloud_firestore: to store and sync data between users and devices in real-time
  firebase_database: its also store and retrieve data in realtime 
  build_runner:
  hive_generator:to store custom objects, define a model class and annotate it with @HiveType to generate code using hive_generator.  we can run by this command: 
                    flutter pub run build_runner build
  hive_flutter: we can initlize like this in main : 
        Directory directory = await pathProvider.getApplicationDocumentsDirectory();
        Hive.init(directory.path);
        await Hive.initFlutter();
        Hive.registerAdapter(CommentModelAdapter());
        Hive.openBox<CommentModel>("comments");

  share_plus: to share eitehr url, docs, file etc, here i used to share url of the videos,

### Steps to Set Up the Project

1. Clone the Repository**
   ```bash
   git clone https://github.com/sznpok/xcenter_app.git
   cd xcenter_app

2. Install Dependencies**
   flutter pub get
3. Set Up Firebase
   - Add `google-services.json` to the `android/app` directory.
   - Add `GoogleService-Info.plist` to the `ios/Runner` directory.
   - Ensure Firebase is configured in the `pubspec.yaml` file.
5. Run the App: using this command
   flutter run

## Usage
### Register and Login
- Open the app and register using your email, password, and full name.
- Log in with the registered credentials.

### Home Screen
- Scroll through the 20 videos displayed vertically.
- Each video plays automatically when in view.

### Comment on Videos
- Tap on the comment icon for any video.
- Enter your comment in the provided field.
- If no comment is added within 5 seconds, a bot generates and saves a random comment.

### Share Videos
- Tap on the share icon to share the specific video.

---

## Folder Structure
lib/
├── constant/             # Stores global constants for the app
│   ├── app_colors.dart         # Predefined app color constants
│   ├── image_constant.dart     # References for images stored in the assets folder
│
├── module/                        # Main application features and modules
│   ├── auth/                      # Handles authentication-related functionality
│   │   ├── auth_bloc/             # Contains Bloc logic for authentication
│   │   ├── repo/                  # Contains repositories for managing authentication data
│   │   ├── view/                  # UI screens for authentication (e.g., login, registration)
│   │
│   ├── home/                     # Handles home screen functionality
│       ├── bloc/                 # Bloc logic for managing home state
│       ├── model/                # Data models used in the home module
│       ├── services/             # Services provided local_data_services to store data in local app using hive
│       ├── view/                 # UI components and screens for the home module
│       ├── widgets/              # Reusable widgets used within the home module
│
├── routers/                  # Defines app routing logic
│   ├── routers.dart          # Centralized routing for the app, maps paths to pages
│   ├── not_found_page.dart   # Displays when an undefined route is accessed
│
├── utils/                    # Utility classes and global helpers
│   ├── navigator_key.dart    # Provides a globally accessible navigator key for navigation without context
│   ├── snackbar.dart         # Custom Snackbar implementation for app-wide notifications
│   ├── validation_mixin.dart # Validation logic for form fields (email, password, text, etc.)
│
├── widgets/                  # Shared and reusable UI components
│   ├── custom_button.dart    # Custom button widget for consistent design and functionality
│   ├── custom_text_form.dart # Custom text form field widget with validation
│
├── firebase_option.dart  # Firebase configuration options, auto-generated from Firebase setup
├── splash.dart           # Splash screen implementation displayed at app startup
├── main.dart             # Entry point of the Flutter application


## Dependencies
Here is a list of key dependencies used in this project:

  flutter_screenutil: ^5.9.3
  flutter_bloc: ^9.0.0
  video_player: ^2.9.2
  equatable: ^2.0.7
  firebase_core: ^3.10.0
  firebase_auth: ^5.4.0
  cloud_firestore: ^5.6.1
  firebase_database: ^11.3.0
  hive: ^2.2.3
  build_runner: ^2.4.14
  hive_generator: ^2.0.1
  hive_flutter: ^1.1.0
  share_plus: ^10.1.4

Add these to your pubspec.yaml:
or just run this command in the project terminal : flutter pub add dependency_name
for eg : flutter pub add flutter_screenutil

##Thank You##

