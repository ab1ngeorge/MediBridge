# 🏥 MediBridge — Medical Language Assistant

**MediBridge** is a cross-platform Flutter application that bridges the communication gap between doctors and patients who speak different languages. Built with a focus on **Kerala's Kasaragod district** — one of India's most linguistically diverse regions — it combines AI-powered translation, symptom analysis, and community health surveillance into a single, accessible tool.

> **🎯 Problem Statement:**  
> In multilingual regions, language barriers in healthcare lead to misdiagnosis, poor medication adherence, and delayed treatment. MediBridge provides real-time medical translation, AI health guidance, and offline emergency support to ensure no patient is left behind.

---

## 📊 Project Presentation

👉 **[View / Download the MediBridge Presentation (PPT)](https://github.com/ab1ngeorge/MediBridge/blob/main/MediBridge.pptx)**  
👉 **[Direct Download (RAW)](https://raw.githubusercontent.com/ab1ngeorge/MediBridge/main/MediBridge.pptx)**

The presentation covers:
- Healthcare language barrier problem
- MediBridge system architecture
- AI-powered translation & symptom analysis
- Early warning disease surveillance
- Kerala-focused use cases & demo flow

---

## ✨ Features

### 🗣️ Doctor ↔ Patient Translation
- **Voice Translation** — Doctor speaks in English; speech is transcribed and translated into the patient's language with text-to-speech playback.
- **Patient Voice Input** — Patient speaks in their native language; speech is transcribed and translated to English for the doctor.
- **Text Translation** — Type medical instructions in English and get instant translations with quick-phrase shortcuts.
- **Prescription Explainer** — Paste a prescription and get a simplified explanation in the patient's language.

### 🤖 AI Health Bot — Symptom Analysis
- **Region-Aware AI** — Powered by Groq (LLaMA 3.3 70B), tuned for Kerala/Kasaragod-specific diseases like Dengue, Leptospirosis, and Chikungunya.
- **Multilingual Input** — English, Malayalam, and Manglish supported.
- **Structured Risk Assessment** — Returns risk level, possible conditions, home care advice, and red flags.
- **Emergency Detection** — Detects critical symptoms and prompts emergency calling (108).
- **Hospital Finder** — GPS-based nearby hospitals with one-tap calling and Google Maps navigation.

### 🛡️ Early Warning Network
- **Anonymous Symptom Reporting** — Community-driven disease signal collection.
- **Outbreak Dashboard** — Area-wise visualization of reported symptoms.
- **Symptom Trend Charts** — Line charts showing symptom frequency over time.
- **District Risk Heatmap** — Kerala districts color-coded by outbreak risk.
- **Health Advisories** — Context-aware alerts for the public.
- **Doctor Feedback** — Verified inputs from medical professionals.
- **Simulation Mode** — Demo outbreak scenarios for evaluation and testing.

### 📋 Health History
- **Persistent Records** — Stored locally using `shared_preferences`.
- **Recurring Symptom Detection** — Alerts for repeated symptom patterns.
- **Searchable Timeline** — View past health analyses with timestamps.

### 📴 Offline Emergency Mode
- **Offline Medical Phrases** — Emergency, pain, allergy, and medication phrases.
- **First Aid Guide** — Step-by-step bilingual instructions with TTS.
- **Emergency Contacts** — One-tap calling (108, 100, 101).
- **Category Browsing** — Organized offline content.

### 🌐 Localization
- **Full UI Localization** — English & Malayalam (മലയാളം).
- **11 Patient Languages** — Malayalam, Hindi, Bengali, Tamil, Kannada, Tulu, Konkani, Beary, Marathi, Urdu.

---

## 🏗️ Architecture
lib/
├── main.dart
├── models/
├── screens/
├── services/
└── widgets/


(See source folders for detailed implementation.)

---

## 🛠️ Tech Stack

| Layer | Technology |
|------|-----------|
| Framework | Flutter (Dart) |
| AI / LLM | Groq API — LLaMA 3.3 70B |
| Speech-to-Text | speech_to_text |
| Text-to-Speech | flutter_tts |
| Location | geolocator |
| Charts | fl_chart |
| Storage | shared_preferences |
| HTTP | http |
| Env Management | flutter_dotenv |
| URL Launch | url_launcher |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.11.1)
- Groq API Key
- Android Studio / Xcode

### Setup

```bash
git clone https://github.com/ab1ngeorge/MediBridge.git
cd MediBridge
