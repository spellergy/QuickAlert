# 🚨 QuickAlert - Emergency Response System

A comprehensive emergency response ecosystem consisting of a mobile application, admin dashboard, and secure backend server. QuickAlert is designed to provide immediate assistance during emergencies by connecting users with nearby emergency services through an AI-enhanced validation system.

![QuickAlert Banner](QuickAlert-Website-main/public/image.jpg)

---

## 🌟 Core Components

### 📱 Mobile App (Flutter)
- 🆘 Quick Alert activation
- 📍 Real-time location tracking
- 📸 Media upload for emergency validation
- 🔔 Push notifications for status updates
- 📝 Detailed incident reporting

### 💻 Admin Dashboard (React)
- 🗺️ Real-time emergency mapping
- 👥 User management interface
- 📊 Emergency statistics & analytics
- 🔐 Secure access control
- 📱 Responsive design

### ⚡ Backend Server (Node.js)
- 🔒 End-to-end encryption
- 🤖 AI-powered request validation
- 📡 Real-time data synchronization
- 🎯 Geolocation services
- 🔐 JWT authentication

---

## 🏗️ Project Architecture

```
QuickAlert/
├── 📱 QuickAlert_frontend_file/    # Flutter Mobile App
│   ├── lib/                        # Core Flutter code
│   │   ├── screens/               # UI screens
│   │   ├── widgets/               # Reusable components
│   │   └── Provider/              # State management
│   └── ...
│
├── ⚡ QuickAlert_backend_File/      # Node.js Backend
│   ├── src/
│   │   ├── controllers/           # Business logic
│   │   ├── routes/               # API endpoints
│   │   ├── middleware/           # Request processors
│   │   └── config/              # Configuration
│   └── ...
│
└── 💻 QuickAlert-Website-main/     # React Admin Dashboard
    ├── src/
    │   ├── components/           # UI components
    │   ├── pages/               # Dashboard pages
    │   └── services/            # API services
    └── ...
```

---

## 🚀 Quick Start

### Prerequisites
- Node.js v14+
- Flutter SDK
- npm or yarn
- Git
- Supabase account

### Backend Setup
```bash
cd QuickAlert_backend_File
npm install

# Configure environment
cp .env.example .env
# Edit .env with your Supabase credentials

# Start development server
npm run dev
```

### Mobile App Setup
```bash
cd QuickAlert_frontend_file
flutter pub get
flutter run
```

### Admin Dashboard Setup
```bash
cd QuickAlert-Website-main
npm install
npm run dev
```

---

## 🔐 Security Features

- 🔒 End-to-end encryption for sensitive data
- 🔑 JWT-based authentication
- 🛡️ Request validation using Zod
- 📁 Secure file handling
- 🌐 CORS protection
- 🔐 Role-based access control

---

## 🛠️ Technology Stack

### Mobile Application
- Flutter/Dart
- Provider State Management
- Geolocation Services
- Local Storage
- Push Notifications
- Camera Integration

### Backend Server
- Node.js/TypeScript
- Express.js
- Supabase
- Zod Validation
- Multer
- JWT Authentication

### Admin Dashboard
- React.js
- Vite
- Supabase Client
- Maps Integration
- Real-time Updates
- Responsive Design

---

## 📡 API Documentation

### Authentication Endpoints
- 🔑 POST /auth/login
- 👤 POST /auth/register
- 🔄 POST /auth/refresh
- 📤 POST /auth/logout

### Emergency Endpoints
- 🆘 POST /requests/create
- 📍 GET /locations/nearby
- 📸 POST /upload/media
- 📊 GET /requests/status

Detailed API documentation available in the backend repository.

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch:
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. Commit your changes:
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. Push to the branch:
   ```bash
   git push origin feature/AmazingFeature
   ```
5. Open a Pull Request

---

## 👥 Authors

**Kush Saini**

**Arpit Gupta**

**Anushka Soni**

---