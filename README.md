# MapChat Connect

MapChat Connect is an iOS app that combines real-time location tracking with messaging functionality, enabling users to interact through text, images, and maps. The app allows users to view their location, search for nearby places, and share information seamlessly in a chat interface.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [File Structure](#file-structure)
- [Credits](#credits)

## Features

- **Real-Time Location Tracking**: Displays the user's current location on a map and updates automatically.
- **Nearby Places**: Displays 10 nearby points of interest using Google Places API.
- **Image Sharing in Chat**: Supports image messages in chat.
- **Contact Management**: Add, delete, reorder, and edit contacts.
- **Image Search with Unsplash**: Allows users to search images with pagination for sharing in chats, using the Unsplash API.
- **Pagination**: Smoothly handles loading nearby places in a paginated search view.

## Requirements

- iOS 13.0+
- Xcode 13.0+
- Google Maps and Google Places APIs with valid API keys
- Unsplash API for image search

## Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Devashish2106/MapChat-Connect.git
   ```
2. **Install Dependencies**:
   - Open the project in Xcode and make sure to have `CocoaPods` installed for `GoogleMaps`, `GooglePlaces`, and `Unsplash`.
   - Install necessary pods:
     ```bash
     pod install
     ```
3. **API Key Configuration**:
   - Replace `key.swift` with your API key details for Google Cloud.
   - Add the following to `key.swift`:
     ```swift
     struct Key {
         static let apiKey = "YOUR_GOOGLE_CLOUD_API_KEY"
     }
     ```

## Usage

1. **Run the App**:
   - Launch the app on the simulator or a physical device with location services enabled.
   
2. **Map Interaction**:
   - Navigate to the map view to see your current location and nearby places.
   
3. **Chat Features**:
   - Select a contact to start a chat. You can send messages and share images within the conversation.
   
4. **Image Search**:
   - Use the Unsplash API-integrated search to find images and share them in chats. The search results are displayed with pagination for smooth navigation.
   
5. **Manage Contacts**:
   - Add, delete, and edit contacts directly from the contacts list.

## File Structure

The project is organized to ensure modular and efficient code:

```
├── AddViewController.swift            # Adds new contacts
├── ChatViewController.swift           # Manages chat interface and messaging
├── CustomTableViewCell.swift          # Custom cell for contact display
├── DisplayViewController.swift        # Detailed contact information
├── EditViewController.swift           # Edit contact details
├── Info.plist                         # App configuration and permissions
├── Key.swift                          # Holds API keys for Google services
├── LeftImageViewCell.swift            # Chat cell for left image messages
├── LeftViewCell.swift                 # Chat cell for left text messages
├── MapViewController.swift            # Displays map and nearby places
├── Message.swift                      # Model for messages in chat
├── RightImageViewCell.swift           # Chat cell for right image messages
├── RightViewCell.swift                # Chat cell for right text messages
├── SceneDelegate.swift                # Scene life cycle management
├── SearchCollectionViewCell.swift     # Cell for search results in map view
├── SearchViewController.swift         # Handles place search and pagination
├── ViewController.swift               # Main view controller for contacts
```

## Credits

- **Developer**: Devashish Ghanshani

This project reflects skills in integrating Google Maps API, Google Places API, Unsplash API, managing real-time location tracking, Core Data persistence, and designing a user-friendly chat interface.

--- 
