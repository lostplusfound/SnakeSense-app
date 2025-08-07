# 🐍 SnakeSense App
<img height="400" alt="Screenshot_20250806-184919" src="https://github.com/user-attachments/assets/71a13f1f-6b04-4bc6-9be5-e63479936a8b" />
<img height="400" alt="Screenshot_20250806-184914" src="https://github.com/user-attachments/assets/946ff6fa-bc5e-49c8-8bf8-c4f0ff1f83a2" />

**SnakeSense App** is a simple Flutter application that leverages the [SnakeSense](https://github.com/lostplusfound/SnakeSense/) machine learning model to classify snake species and identify whether a snake is venomous or not. Users can either select an image from their device or take a new photo, and the app performs inference to display species information in a user-friendly way.

---

## 📱 Features

* Choose an existing image from your device gallery  
* Capture a new photo using the camera  
* Perform on-device inference with the SnakeSense ML model  
* Display detailed snake species information clearly and intuitively

---

## 💻 Platform Support

| Platform   | Status              |
|------------|---------------------|
| **Android** | ✅ Fully supported   |
| **Desktop** | ✅ Supported         |
| **Web**     | ❌ Not supported (due to ONNX runtime issues) |
| **iOS**     | ⚠️ Untested          |

> ℹ️ ONNX Runtime currently does not support Flutter web reliably, so SnakeSense App is not functional on web at this time. iOS has not yet been tested and may require additional configuration.

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK installed

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/lostplusfound/SnakeSense-app
   cd snakesense-app
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

---

## 🤝 Contributions

Contributions and feedback are welcome! Feel free to open issues or submit pull requests.

---

## ⚠️ Disclaimer

This app is intended for educational and experimental use only. The ML model, like any AI model, is not 100% accurate. **Always seek professional medical help if bitten by a snake or uncertain about a snake’s danger.**

---

## 📄 License

Licensed under the MIT License. See the `LICENSE` file for details.
