# Git Helper

Skripte für Git-Wartung und den Release-Prozess.

Pfadangaben und Befehle beziehen sich auf das **Repository-Root**.

## Skripte

### Git-Cleanup-Branches.ps1

Entfernt lokale Branches, deren Upstream-Remote bereits gelöscht wurde (`gone`).

```powershell
./githelper/Git-Cleanup-Branches.ps1
```

- Führt zuerst `git fetch --prune` aus.
- Löscht nur merged Branches (`git branch -d`).

### Git-Cleanup-Branches-Forced.ps1

Wie oben, aber mit erzwungenem Löschen (`git branch -D`) — für Branches, die nicht vollständig gemerged sind.

```powershell
./githelper/Git-Cleanup-Branches-Forced.ps1
```

**Vorsicht:** Nicht gemergte Änderungen gehen verloren.

### Update-Changelog.ps1

Verschiebt den `[Unreleased]`-Abschnitt aus `CHANGELOG.md` in einen neuen Release-Abschnitt.

CertViewer nutzt keine separate `VERSION`-Datei. Die verbindliche Release-Version ist der Git-Tag im Format `vMAJOR.MINOR.PATCH`.

```powershell
./githelper/Update-Changelog.ps1 -Version 1.2.3 -DryRun
./githelper/Update-Changelog.ps1 -Version 1.2.3
./githelper/Update-Changelog.ps1 -Version v1.2.3 -Date 2026-06-17
```

Vollständiger Prozess: [docs/versioning.md](../docs/versioning.md).

