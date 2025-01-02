# AzerothCore ExpRate Script

This script enables players on an AzerothCore server to customize their experience gain rates through a simple NPC interaction. Players can set their rates from 1x to 5x, affecting experience gains from killing mobs, completing quests, and dungeon activities. The script is built with modularity in mind, following the **Model-View-Controller (MVC)** design pattern for maintainable and extensible code.

---

## Features

- **Customizable Experience Rates**: Players can set their experience rates between 1x and 5x via an NPC.
- **Persistence**: Experience rates are saved in the database and persist across server restarts.
- **Dynamic Application**: Adjusted experience rates apply to:
  - Killing mobs
  - Completing quests
  - Dungeon activities
- **Modular Design**: The script is divided into the following components:
  - **Model**: Handles database interactions.
  - **Controller**: Manages logic between the model and the view.
  - **View**: Interfaces with the player via NPC dialogs and feedback messages.

---

## How It Works

### Setting Experience Rates

1. Players interact with a designated NPC (`ExpRateView`) to select their desired experience rate.
2. The rate is validated and saved to the database (`ExpRateModel`).
3. A confirmation message is sent to the player via the view.

### Applying Experience Rates

- **On Mob Kill**: The adjusted experience is calculated based on the player's rate and applied instead of the default.
- **On Quest Completion**: Quest rewards are scaled according to the player's rate.
- **In Dungeons**: Dungeon-specific XP messages are displayed for clarity.

---

## Installation

1. **Place the Scripts**:
   - Add the `ExpRateModel.lua`, `ExpRateController.lua`, `ExpRateView.lua`, and `exp_rate_hook.lua` scripts to your Lua scripts folder (e.g., `lua_scripts/ExpRate/`).

2. **Create the Database Table**:
   - Execute the following SQL command on your `acore_characters` database:
     ```sql
     CREATE TABLE IF NOT EXISTS `player_exp_rates` (
         `player_guid` INT NOT NULL,
         `rate` TINYINT NOT NULL DEFAULT 1,
         PRIMARY KEY (`player_guid`)
     ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
     ```

3. **Restart the Server**:
   - Restart your AzerothCore server to load the scripts.

---

## Configuration

- **NPC ID**: The NPC used for interacting with the players is set to `380` by default. You can modify this in the `ExpRateView.lua` script.
- **Experience Rates**: The rates range from `1x` to `5x`. Additional ranges can be added if needed.

---

## Usage

### Interacting with the NPC

1. Approach the designated NPC in-game.
2. Select your desired experience rate from the dialog menu.
3. A confirmation message will display the updated rate.

### Gaining Experience

- Kill mobs, complete quests, or engage in dungeon activities to earn experience scaled by your chosen rate.

---

## Limitations

- **No Graphical Interface**: This implementation uses an NPC for interaction and does not include a custom UI element.
- **No Fallback**: If the database table is missing, rates will default to `1x`.

---

## Contribution

Feel free to fork this repository and contribute improvements or additional features. If you encounter issues, please create a new issue in the repository.

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

