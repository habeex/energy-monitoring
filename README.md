# 🌞 Flutter Data Monitoring Tool 🌟

## 🌟 Overview

This project is a **Data Monitoring Tool** for customers with solar energy systems such as 🌞 **solar panels**, 🔌 **wallbox**, and ❄️ **heat pumps**. The application visualizes real-time data for power generation and consumption through a 📈 **graph-based interface**.

---

## ✨ Features

### 🧩 Core Functionalities
- **📊 Graph and Data Visualization**
    - 🌞 **Solar Generation**: View solar power generation over time.
    - 🏠 **House Consumption**: View household energy consumption.
    - 🔋 **Battery Consumption**: View battery power consumption.
    - Each metric has its own **tab**, with data represented as **Line Charts** (📅 x-axis: datetime, ⚡ y-axis: watts).
    - 🔄 **Unit Switching**: Toggle between watts and kilowatts.
    - 📅 **Date Filtering**: View data for specific time ranges.
    - 🚀 **Preloading**: Ensures graphs load instantly when switching tabs.

- **🗄️ Caching**
    - Prevent redundant API calls by caching fetched data.
    - 🧹 **Clear Cache**: Option to manually clear cached data.

- **🚨 Error Handling**
    - Provide user-friendly error messages for connectivity issues or API failures.

### 🎁 Nice-to-Haves (Optional)
- 🔄 **Pull-to-refresh** functionality.
- 🌙 **Dark mode** support.
- 🔄 **Data polling** for automatic updates.

### 🧪 Testing
- ✅ **Unit tests** for core logic.
- 🧩 **Widget tests** for UI validation.

---

## 🔌 Provided API

The API is provided as a Dockerized application. Follow these steps to set it up:

1. 📥 Download the resources: [Resources](https://enpalcorepgtechiv.blob.core.windows.net/tech-interview/flutter/20241029_4a832b05/Take_Home_Challenge_Resources.zip).
2. 🚀 Build and run the API:
   ```bash
   cd solar-monitor-api/
   docker build -t solar-monitor-api .
   docker run -p 3000:3000 solar-monitor-api
   ```
3. 🌐 Access the API documentation at: [http://localhost:3000/api-docs](http://localhost:3000/api-docs).

---

## 📦 Packages Used

| 📦 Package                | 🔢 Version  | 📝 Purpose                                   |
|--------------------------|-------------|---------------------------------------------|
| `fl_chart`               | ^0.69.2    | 📈 For rendering interactive graphs.         |
| `dio`                    | ^5.7.0     | 🌐 For making HTTP requests.                |
| `flutter_riverpod`       | ^2.6.1     | 🎛️ State management.                        |
| `pretty_dio_logger`      | ^1.4.0     | 📝 Logging HTTP requests and responses.     |
| `freezed_annotation`     | ^2.4.4     | ❄️ For immutable data models.               |
| `objectbox`              | ^4.0.3     | 💾 For local database storage.              |
| `objectbox_flutter_libs` | any         | 🔌 ObjectBox support for Flutter.           |
| `path_provider`          | ^2.1.5     | 📂 Access device directories for caching.   |
| `intl`                   | ^0.20.1    | 📆 Formatting dates and numbers.            |
| `iconsax_flutter`        | ^1.0.0     | 🔤 Icon set for UI components.              |

---

## 🤔 Trade-offs and Design Choices
- **🏗️ Architecture**: Chose **Riverpod** for state management due to its simplicity and scalability.
- **⏳ Time Constraints**: Focused on meeting core requirements. Advanced features like dark mode and data polling were deprioritized.
- **📂 Caching**: Implemented using `objectbox` for efficient local storage.
- **🧪 Testing**: Prioritized core logic and widget interaction tests over extensive edge case coverage.

---

### 🔍 Test Coverage
- ✅ **Unit Tests**: Core business logic (e.g., data processing).
- 🧩 **Widget Tests**: UI validation, ensuring tabs and graphs render correctly.

---