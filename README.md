# 🌿 Nature Log

**Plant Recognition & Herbarium**

> Application Flutter de reconnaissance de plantes et d'herbier numérique

---

## 📋 Description

**Nature Log** est une application mobile développée en Flutter permettant d'identifier des plantes via la caméra et de constituer un herbier numérique personnel. L'application utilise l'intelligence artificielle pour reconnaître les plantes photographiées et offre une interface intuitive pour gérer sa collection botanique.

---

## 👥 Auteurs

| Nom | Rôle |
|-----|------|
| **Jules POYER** | Développeur |
| **Axel BONNEAU** | Développeur |

*Projet éducatif réalisé dans le cadre d'un cours Flutter - 2025/2026*

---

## ✨ Fonctionnalités

| Fonctionnalité | Description |
|----------------|-------------|
| 📷 **Reconnaissance de plantes** | Identification via caméra en temps réel |
| 📚 **Herbier numérique** | Sauvegarde automatique des espèces découvertes |
| 🔍 **Recherche de plantes** | Recherche par nom via l'API iNaturalist |
| 📖 **Détails botaniques** | Informations Wikipedia sur chaque plante |
| 📍 **Géolocalisation** | Enregistrement automatique du lieu de découverte |
| 🎨 **Interface moderne** | Design épuré avec thème nature |
| ⭐ **Nouvelles espèces** | Notification lors de la découverte d'une nouvelle espèce |

---

## 🛠️ Technologies

| Catégorie | Technologie |
|-----------|-------------|
| **Framework** | Flutter 3.x / Dart |
| **State Management** | flutter_bloc (Cubit) |
| **Base de données** | SQLite (sqflite) |
| **API Reconnaissance** | PlantNet API |
| **API Recherche** | iNaturalist API |
| **API Informations** | Wikipedia API |
| **Caméra** | camera package |
| **Localisation** | geolocator package |

---

## 📁 Structure du projet

```
lib/
├── main.dart                 # Point d'entrée de l'application
├── config/
│   └── app_config.dart       # Configuration (clés API)
├── cubits/
│   ├── camera_cubit.dart     # Gestion état caméra
│   ├── camera_state.dart     # États de la caméra
│   └── search_cubit.dart     # Gestion état recherche
├── models/
│   └── flora_snap.dart       # Modèle de données plante
├── repository/
│   ├── herbarium_repository.dart  # Accès BDD SQLite
│   └── plant_repository.dart      # Appels API externes
├── services/
│   └── location_service.dart      # Service de géolocalisation
└── ui/
    ├── screens/
    │   ├── home.dart              # Page d'accueil
    │   ├── camera.dart            # Écran caméra
    │   ├── herbarium.dart         # Herbier numérique
    │   ├── search_plants.dart     # Recherche de plantes
    │   └── plant_details.dart     # Détails d'une plante
    └── widgets/
        └── flora_flip_card.dart   # Carte retournable
```

---

## 📦 Installation

### Prérequis

- Flutter SDK >= 3.10.0
- Dart >= 3.0.0
- Android Studio / VS Code
- Émulateur ou appareil physique Android/iOS

### Étapes

```bash
# 1. Cloner le repository
git clone https://github.com/votre-repo/nature-log-flutter.git

# 2. Accéder au dossier
cd nature-log-flutter

# 3. Installer les dépendances
flutter pub get

# 4. Configurer les clés API
# Créer lib/config/app_config.dart avec votre clé PlantNet

# 5. Lancer l'application
flutter run
```

### Configuration API

Créez le fichier `lib/config/app_config.dart` :

```dart
class AppConfig {
  static const String plantNetApiKey = 'VOTRE_CLE_API_PLANTNET';
}
```

> 🔑 Obtenez votre clé API PlantNet sur [my.plantnet.org](https://my.plantnet.org/)

---

## 🚀 Fonctionnement

1. **Prendre une photo** → L'utilisateur capture une plante via la caméra
2. **Identification** → L'image est envoyée à l'API PlantNet
3. **Vérification** → L'app vérifie si l'espèce existe déjà dans l'herbier
4. **Sauvegarde** → Si nouvelle espèce, elle est ajoutée automatiquement avec :
   - Photo originale
   - Nom scientifique
   - Coordonnées GPS
   - Date de découverte
5. **Consultation** → L'utilisateur peut consulter son herbier et rechercher des informations

---


