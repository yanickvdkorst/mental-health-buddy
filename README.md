# 🧠 Mental Health Buddy

**Mental Health Buddy** is an iOS and Apple Watch app that helps young adults detect early signs of panic attacks and receive timely support. By monitoring vital signs like heart rate, the app alerts users when stress levels rise—helping them respond before things escalate.

This version includes **core functionality for detection and alerts**, with future plans to expand into support exercises and emergency contact features.

---

## 📌 Problem

Many people fail to recognize early symptoms of mental health issues, particularly panic attacks. These can feel sudden and overwhelming, and few tools exist that detect them early in an accessible, low-effort way.

---

## 🎯 Target Audience

- Young adults (ages 18–30)
- People who struggle with recognizing or managing panic attacks
- Users looking for a non-intrusive way to monitor their mental state

---

## 💡 Concept

A digital assistant that detects early signs of panic attacks through wearable data, alerts the user, and offers help. This reduces the burden of self-monitoring and supports users during high-stress moments.

---

## ✨ Key Features

- ✅ Detects elevated heart rate and stress signals via Apple Watch
- ✅ Sends real-time alerts to both Apple Watch and iPhone
- ✅ Offers calming guidance (to be added in a future version)
- ✅ Logs stress events for future insight

---

## 🧭 User Journey

1. **Recognize**  
   The Apple Watch monitors vital signs and detects elevated heart rate.

2. **Alert**  
   A notification appears:  
   _“Your heart rate is high. Try to slow your breathing.”_

3. **Act**  
   The app opens, preparing to offer guidance or calming support (future functionality).

4. **Log**  
   Event is recorded for personal tracking and improvement.

---

## 🛠 Technical Overview

- **Platforms**: iOS 17+, watchOS 10+
- **Languages**: Swift
- **Technologies**: HealthKit, WatchConnectivity, UserNotifications
- **Project Type**: Native Swift app using Xcode
- **Devices**: Apple Watch + iPhone

---

## 🚧 What’s Included (Current Version)

- Real-time panic detection based on heart rate data
- Notifications to Apple Watch and iPhone
- Basic user interface for viewing alerts
- Data logging of detected events

---

## 🔜 Roadmap (Upcoming Features)

- Guided breathing and calming exercises
- Direct emergency contact button
- In-app stress history overview / personal dashboard
- Personalized feedback after each alert

---

## ▶️ Getting Started

To run **Mental Health Buddy** locally, follow these steps:

### Requirements
- macOS with Xcode 15 or later
- iPhone (iOS 17+) and Apple Watch (watchOS 10+) for full functionality
- Apple Developer account (for HealthKit and Watch connectivity)

### Installation

1. **Clone the repository**
   git clone https://github.com/yourusername/mental-health-buddy.git
   cd mental-health-buddy
