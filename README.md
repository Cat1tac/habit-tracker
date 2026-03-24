# habit_tracker

A gamified habit tracking app for Android and iOS. Users create habit missions, earn XP, maintain streaks, unlock badges, and get daily coaching from an AI buddy — all stored locally with no internet required (except for AI features).

---

## 👥 Team Members

| Name | Role |
|---|---|
| **Wayne Powell** | Database design, data models, providers, dashboard, AI integration |
| **Rahul Kandam** | UI widgets, screens, challenges, notifications, navigation |

---

## Features

- **Habit Missions** — Create habits with a custom icon, color, and daily/weekly frequency
- **XP & Leveling** — Each habit levels from 1–10 as you earn XP through completions
- **Streak Tracking** — Tracks consecutive completion days per habit
- **Streak Shields** — 3 shields per habit absorb a missed day without breaking the streak
- **Streak Heatmap** — Calendar view showing completion history with color-coded intensity
- **Insight Dashboard** — Weekly activity chart, total XP, rank title, and habit stats
- **Milestone Badges** — Unlock badges for streak length, habit level, and total completions
- **Challenges** — Time-limited Easy/Medium/Hard goals with XP rewards
- **Adaptive Goals** — New challenges auto-generated based on current performance
- **Weekly Reflections** — Mood rating, highlights, struggles, and AI-generated insight
- **AI Habit Buddy** *(bonus)* — Daily micro-goals and pep talks from the Claude API based on real habit data

---

## Technologies Used

| Tool | Version | Purpose |
|---|---|---|
| Flutter | 3.x | Mobile framework |
| Dart | 3.x | Language |
| sqflite | ^2.3.0 | SQLite local database |
| provider | ^6.1.1 | State management |
| fl_chart | ^0.66.2 | Weekly bar chart |
| table_calendar | ^3.0.9 | Heatmap calendar |
| percent_indicator | ^4.2.3 | XP bars, progress rings |
| http | ^1.2.0 | AI API calls |
| uuid | ^4.3.3 | Record IDs |
| flutter_dotenv | ^5.1.0 | API key management |
| intl | ^0.18.1 | Date formatting |

---

## Installation

### Prerequisites
- Flutter SDK 3.0+ — [flutter.dev](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code with the Flutter plugin
- Android emulator or physical device (API 21+)

### Steps

**1. Verify Flutter is set up**
```bash
flutter doctor
```
All items should show green. Accept Android licenses if prompted:
```bash
flutter doctor --android-licenses
```

**2. Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/habit-mastery-league.git
cd habit-mastery-league
```

**3. Install dependencies**
```bash
flutter pub get
```

**4. Add Poppins font files**

Download from [fonts.google.com/specimen/Poppins](https://fonts.google.com/specimen/Poppins) and place in a `fonts/` folder in the project root:
```
fonts/
├── Poppins-Regular.ttf
├── Poppins-Medium.ttf
├── Poppins-SemiBold.ttf
├── Poppins-Bold.ttf
└── Poppins-ExtraBold.ttf
```

**5. Set up the AI API key** *(optional — app works without it)*

Create a `.env` file in the project root:
```
AI_API_KEY=sk-ant-your-key-here
```
Get a key at [console.anthropic.com](https://console.anthropic.com). The `.env` file is already listed in `.gitignore` — never commit it.

**6. Add Android notification permissions**

In `android/app/src/main/AndroidManifest.xml`, add inside `<manifest>`:
```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

**7. Run the app**
```bash
flutter run
```

---

## Usage Guide

### Creating a Habit
1. Tap **+ New Mission** on the Home screen
2. Enter a name, optional description, and choose Daily or Weekly
3. Pick an emoji icon and a color
4. Tap **Launch Mission**

### Completing a Habit
1. Find the habit card on the Home screen
2. Tap the **circle button** on the right of the card
3. The button turns green — you earn XP and your streak increases

### Streak Shields
- Each habit starts with 3 shields shown on the Habit Detail screen
- If you miss one day, a shield activates automatically and preserves your streak
- Shields do not replenish — use them wisely

### Heatmap
1. Tap **Streaks** in the bottom navigation bar
2. Select a habit from the dropdown
3. Green days = completed. Darker = higher score that day

### AI Habit Buddy
1. Tap the **🤖** icon on the Home screen
2. A daily micro-goal and pep talk load automatically
3. Tap **Refresh** to regenerate

### Weekly Reflection
1. Go to **Insights → + Reflect**
2. Rate your mood, write highlights and struggles
3. Tap **🤖 Get AI Insight** for an AI-generated analysis
4. Tap **Save Reflection**

### Badges
- Navigate to **Badges** via the bottom nav bar
- **Earned** tab: unlocked badges with dates
- **Locked** tab: progress bars toward each requirement

> 📸 *Add screenshots here after your first build — one per screen listed above.*

---

## 🗄 Database Schema

The app uses a single SQLite file (`habit_mastery.db`) with 6 tables.

### `habits`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT PK | UUID |
| `name` | TEXT | Required |
| `description` | TEXT | Optional |
| `icon` | TEXT | Emoji |
| `color` | TEXT | Hex string |
| `frequency` | TEXT | `'daily'` or `'weekly'` |
| `level` | INTEGER | 1–10 |
| `xp` | INTEGER | XP within current level |
| `streak_shields` | INTEGER | 0–3 |
| `created_at` | TEXT | ISO timestamp |
| `is_active` | INTEGER | `1` = active, `0` = archived |

### `habit_logs`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT PK | UUID |
| `habit_id` | TEXT FK | → `habits.id` |
| `completed_date` | TEXT | ISO timestamp |
| `score` | INTEGER | 100–150 |
| `notes` | TEXT | Optional |

### `streaks`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT PK | UUID |
| `habit_id` | TEXT FK | → `habits.id` |
| `current_streak` | INTEGER | Consecutive days |
| `longest_streak` | INTEGER | All-time best |
| `last_completed` | TEXT | ISO timestamp |
| `shields_used` | INTEGER | Total shields consumed |

### `badges`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT PK | e.g. `badge_streak_7` |
| `habit_id` | TEXT | NULL = global badge |
| `name` | TEXT | Display name |
| `icon` | TEXT | Emoji |
| `condition_type` | TEXT | `'streak'`, `'level'`, `'completion_count'` |
| `condition_value` | INTEGER | Unlock threshold |
| `earned_at` | TEXT | ISO timestamp or NULL |
| `is_earned` | INTEGER | `1` = earned |

### `challenges`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT PK | UUID |
| `title` | TEXT | Challenge name |
| `target_value` | INTEGER | Goal number |
| `current_value` | INTEGER | Current progress |
| `challenge_type` | TEXT | `'streak'`, `'completion'`, `'xp'` |
| `difficulty` | TEXT | `'easy'`, `'medium'`, `'hard'` |
| `start_date` | TEXT | ISO date |
| `end_date` | TEXT | ISO date |
| `is_completed` | INTEGER | `1` = done |
| `reward_xp` | INTEGER | XP on completion |

### `reflections`
| Column | Type | Notes |
|---|---|---|
| `id` | TEXT PK | UUID |
| `week_start` | TEXT | ISO date (Monday) |
| `week_end` | TEXT | ISO date (Sunday) |
| `mood` | INTEGER | 1–5 |
| `highlights` | TEXT | User freeform text |
| `struggles` | TEXT | User freeform text |
| `ai_insight` | TEXT | AI-generated text |
| `total_score` | INTEGER | Weekly score |
| `habits_completed` | INTEGER | Count for the week |
| `created_at` | TEXT | ISO timestamp |

---

## Known Issues

| Issue | Details |
|---|---|
| Weekly chart uses placeholder data | `WeeklyChart` renders stub values — needs `HabitDao.getCompletionMap()` aggregated per day |
| Weekly completion rate is hardcoded | `AiBuddyScreen` passes `70` instead of a real calculated value |
| Adaptive goals completion count is `0` | `AdaptiveGoalsScreen` needs a live query from `habit_logs` filtered to the current week |
| No habit edit screen | Habits cannot be edited after creation — only archived or deleted |

---

## Future Enhancements

- **Habit editing** — Allow name, icon, color, and frequency changes after creation
- **Scheduled notifications** — True daily reminders at a user-chosen time using `timezone`
- **Social league** — Compare streaks and XP with friends via a shared leaderboard
- **Data export** — Export habit history as CSV
- **Home screen widget** — Show today's completion ring without opening the app
- **Light theme** — User toggle between dark and light mode
- **Habit templates** — Pre-built mission packs for fitness, reading, and mindfulness

---

## License

```
MIT License

Copyright (c) 2025 [Your Names]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```