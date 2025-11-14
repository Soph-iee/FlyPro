# Expense Tracker App

This project represents an intensive 5-week development journey, evolving from basic Dart fundamentals to a fully persisted, state-managed application with complex data relationships.
Note: This project was developed and tested on a physical Redmi Note 12 (Android 15) to ensure real-world performance, as development environment constraints precluded the use of emulators.

## Development Journey & Daily Progress

Pre-Development: The Hardware Pivot
Challenge: Discovered my development machine (8GB RAM) could not handle the Android Emulator alongside VS Code and Chrome.

    Solution: Configured USB Debugging on a physical device. This forced me to optimize for real hardware performance immediately.

    Foundation: Completed Udemy basics (Roll Dice, Quiz App) before switching to project-based learning via documentation and YouTube.

### Week 1: Foundation & Logic

    Focus: Repository setup and basic Dart logic.
    Achievements:
     Initialized Git repository.
     Built the core logic for expense calculations.
     Milestone: First successful commit and build on the Redmi device.

### Week 2: Trip Management & UI

    Focus: Layouts, Forms, and UX.
    Tech Stack: Column, Row, Container, Navigator.
    	Progress:
    Designed the UI based on Behance travel app inspirations.
    Core Logic: Implemented the "Trip First" architecture (creating a Trip before adding expenses).
    Built complex forms with validation.
    Replaced default splash screen with a native Android splash screen.

### Week 3: Advanced UI & Media

● Focus: Theming, Lists, and Image Handling.
● Progress:
○ Lifting State Up: Manually managed state to pass Trip data to the Expense screens.
○ Lists: Implemented ListView.builder and GridView.builder for efficient trip rendering.
○ Media: Integrated Image Picker (Gallery/Camera) to attach receipt photos to specific trips.

### Week 4: The State Management Refactor

● Focus: Architecture and Visualization.
● Shift: Migrated from setState to Provider.
● Features:
○ Visual Analytics: Integrated Flutter Charts to visualize spending per trip.
○ Search: Added functionality to search through Trips and Expenses.
○ Swipe Actions: Implemented Swipe-to-Edit and Swipe-to-Delete.
○ Optimization: Used UUIDs for unique transaction tracking.

### Week 5: Persistence & Data Models

● Focus: Local Database and Mock Backend.
● Tech Stack: Hive (NoSQL) & Mock API.
● Progress:
○ Integrated Hive for offline data persistence.
○ Created specialized Data Models (Trip and Expense) ensuring every expense is linked to a Trip ID.
○ Image Gallery: Implemented Uint8List to store receipt images locally as bytes.
○ Interactivity: Added Zoom and Pan functionality to images.

## Features Implemented

Core Functionality
● [x] Mock Authentication: Simulated login flow using a pre-defined list of user data (Mock API).
● [x] Trip-Centric Design: Users must create a Trip before tracking expenses.
● [x] Expense Linking: Every expense is strictly validated to belong to a specific Trip ID.
● [x] Dashboard: Overview of current trips and total spending.
Advanced Features
● [x] Visual Analytics: Charts showing expense breakdown by category for each trip.
● [x] Receipt Gallery: Attach images to expenses; supports Zoom/Pan.
● [x] Persistent Storage: Trips and Expenses are saved locally via Hive.
● [x] Lottie Splash Screen: Professional animated entry.

## Challenges & Solutions

1. The Hive vs. UUID Conflict
   ● The Problem: I used a UUID string to identify expenses, but Hive uses int keys. When I tried to edit an item, Hive treated it as a new entry because it didn't recognize the UUID, causing duplicates.
   ● The Solution: Refactored the Edit logic to pass the element.key (Hive's internal key) to the form, allowing box.put(key, data) to update the correct index.
2. State Management Migration
   ● The Challenge: Moving logic from main.dart into a TransactionProvider broke the initial setState logic.
   ● The Fix: Centralized all list manipulation (add, remove) inside the Provider class and used Consumer widgets in the UI.

## Known Issues & Future Improvements

1. State Reloading (CRUD):
   ○ Issue: The Trip Details screen sometimes displays stale data after editing an expense within that trip.
   ○ Planned Fix: Implementing ValueListenableBuilder to listen to the specific Trip object in Hive.
2. Savings Calculation:
   ○ Issue: The "Remaining Budget" for a trip requires a manual refresh to update after adding an expense.
   ○ Planned Fix: Move calculation logic into a Computed getter within the Provider.
3. Backend Integration:
   ○ Future Goal: Replace the Mock API/Hive setup with a real cloud backend (Firebase) for multi-device synchronization.

## Learning Resources

● Course: Flutter & Dart - Flutter & Dart - The Complete Guide [2025 Edition]- strictly followed for Weeks 1-2.
● Documentation: Referenced Flutter.dev and Hive Pub.dev for implementation details.
● Community: Relied on StackOverflow and Medium for debugging specific logic and undestand interaction better.
● AI Tools: Used Gemini and ChatGPT to understand complex error messages and generate JSON models.

## Testing Approach

● Device: Redmi Note 12 (Android 15).
● Methodology:
○ User Flows: Tested the strict logic (Tried adding an expense without a trip -> Verified it failed).
○ Mock Auth: Verified that different mock users see their own isolated data.
○ Performance: Verified list scrolling smoothness with heavy image data on actual hardware.
