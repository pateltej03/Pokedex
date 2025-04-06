# 🧭 Pokedex

A visually rich, interactive Pokédex app built with SwiftUI. This app was developed for CMPSC 475 at Penn State and explores core SwiftUI concepts such as lists, navigation, data modeling, persistence, and user experience design. It presents Pokémon data in a clean, modular layout and allows users to track which Pokémon they've captured.

## 📱 Features

### 📋 Home View

-   Displays Pokémon organized by type (e.g., Water, Fire, Electric, etc.)
-   Captured Pokémon appear in a dedicated row at the top
-   Tapping a Pokémon card opens a detailed view
-   Cards display a visual indicator (star) if the Pokémon is captured

### 🧭 List View

-   Scrollable list of all Pokémon with names, numbers, and thumbnails
-   Each row shows capture status via a star icon
-   Filter Pokémon by type using a type picker menu

### 📘 Detail View

-   Displays large Pokémon image on a gradient background
-   Shows height and weight with proper formatting
-   Displays all types and weaknesses using color-coded capsules
-   Allows capturing or releasing Pokémon with a toggle button
-   Shows evolutionary predecessors and successors as navigable card rows

### 🗂 Persistence

-   Captured status is saved locally and persists across app launches using JSON file storage in the app’s Documents directory

### 🎨 Visual Design

-   Fully supports Light and Dark mode
-   Views are broken into modular, single-responsibility components
-   Linear gradients and rounded shapes create a vibrant look

## 📂 Data Source

-   Pokémon data loaded from `pokedex.json`
-   Each Pokémon has:
    -   `id`, `name`, `types`, `height`, `weight`
    -   Optional `weaknesses`, `prev_evolution`, `next_evolution`
    -   A dynamic `captured` boolean

## 💡 Technical Highlights

-   MVVM architecture for clarity and separation of concerns
-   Reusable view components: Pokémon cards, rows, detail sections
-   Local file persistence with `Codable` and `FileManager`
-   Dynamic filtering with `Picker` and optional `PokemonType?` binding
-   Animations and transitions for a smooth UX

---

## 🧠 Let’s Connect!

**Tej Jaideep Patel**  
B.S. Computer Engineering  
📍 Penn State University  
✉️ tejpatelce@gmail.com  
📞 814-826-5544

---
