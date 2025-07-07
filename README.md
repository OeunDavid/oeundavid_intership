# 🛒 Product Management App

A full-stack CRUD application to manage product listings.

---

## 📦 Tech Stack

- **Frontend**: Flutter + Provider (MVC pattern)
- **Backend**: Node.js (Express.js) + Microsoft SQL Server

---

## 🌐 API Base URL

Make sure your Flutter frontend points to the correct backend URL:

```dart
// Example usage in ProductController or API service file
const String baseUrl = 'http://<your-ip-address>:3000/api/products';
```

---

## ⚙️ Backend Setup (Express.js + SQL Server)

### Prerequisites

- Node.js (v18+ recommended)
- SQL Server
- npm

### Steps

1. **Clone the backend project**
   ```bash
   git clone https://github.com/your-username/product-api-backend.git
   cd product-api-backend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment**
   Create a `.env` file in the root with:
   ```env
   PORT=3000
   DB_USER=your_db_username
   DB_PASSWORD=your_db_password
   DB_SERVER=localhost
   DB_DATABASE=ProductDB
   ```

4. **Run the backend server**
   ```bash
   npm run dev
   ```

---

## 📱 Frontend Setup (Flutter)

### Prerequisites

- Flutter SDK
- Dart SDK
- Emulator or real device
- Android Studio or VS Code

### Steps

1. **Clone the frontend project**
   ```bash
   git clone [https://github.com/your-username/flutter-product-app.git](https://github.com/OeunDavid/oeundavid_intership.git)
   cd frontend/products/
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set the API Base URL**
   Open the controller/service file and set:
   ```dart
   const String baseUrl = "http://10.0.2.2:3000/api";
   ```

4. **Run the Flutter app**
   ```bash
   flutter run
   ```

5. **Important for Android**
   - Use your local IP instead of `localhost`.

---

## ✅ That’s it!

Your full-stack product CRUD app should now be running with:

- **Flutter frontend** communicating with
- **Express backend** connected to
- **SQL Server database**

  ## ⚙️ Backend Setup (Express.js + Express + SQL Server)

### Prerequisites

- Node.js (v18+ recommended)
- SQL Server
- npm

### Steps

1. **Clone the backend project**
   ```bash
   git clone https://github.com/your-username/product-api-backend.git
   cd product-api-backend
# Database configuration for the Express.js backend

# SQL Server credentials
DB_USER=username
DB_PASSWORD=password

# Server connection
DB_SERVER=localhost
DB_PORT=1433

# Target database
DB_DATABASE=ProductsDB
