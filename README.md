# Fatal Labyrinth Clone (Haxe/Heaps)

A roguelike dungeon crawler inspired by Fatal Labyrinth.

## Controls
- **Arrow Keys**: Move / Attack
- **Space/Enter**: Select / Next
- **ESC**: Save & Quit to Menu

## Features
- Procedural Level Generation
- Turn-based Combat
- Progression System (Floors, Gold)
- Save/Load System
- Inventory UI

## Build
Requires Haxe 4+ and HashLink.
```bash
haxelib install heaps
haxelib install hlsdl
haxe compile.hxml
hl fatal_labyrinth.hl
```