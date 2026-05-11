# ⚔️ Fields of Fire Digital

**Цифровая адаптация настольного варгейма Fields of Fire (GMT Games).**  
(неофициальный проект, учебный проект)

Проект создаётся как чистое функциональное ядро на Swift с консольным интерфейсом (CLI) для проверки движка.

[![Swift](https://img.shields.io/badge/Swift-6.0-orange?logo=swift)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-macOS%2013+-blue?logo=apple)](https://developer.apple.com)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2B%20Immutable%20Core-success)](#-архитектура)

---

## 🎯 О проекте

Цель — воссоздать глубокую механику оригинального варгейма **Fields of Fire** в цифровом виде,
сохранив при этом **иммутабельность состояния**, **чистоту игровой логики** и **расширяемость**.

На текущем этапе реализовано:

- ✅ Полный цикл игровых фаз с автоматическим переходом.
- ✅ Консольный интерфейс (CLI) с панелями и меню.
- ✅ Колода действий (Action Deck) с 51 картой, загружаемая из JSON.
- ✅ Чистое, иммутабельное ядро: все изменения состояния происходят через `GameState → новый GameState`.
- ✅ Архитектура на основе **Handlers**, **Commands** и **PhaseProcessor**.

---

## 🧱 Архитектура

Проект построен по принципам **Clean Architecture** и **Functional Core, Imperative Shell**.

```
CLI (main.swift)
   ↓
Engine (GameEngine, PhaseProcessor)
   ↓
Actions (Handlers, Commands)
   ↓
Core (GameState, Models, Enums, Tables, Protocols)
   ↑
Infrastructure (Renderer, JSONLoader, PlayerInput, ActionDeck)
```

### Ключевые особенности

1. **Иммутабельный `GameState`**  
   Каждое игровое действие возвращает **новый** `GameState`, не изменяя предыдущий.  
   Это даёт:
   - историю ходов (undo/redo)
   - предсказуемость и лёгкость отладки
   - возможность сетевой игры

2. **Чистое ядро**  
   Вся игровая логика реализована чистыми функциями (`(GameState, Command) → GameState`).  
   Побочные эффекты (ввод-вывод, рандом) вынесены в **Infrastructure**.

3. **Фазовый движок**  
   `PhaseProcessor` управляет сменой фаз согласно сценарию миссии.  
   Каждая фаза — отдельный обработчик (напр., `FriendlyHQEvent`, `FriendlyCommand`).

4. **CLI-интерфейс**  
   Много-панельный консольный вывод с системой меню.  
   Легко заменим на GUI в будущем.

---

## 📂 Структура проекта

```
Sources/
├── PrototypeCLI/          # Точка входа (main.swift)
└── prototype/
    ├── CLI/                # Рендерер, меню, хелперы
    ├── Core/               # GameState, модели, enum'ы, таблицы, протоколы
    ├── Engines/            # GameEngine, PhaseProcessor, Setup
    ├── GameAction/         # Обработчики фаз, команды, PlayerAction
    └── Infrastructure/     # Колода действий, загрузчик JSON, TerrainDeck
```

---

## 🚀 Запуск

```bash
git clone https://github.com/ghost355/prototype.git
cd prototype
swift run PrototypeCLI
```

---

## 🧪 Тестирование

```bash
swift test
```

---

## 🗺️ Roadmap

- [x] Базовая архитектура и цикл фаз
- [x] CLI-интерфейс с панелями
- [x] Колода действий (Action Deck)
- [ ] Таблицы событий (HQ Event Table)
- [ ] Полноценная фаза Friendly Command
- [ ] Реализация вражеской активности
- [ ] Боевая система (VOF, PDF, Combat Results)
- [ ] Загрузка миссий из JSON
- [ ] Графический интерфейс (SwiftUI)

---

## 🙏 Благодарности

- **Ben Hull** — автор настольной игры Fields of Fire.
- **GMT Games** — издатель оригинальной игры.
- Всему сообществу любителей варгеймов за вдохновение, a [этот чат](<https://t.me/swarmarket/4566>) за помощь и ответы на вопросы.

---

## 📄 Лицензия

MIT License. См. файл [LICENSE](LICENSE).

