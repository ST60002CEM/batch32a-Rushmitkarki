# Memory Guardian - Mobile App

A Flutter-based mobile application for the Memory Guardian platform, providing dedicated interfaces for both users and admins to manage doctors, handle appointments, and facilitate seamless communication.

## Features

![alt text](image.png)
![alt text](<Screenshot 2024-08-12 123031.png>)
![alt text](<Screenshot 2024-08-12 123100.png>)
![alt text](<Screenshot 2024-08-12 123126.png>)

### User Role

- **View Doctors:** Browse and search through a list of available doctors.
- **Favorite Doctor:** Add doctors to a list of favorites for quick access.
- **Chat:** Communicate directly with doctors or the support team via a built-in chat feature.
- **Book Appointments:** Schedule and manage appointments with available doctors.

information.

- **Admin Chat:** Engage in real-time communication with users for support and appointment confirmations.

## UI/UX Design

- **Figma:** Used for prototyping and designing the mobile app's user interface.
- **Material Design:** Implemented Material Design principles for a modern, intuitive, and user-friendly interface.
- **Responsive Layouts:** Optimized for various screen sizes, ensuring a smooth experience on different mobile devices.
- **User-Centered Approach:** Focused on creating a seamless experience by keeping users and admins at the core of the design process.

## Technology Stack

- **Flutter:** The framework used for building cross-platform mobile apps, providing a native-like experience.
- **Dart:** The programming language used for app development.
- **Provider & Riverpod:** State management solutions used to handle app states efficiently.
- **Firebase:** Utilized for authentication (Google login), real-time database, and push notifications.
- **Socket.io:** Enables real-time chat functionality between users and admins.
- **REST API Integration:** Communicates with the backend for operations like doctor management, appointment booking, and user authentication.

## API Integration

The mobile app interacts with a RESTful API to handle:

- **Doctor Management:** Fetch, add, and update doctor profiles.
- **Appointment Handling:** Schedule, approve, or cancel appointments.
- **User Authentication:** Implement Google login and other authentication features.
- **Chat Services:** Enable real-time communication between users and admins.
- **Insurance Management:** Fetch and update insurance options available to users.

## Future Work

- **AI-based Doctor Matching:** Integrate an AI-powered feature to recommend doctors based on user medical history.
- **Telemedicine Integration:** Allow virtual consultations with doctors directly through the app.
- **Insurance Claims:** Let users submit and track insurance claims in-app.
- **Appointment Reminders:** Send automated SMS or email reminders for upcoming appointments.
- **Health Records:** Introduce a secure system for users to upload and manage their medical records.

## Challenges

- **Real-time Chat:** Ensuring reliable and seamless communication required careful management of message delivery states.
- **Responsive Design:** Maintaining consistent UI/UX across multiple devices and screen sizes.
- **API Integration:** Balancing smooth communication between the app and backend while ensuring secure data handling.

## Environment Variables

PORT=5000
MONGO_URI="mongodb+srv://test:test@cluster0.kzu0eau.mongodb.net/project"
JWT_SECRET=SECRET_KEY
KHALTI_PUBLIC_KEY="5826720c2d604a8eae0be763afaabb41"

```bash
REACT_APP_API_URL=<Base URL for the backend API>
REACT_APP_GOOGLE_CLIENT_ID=<Google Client ID for authentication>
REACT_APP_CHAT_SERVICE_URL=<Chat service URL>
REACT_APP_INSURANCE_SERVICE_URL=<Insurance management service URL>
REACT_APP_DOCTOR_MATCHING_SERVICE_URL=<AI-based doctor matching service URL>
```
