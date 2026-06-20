# Release Pipeline

Dieses Dokument beschreibt den Release-Prozess.

## Überblick

Dieses Projekt verwendet GitHub Actions für CI und Release-Erstellung. Releases sind tag-getrieben:

```powershell
git tag v1.2.3
git push origin v1.2.3
```

Ein Tag im Format `vMAJOR.MINOR.PATCH` erstellt automatisch einen GitHub Release.

## Workflow-Dateien

Die Pipeline besteht aus zwei GitHub Actions Workflows:

```text
.github/workflows/ci.yml
.github/workflows/release.yml
```

`ci.yml` prüft jede Änderung auf `main` und in Pull Requests. `release.yml` erstellt ausschließlich für Versionstags einen GitHub Release.

## CI

Der CI-Workflow läuft bei jedem Push auf `main` und bei Pull Requests gegen `main`.

Ablauf:

1. Repository auschecken
2. Prerequisites installieren
3. Build project
4. keep artefacts
5. run smoke tests

Die CI erstellt keinen GitHub Release.

Der Publish-Schritt in der CI dient nur dem Smoke-Test. Dadurch wird geprüft, ob das spätere Release-Artefakt grundsätzlich gebaut und gestartet werden kann.

## Release

Der Release-Workflow läuft nur bei Tags:

```text
v1.0.0
v1.1.0
v2.0.0
```

Ablauf:

1. Tag wird gepusht
2. GitHub Actions startet den Release-Workflow
3. Artifacts werden veröffentlicht
4. GitHub Release wird als Draft erstellt
5. ZIP wird an den Draft Release angehängt
6. Release Notes werden manuell anhand von `CHANGELOG.md` geprüft und veröffentlicht

## Artefakt

Für Tag `v1.2.3` entsteht:

```text
PROJECTNAME-1.2.3-win-x64.zip
```

## Versionierung

Die Release-Version wird ausschließlich über den Git-Tag definiert:

```text
vMAJOR.MINOR.PATCH
```

Die führende `v` wird für Dateinamen und `InformationalVersion` entfernt. `AssemblyVersion` und `FileVersion` bleiben stabil, damit die Assembly-Kompatibilität nicht an Release-Tags gekoppelt ist.

Beispiel:

```text
Tag:                  v1.2.3
InformationalVersion: 1.2.3
ZIP-Datei:            PROJECTNAME-1.2.3-win-x64.zip
```

## Changelog und Release Notes

`CHANGELOG.md` ist die menschlich gepflegte Quelle für Release Notes. Neue Änderungen werden zunächst unter `## [Unreleased]` gesammelt und vor dem Release in einen versionierten Abschnitt verschoben.

Der Release-Workflow veröffentlicht den GitHub Release nicht direkt. Er erstellt einen Draft Release mit Artefakt, damit die Release Notes vor der Veröffentlichung anhand von `CHANGELOG.md` geprüft und bei Bedarf angepasst werden können.

Details zum Changelog-Prozess stehen in [`docs/versioning.md`](versioning.md).

## Release-Erstellung

Ein Release wird lokal vorbereitet, indem der gewünschte Commit auf `main` getaggt wird:

```powershell
git tag v1.2.3
git push origin v1.2.3
```

Der Push des Tags startet den Release-Workflow. Der Workflow erzeugt das ZIP-Artefakt und hängt es an den automatisch erstellten Draft Release an.
Da der Remote-Zugriff per SSH-Key passphrase-geschützt ist, müssen `git push`, `git pull` und `git fetch` in einer lokal freigegebenen Shell ausgeführt werden.

