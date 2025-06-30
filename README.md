# Motivationsspruch-Bot 

Dieses kleine Projekt ruft regelmäßig einen echten Motivationsspruch aus dem Internet ab – entweder als systemd-Timer für den Hintergrundbetrieb (Abgabe-Version) **oder** als Live-Endlosschleife direkt im Terminal (Instant-Motivation für dich selbst)!  
Das Skript holt die Sprüche über eine freie API und zeigt sie schön an.  
**Abgabe für Einzelarbeit, benotet.**

---

##  Checkliste für die Abgabe

- [x] Bash-Skript, das einen Motivationsspruch von einer offenen API abruft
- [x] systemd `.service`-Unit, die das Skript startet und sich bei Fehlern neu startet
- [x] systemd `.timer`, der den Service alle 5 Minuten ausführt
- [x] README.md mit Schritt-für-Schritt-Anleitung und Checkliste
- [x] Alles läuft unter dem eigenen User, ohne root-Rechte
- [x] Screenshot von `systemctl status motivation.timer` im Repo (`screenshot.png`)
- [x] Projekt als privates GitHub-Repo, Prüfer ist eingeladen (`keykey7`)

---

##  Projektstruktur

```
/ (Projektordner)
├── motivation.sh                
├── motivation-live.sh           
├── .config/
│   └── systemd/
│       └── user/
│           ├── motivation.service
│           └── motivation.timer
├── README.md
└── screenshot.png
```

---

##  **Installation & Anleitung**

### 1. Voraussetzungen

- Ein aktuelles Linux mit systemd (z. B. Ubuntu in VM, WSL2, nativ)
- Tools: `curl` und `jq` (werden automatisch installiert)

### 2. Repo klonen

```bash
git clone https://github.com/DEINUSER/DEIN-REPO.git
cd DEIN-REPO
```

### 3. Abhängigkeiten installieren

```bash
sudo apt update
sudo apt install curl jq -y
```

---

##  Automatisch im Hintergrund mit systemd-Timer (Abgabe-Version)

### 1. Skript ausführbar machen

```bash
chmod +x motivation.sh
```

### 2. Service- und Timer-Unit kopieren

```bash
mkdir -p ~/.config/systemd/user
cp .config/systemd/user/motivation.* ~/.config/systemd/user/
```

### 3. Pfad im Service-File prüfen

Öffne `~/.config/systemd/user/motivation.service`  
Stelle sicher, dass `ExecStart=` den vollen Pfad zu deiner `motivation.sh` enthält (z. B. `/home/deinuser/motivation.sh`).  
Mit `whoami` findest du deinen Usernamen.

### 4. systemd aktualisieren & Timer aktivieren

```bash
systemctl --user daemon-reload
systemctl --user enable --now motivation.timer
```

### 5. Status und Logs prüfen

```bash
systemctl --user status motivation.timer
journalctl --user -u motivation.service
```

### 6. Screenshot machen

Füge einen Screenshot von

```bash
systemctl --user status motivation.timer
```

als `screenshot.png` dem Repo bei.

---

##  Beispieloutput

```
💡 Motivation für dich: "It is never too late to be what you might have been." – George Eliot
Nächster Spruch in 5 Minuten... (Beenden mit [CTRL]+[C])
```

---

##  Troubleshooting & Hinweise

- Achte darauf, dass das Skript ausführbar ist:
  ```bash
  chmod +x motivation.sh motivation-live.sh
  ```
- Falls `jq` oder `curl` fehlen:
  ```bash
  sudo apt install jq curl -y
  ```
- systemd-Timer funktioniert nur, wenn du systemd als User benutzen kannst (bei Ubuntu in VM, WSL2, etc.).
- Bei Problemen immer Logs anschauen:
  ```bash
  journalctl --user -u motivation.service
  ```

---

##  Hintergrund & Infos

- API: [zenquotes.io/api/random](https://zenquotes.io/api/random)
- Service und Timer laufen unter deinem User – keine root-Rechte nötig!
- Skript funktioniert mit jeder modernen Linux-Distribution.
- Getestet auf Ubuntu 22.04 LTS.

---

##  Autor & Kontakt

Timo Eichenberger