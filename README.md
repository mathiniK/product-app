# Product Management Flutter App

Flutter app with **Login**, **Product List/Search**, and **Create/Update** forms with validation.

## Requirements
* Flutter SDK (stable)
* Android Studio/SDK, device or emulator

## Setup

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Configure API URL
Edit `lib/services/api_client.dart`:

**For Android Emulator:**
```dart
static const baseUrl = 'http://10.0.2.2:5000/api';
```

## Run
```bash
flutter devices
flutter run -d <deviceId>
```

**Login:** `admin / admin123`

## App Structure
```
lib/
 ├─ models/product.dart
 ├─ services/
 │   ├─ api_client.dart
 │   ├─ auth_service.dart
 │   └─ product_service.dart
 ├─ screens/
 │   ├─ login_page.dart
 │   ├─ product_list_page.dart
 │   └─ product_form_page.dart
 └─ main.dart
```

## Features
* **Auth**: Login → store JWT → auto-attach to API calls
* **List/Search**: Query by code/name, display all product fields
* **Create/Update**: Client validation (required fields, numeric price)

## Troubleshooting
* **Slow first build**: Run `flutter doctor -v`

## Demo Flow
1. Login (`admin/admin123`)
2. Create product 
3. Search `product` → see results
4. Tap item → edit → save → verify changes
