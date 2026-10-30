# Leaflet — Помощь / Help

**Русский** · [English](#english)

---

## Русский

### Что это
Leaflet — лёгкий заметочник для Windows без WebView: ваши заметки — обычные Markdown-файлы (`.md`) в обычной папке. Есть `[[ссылки]]` между заметками, обратные ссылки, теги, поиск, живой просмотр прямо в редакторе, экспорт в HTML и PDF. Никаких аккаунтов и облака: файлы остаются у вас.

Поддержать проект: https://dalink.to/olegche (кнопка «Помощь проекту» в строке состояния, ленте и палитре).

### Папка с заметками
- **Ctrl+Shift+O** или «Выбрать…» в настройках — выбрать папку (хранилище). Все `.md` в ней и вложенных папках становятся заметками; скрытые папки (`.имя`) пропускаются.
- Папку или файл можно передать при запуске: `Leaflet.exe D:\Заметки` или `Leaflet.exe заметка.md`.
- **Ctrl+N** — новая заметка, **Ctrl+O** — открыть заметку по имени, **Ctrl+P** — палитра команд (все действия программы).
- **F2** — переименовать, **Delete** в списке — в корзину Windows. Переименование и перенос сами правят `[[ссылки]]` во всех заметках.

### Ссылки и обратные ссылки
- `[[Имя заметки]]` — ссылка; `[[Имя#Раздел]]` — на раздел; `[[Имя|подпись]]` — со своим текстом. Щелчок по оформленной ссылке (или Ctrl+щелчок по исходнику) открывает заметку.
- Наберите `[[` — появится подсказка с заметками; после `#` — с разделами. Enter/Tab вставляет, Esc закрывает.
- Правая панель показывает **обратные ссылки** (кто ссылается на эту заметку), структуру (заголовки) и теги.

### Теги
`#тег` и вложенные `#проект/сайт` в тексте. В строке поиска боковой панели `#проект` найдёт заметки с этим тегом и вложенными; `#` — список всех тегов с числом заметок. Щелчок по тегу в правой панели — тот же поиск.

### Поиск и замена
- **Ctrl+Shift+F** — поиск по всем заметкам (по названиям и тексту).
- **Ctrl+F** — найти в заметке, **Ctrl+H** — заменить, **F3 / Shift+F3** — дальше / назад. «Aa» — учитывать регистр.
- **Ctrl+Shift+H** — заменить во всех заметках: сначала что искать (видно число совпадений), затем чем заменить; по каждой заметке можно перейти к первому совпадению. Замена отменяется Ctrl+Z в открытых вкладках.

### Правка и чтение
**Ctrl+E** переключает правку и чтение. В правке строка с курсором показывает исходный Markdown, остальные — оформленный текст. Темы: **Графит**, **Терминал** и **Светлая** (лента листает их по кругу; палитра и настройки тоже). Вкладки: Ctrl+W закрыть, Ctrl+Tab переключить, Ctrl+1…9, Alt+←/→ — назад/вперёд по переходам.

### Таблицы, списки, сноски, встраивание
- **Таблицы**: `| a | b |` + строка `|---|---|`. Tab / Shift+Tab — к следующей / предыдущей ячейке, таблица сама выравнивается; Tab в последней ячейке добавляет строку. Команда палитры «Выровнять таблицу».
- **Списки**: `- пункт`, `1. пункт`; Tab вкладывает пункт, Shift+Tab поднимает. Задачи `- [ ]` / `- [x]` отмечаются щелчком по квадратику.
- **Сноски**: `текст[^1]` и в другом месте `[^1]: пояснение`. Щелчок по сноске — к определению и обратно, при наведении видна подсказка.
- **Встраивание**: `![[Имя]]` показывает содержимое другой заметки карточкой, `![[Имя#Раздел]]` — только раздел. Карточка только для показа; щелчок по заголовку открывает заметку.

### Картинки и вложения
- **Вставка**: Ctrl+V — картинка из буфера (сохранится как `снимок-ГГГГММДД-ччммсс.png`) или скопированные в проводнике файлы. Если в буфере есть текст, вставляется он.
- **Перетаскивание**: бросьте файлы или картинки на окно — в точку, куда бросили, или к курсору.
- Файлы копируются в папку **`assets`** рядом с заметкой, в текст вставляется `![](assets/имя.png)` (не картинка — `[имя](путь)`). Папку можно сменить: настройки → «Папка вложений» (`/имя` — одна папка в корне хранилища).
- Картинка показывается под строкой. Ctrl+щелчок по разметке — открыть файл программой Windows. Команда палитры «Переименовать вложение…» правит ссылки во всех заметках.

### История версий и черновики
- Снимки версий пишутся при сохранении (не чаще, чем раз в N минут — настройка «Снимки версий») и при закрытии вкладки. Команда палитры **«История версий…»** показывает различия и возвращает нужную версию (текущий текст сохраняется снимком).
- **Черновики**: несохранённые правки пишутся отдельно. После сбоя при следующем запуске Leaflet предложит восстановить их.
- Если файл изменили снаружи, а у вас есть несохранённые правки, над текстом появится полоса: «Оставить мою» / «Взять с диска» / «Сохранить мою как копию» / «Сравнить». Пропавший файл можно «Сохранить заново».

### Экспорт
**Ctrl+Shift+E**: заметка в HTML или PDF, либо все заметки в папку (раскладка и `[[ссылки]]` сохраняются, картинки встраиваются). Оформление — в цветах текущей темы.

### Настройки и язык
**Ctrl+,** (или кнопка в ленте) — тема, шрифт, размер, ширина текста, автосохранение, папка хранилища и вложений, снимки версий, **язык интерфейса (русский / English)** и горячие клавиши. Язык переключается на лету; по умолчанию — язык Windows (русский, иначе английский). Настройки хранятся в `settings.ini`.

### Горячие клавиши
**F1** — полный список с поиском; команду из него можно выполнить Enter. Почти все сочетания меняются в настройках (щёлкнуть по кнопке и нажать новое; Esc — отмена, Backspace — снять).

| Действие | Клавиши |
|---|---|
| Палитра команд / заметка / новая | Ctrl+P / Ctrl+O / Ctrl+N |
| Поиск по хранилищу | Ctrl+Shift+F |
| Найти / заменить в заметке | Ctrl+F / Ctrl+H |
| Заменить везде | Ctrl+Shift+H |
| Правка / чтение | Ctrl+E |
| Экспорт | Ctrl+Shift+E |
| Настройки | Ctrl+, |
| Переименовать | F2 |

### Портативный режим и «Открыть с помощью»
- **Портативный режим**: пока рядом с `Leaflet.exe` лежит `portable.txt`, настройки, черновики и снимки хранятся в папке `data` рядом с программой. Удалите `portable.txt` — данные уйдут в `%APPDATA%\Leaflet`.
- **«Открыть с помощью»**: команда палитры «Добавить Лист в «Открыть с помощью»…» (или ключ `--register`) добавляет Leaflet в список программ для `.md`. Программой по умолчанию он не становится; запись только для вашего пользователя, убирается там же («Убрать…» / `--unregister`).
- **Ярлык**: при самом первом запуске Leaflet кладёт ярлык `Leaflet` на рабочий стол (один раз; удалённый ярлык не возвращается).
- Работает один экземпляр: повторный запуск с файлом открывает его вкладкой в уже запущенном окне.

### Ключи командной строки
```
Leaflet.exe [файл.md | папка ...] [ключи]
```
| Ключ | Что делает |
|---|---|
| `файл.md` | открыть заметку (внутри хранилища — вкладкой, снаружи — сменить хранилище) |
| `папка` | открыть как хранилище |
| `--new` | отдельный экземпляр, не передавать другому окну |
| `--data папка` | хранить настройки, черновики и снимки в этой папке |
| `--lang ru` / `--lang en` | язык интерфейса на один запуск |
| `--register` / `--unregister` | добавить / убрать «Открыть с помощью» (с `--quiet` — без сообщения) |
| `--version`, `--help` | версия, справка |

---

## English

### What it is
Leaflet is a lightweight note-taking app for Windows with no WebView: your notes are plain Markdown (`.md`) files in an ordinary folder. It has `[[links]]` between notes, backlinks, tags, search, live preview right in the editor, and HTML/PDF export. No accounts, no cloud — the files stay with you.

Support the project: https://dalink.to/olegche (the "Support the project" button in the status bar, ribbon and palette).

### Your notes folder
- **Ctrl+Shift+O** or "Choose…" in Settings — pick a folder (the vault). Every `.md` in it and its subfolders becomes a note; hidden folders (`.name`) are skipped.
- You can pass a folder or file at launch: `Leaflet.exe D:\Notes` or `Leaflet.exe note.md`.
- **Ctrl+N** — new note, **Ctrl+O** — open a note by name, **Ctrl+P** — command palette (every action in the app).
- **F2** — rename, **Delete** in the list — move to the Windows Recycle Bin. Renaming and moving update `[[links]]` in all notes automatically.

### Links and backlinks
- `[[Note name]]` — a link; `[[Name#Section]]` — to a section; `[[Name|label]]` — with your own text. Click a rendered link (or Ctrl+click the source) to open the note.
- Type `[[` for a note suggestion list; after `#` it offers sections. Enter/Tab inserts, Esc closes.
- The right panel shows **backlinks** (who links to this note), the outline (headings) and tags.

### Tags
`#tag` and nested `#project/site` in the text. In the sidebar search, `#project` finds notes with that tag and its nested ones; `#` lists all tags with note counts. Clicking a tag in the right panel runs the same search.

### Search and replace
- **Ctrl+Shift+F** — search all notes (titles and text).
- **Ctrl+F** — find in note, **Ctrl+H** — replace, **F3 / Shift+F3** — next / previous. "Aa" toggles case sensitivity.
- **Ctrl+Shift+H** — replace in all notes: first what to find (with match counts), then the replacement; you can jump to the first match in any note. The replacement can be undone with Ctrl+Z in open tabs.

### Edit and read
**Ctrl+E** switches between editing and reading. While editing, the line with the cursor shows raw Markdown and the rest is rendered. Themes: **Graphite**, **Terminal** and **Light** (the ribbon button cycles through them; so do the palette and Settings). Tabs: Ctrl+W closes, Ctrl+Tab switches, Ctrl+1…9, Alt+←/→ go back/forward through visited notes.

### Tables, lists, footnotes, embedding
- **Tables**: `| a | b |` plus a `|---|---|` row. Tab / Shift+Tab move to the next / previous cell and the table realigns itself; Tab in the last cell adds a row. Palette command "Align table".
- **Lists**: `- item`, `1. item`; Tab nests an item, Shift+Tab lifts it. Tasks `- [ ]` / `- [x]` toggle with a click on the box.
- **Footnotes**: `text[^1]` and elsewhere `[^1]: explanation`. Click a footnote to jump to its definition and back; hover for a tooltip.
- **Embedding**: `![[Name]]` shows another note as a card, `![[Name#Section]]` shows only that section. The card is display-only; click its title to open the note.

### Images and attachments
- **Paste**: Ctrl+V — an image from the clipboard (saved as `снимок-YYYYMMDD-hhmmss.png`) or files copied in Explorer. If the clipboard has text, the text is pasted.
- **Drag and drop**: drop files or images onto the window — at the drop point, or at the cursor.
- Files are copied to an **`assets`** folder next to the note and `![](assets/name.png)` is inserted (non-images become `[name](path)`). Change the folder in Settings → "Attachments folder" (`/name` — a single folder in the vault root).
- Images display under their line. Ctrl+click on the markup opens the file in the Windows default app. Palette command "Rename attachment…" fixes links in all notes.

### Version history and drafts
- Version snapshots are written on save (at most once every N minutes — the "Version snapshots" setting) and when a tab closes. The palette command **"Version history…"** shows differences and restores a version (the current text is saved as a snapshot first).
- **Drafts**: unsaved edits are stored separately. After a crash, Leaflet offers to restore them on the next launch.
- If a file is changed outside while you have unsaved edits, a bar appears above the text: "Keep mine" / "Take from disk" / "Save mine as a copy" / "Compare". A vanished file can be "Saved again".

### Export
**Ctrl+Shift+E**: one note to HTML or PDF, or all notes to a folder (layout and `[[links]]` are kept, images are embedded). Styled in the colors of the current theme.

### Settings and language
**Ctrl+,** (or the ribbon button) — theme, font, size, text width, autosave, vault and attachments folders, version snapshots, **interface language (Русский / English)** and hotkeys. The language switches instantly; by default it follows Windows (Russian, otherwise English). Settings live in `settings.ini`.

### Hotkeys
**F1** — the full searchable list; press Enter to run a command from it. Almost all shortcuts can be changed in Settings (click the button and press the new combination; Esc cancels, Backspace clears).

| Action | Keys |
|---|---|
| Command palette / open note / new note | Ctrl+P / Ctrl+O / Ctrl+N |
| Search the vault | Ctrl+Shift+F |
| Find / replace in note | Ctrl+F / Ctrl+H |
| Replace everywhere | Ctrl+Shift+H |
| Edit / read | Ctrl+E |
| Export | Ctrl+Shift+E |
| Settings | Ctrl+, |
| Rename | F2 |

### Portable mode and "Open with"
- **Portable mode**: while `portable.txt` lies next to `Leaflet.exe`, settings, drafts and snapshots are kept in the `data` folder next to the program. Delete `portable.txt` and the data moves to `%APPDATA%\Leaflet`.
- **"Open with"**: the palette command "Add Leaflet to "Open with"…" (or the `--register` switch) adds Leaflet to the list of programs for `.md`. It does not become the default app; the entry is per-user and is removed the same way ("Remove…" / `--unregister`).
- **Desktop shortcut**: on the very first launch Leaflet puts a `Leaflet` shortcut on the desktop (once; a deleted shortcut does not come back).
- One instance runs at a time: launching again with a file opens it as a tab in the running window.

### Command-line switches
```
Leaflet.exe [file.md | folder ...] [switches]
```
| Switch | What it does |
|---|---|
| `file.md` | open a note (inside the vault — as a tab, outside — switches the vault) |
| `folder` | open as the vault |
| `--new` | a separate instance, don't hand over to the running window |
| `--data folder` | keep settings, drafts and snapshots in this folder |
| `--lang ru` / `--lang en` | interface language for this run only |
| `--register` / `--unregister` | add / remove "Open with" (`--quiet` — no message) |
| `--version`, `--help` | version, usage |
