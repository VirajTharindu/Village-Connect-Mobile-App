## 'Employee Connect' Mobile App (Employee Data Management System)📱🏡

A Flutter-based mobile application to manage community data of employees, aid programs, and profiles efficiently for companies or organizations.

## 📌 Features

## 1️⃣ Employee & Employee Family Data Management

Add, update, delete, view and manage employee & employee family profiles.

Store personal details, occupation, and aid eligibility.

Screens: family_member_form.dart, family_list.dart, family_profile.dart.



## 2️⃣ Aid & Assistance Programs

Manage government aid programs:

Pilikadara, Tuberculosis, Aswasuma, Wedihiti, Mahajanadara, Abhadhitha, etc.

Track beneficiaries and eligibility.

Screens: Pilikadara.dart, Tuberculosis.dart, etc.


## 3️⃣ Occupation & Demographics Categorization

Job Categories: Government, Private, Semi-Government, Corporations, Forces, Police, Self-Employed, etc.

Demographics: Religion, Ethnicity, Age Groups, Higher Education Levels.

Screens: Jobs.dart, Government.dart, Religion.dart, etc.


## 4️⃣ License Key Activation (Security Feature) 🔐

Offline license activation using AES encryption.

Ensures only authorized users can access the app.

Stores securely encrypted license key for future validation.

Screens: license_page.dart, EncryptionHelper.dart, LicenseManager.dart.


## 5️⃣ Database Management

Import and share the village database.

Export data securely for reporting.

Screens: importDB.dart, ShareDBUI.dart.


## 🛠️ Technologies & Tools Used

Flutter 3.x – UI Development

Dart 2.x – Programming Language

Shared Preferences – Local storage

Encrypt Package – AES encryption for license key

Provider / FutureBuilder – State management

SQLite / External DB Support – Data storage


## 📸 Screenshots

[Employee's Family Data Entry](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Family%20Data%20Entry.jpg)

[Employee's Family Data List](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Family%20Data%20List.jpg)

[Employee's Family Aid Types](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Family%20Aid%20Types.jpg)

[Employee's Job Types](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Job%20Types.jpg)

[Employee's Family Aid Details](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Family%20Aid%20details%20(Samurdi).jpg)

[PDF Downloading for a Filtered Category](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/PDF%20Downloading%20Screen%20for%20a%20Filtered%20Category.jpg)

[Profile for Members of a Family](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Profile%20for%20an%20User.jpg)

[Updating for a Family](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Updating%20screen%20for%20an%20User.jpg)

[Data Exporting](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Data%20Exporting.jpg)

[Data Importing](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Data%20Importing.jpg)

[Security License Activation](https://github.com/VirajTharindu/Village_Officer_App/blob/main/Screenshots/Security%20License%20Activation.jpg)



## 🚀 How to Run the Project


🔧 Prerequisites

Install Flutter SDK: Download

Install Dart SDK

Ensure Android Studio / VS Code is set up


## 📥 Clone the Repository

git clone https://github.com/VirajTharindu/Employee-Connect-Mobile-App.git (copy-paste & run in your PowerShell)

cd your project folder (copy-paste & run in your PowerShell)


## 📦 Install Dependencies

flutter pub get (copy-paste & run in your PowerShell)


## ▶️ Run the App

flutter run (copy-paste & run in your PowerShell)

(Use flutter run --release for production builds.)


## 🔐 Security Measures

AES Encryption for license key validation.

Data protection via secure local storage.

Restricted access based on license activation.


## 🎯 Future Enhancements

✅ Backend API for remote database access.

✅ Biometric Authentication for extra security.

✅ Multilingual Support (Sinhala, Tamil, English).


## 🤝 Contributing

Want to improve the Village Officer App? Follow these steps:


Fork the repository

Create a feature branch (git checkout -b feature-new)

Commit changes (git commit -m "Added new feature")

Push to GitHub (git push origin feature-new)

Create a Pull Request


## 📧 Contact

👤 Your Viraj Tharindu

📧 Email: virajtharindu1997@gmail.com

🔗 GitHub: https://github.com/VirajTharindu


⭐ If you found this project useful, don’t forget to give it a star on GitHub! ⭐

