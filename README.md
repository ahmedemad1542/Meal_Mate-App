# Meal Mate 🍽️
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/ahmedemad1542/Meal_Mate-App)

Meal Mate is a comprehensive meal and recipe management application built with Flutter. It allows users to save personal recipes, discover new meals from around the world, and get intelligent recipe suggestions from an AI-powered cooking assistant. The app also includes handy health calculators to help users track their fitness goals.

---

## ✨ Features

- **Local Recipe Management**: Add, view, update, and delete your own recipes with details like name, cooking time, description, rating, and photos. Data is stored locally using Hive.
- **Discover Online Meals**: Explore a vast collection of recipes from TheMealDB API. Filter meals by country (area) and category.
- **AI ChefBot**: An intelligent chatbot powered by the Groq API (Llama 3) that suggests recipes based on the ingredients you have on hand.
- **Health Calculators**: Includes a BMI (Body Mass Index) calculator and a Daily Calorie Needs calculator.
- **Personalization**:
  - **Theme**: Switch between a clean light mode and a sleek dark mode.
  - **Language**: Full support for both English and Arabic.
- **User-Friendly Interface**: A clean, responsive UI built with an intuitive navigation system.

---

## 🏛️ Architecture

The project follows a feature-first architecture, separating core functionalities from distinct feature modules. This approach promotes modularity, scalability, and easier maintenance. Each feature (e.g., `chat_bot`, `local_meals`, `online_meals`) is self-contained with its own data, repository, and presentation layers, using the BLoC pattern for state management.

---

## 🛠️ Technology Stack

- **Framework**: Flutter
- **State Management**: `flutter_bloc`
- **Routing**: `go_router`
- **Local Storage**: `hive`
- **Networking**: `dio`
- **AI Integration**: Groq API
- **Localization**: `easy_localization`
- **Permissions**: `permission_handler`
- **UI Toolkit**: `flutter_screenutil`

---

## ⚙️ Configuration

This project requires an API key for the ChefBot feature to function.

1.  Create a file named `.env` in the root of the project.
2.  Add your Groq API key to this file:

    ```env
    GROQ_API_KEY=your_groq_api_key_here
    ```

---

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK installed on your machine. You can find instructions [here](https://flutter.dev/docs/get-started/install).

### Installation

1.  Clone the repository:
    ```sh
    git clone https://github.com/ahmedemad1542/meal_mate-app.git
    ```
2.  Navigate to the project directory:
    ```sh
    cd meal_mate-app
    ```
3.  Create the `.env` file and add your API key as described in the [Configuration](#️-configuration) section.
4.  Install the required dependencies:
    ```sh
    flutter pub get
    ```
5.  Run the build runner to generate necessary files (for Hive and other code generation):
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
6.  Run the app:
    ```sh
    flutter run
    ```

---

## 📦 Releases

You can download the latest APK from the [Releases page](https://github.com/ahmedemad1542/Meal_Mate-App/releases).

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
