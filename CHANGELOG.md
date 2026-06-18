# Changelog

All notable changes to this project will be documented in this file.

The format loosely follows "Keep a Changelog".

## [1.0.0] - 2026-06-18

### Added
- Docker Compose Stack mit PHP 5.6, 7.4 und 8.3
- MariaDB 10.3 Datenbank
- phpMyAdmin Integration
- Composer in allen PHP‑Containern
- Xdebug Support
- Gemeinsamer Code‑Mount (`html/`)

### Infrastructure
- Docker Healthchecks für Web‑Container und Datenbank
- Persistente Datenbankdaten (`mysql_data/`)
- Apache Log‑Verzeichnisse (`logs/`)

### PHP Extensions
- mysqli
- pdo
- pdo_mysql
- gd
- intl
- mbstring
