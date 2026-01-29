# Home-Lab

Produktionsnahes Home-Server-Setup mit **Pi-hole**, **Unbound** und **Nginx Reverse Proxy** inklusive **lokaler Certificate Authority (CA)**.
Das Setup basiert auf **Docker Compose**, läuft auf **x86_64** und **ARM64** (z. B. Raspberry Pi) und ist auf **Sicherheit, Nachvollziehbarkeit und Erweiterbarkeit** ausgelegt.

---

## Raspberry-Pi-Grundkonfiguration (Firewall)

Installation und Basiskonfiguration von **UFW**:

```bash
sudo apt update
sudo apt install ufw

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 53
sudo ufw allow proto icmp

# Pi-hole Web-UI nur lokal erlauben
sudo ufw deny in 8080/tcp
sudo ufw allow in on lo to any port 8080 proto tcp

sudo ufw enable
sudo ufw status numbered
```
---

## Architektur

```
LAN-Clients
    |
    |  DNS (53/udp + 53/tcp)
    v
+-------------------+      +-------------------+
|     Pi-hole       | ---> |      Unbound      |
|  DNS-Sinkhole     |      | Rekursiver DNS    |
+-------------------+      +-------------------+
    |
    |  HTTPS (443)
    v
+-------------------+
|   Nginx Proxy     |
| pihole.<domain>   |
+-------------------+
```

**Rollen**

* **Pi-hole**: Filtert DNS-Anfragen (Ads, Tracker, lokale Zonen)
* **Unbound**: Vollwertiger rekursiver Resolver
* **Nginx**: Reverse Proxy für Web-UIs via HTTPS
* **TLS**: Eigene lokale Root-CA

---

## Eigenschaften

* Vollständig lokaler DNS-Resolver (keine externen Upstream-DNS)
* Eigene Root-CA für interne TLS-Zertifikate
* `network_mode: host`
* Web-UIs ausschließlich über Nginx erreichbar
* Native Bash-Skripte zur Initialisierung
* Erweiterbar um weitere Services (z. B. Grafana, Paperless, Vault)

---

## Voraussetzungen

**Pflicht**

* Linux-Host / VM 
* Docker + Docker-Compose-Plugin
* Bash, OpenSSL
* Feste LAN-IP für den Server


---

## Quickstart

---

```bash
cp .env.example .env
# .env anpassen (LAN-IP, Domain)

# Zeritifikate erstellen
# Scripts müssen bezüglich der CA und Zertifikat Details entsprechend angepasst werden.
# Root-CA erzeugen (einmalig)
./scripts/ca-init.sh

# Zertifikat für Pi-hole erzeugen
./scripts/cert-issue.sh pihole

# Zertifikate unter config/nginx/ssl hinzufügen

cd compose
docker compose up -d

# Passwort für PiHole setzen
docker exec -it pihole pihole setpassword change-me
```

### Pi-hole DNS-Upstream setzen

In der PiHole UI unter Costom DNS Unboud eintragen. Wichtig: alle anderen Upstream DNS Server abwählen.

```
127.0.0.1#5335
```

### Lokaler DNS-Record in PiHole hinzufügen
```
pihole.home.arpa → 192.168.x.x
```

### Zugriff

```
https://pihole.<LOCAL_DOMAIN>
# z. B. https://pihole.home.arpa
```

---

## Start / Stop

```bash
cd compose
docker compose up -d
docker compose down
```

---

## Router- / DHCP-Konfiguration

Im Router oder DHCP-Server die IP dieses Hosts (`SERVER_IP`) als **DNS-Server** eintragen.

Ablauf:

```
Client → Pi-hole → Unbound → Root-Server
```

---

## Wichtige Hinweise

* Pi-hole Web-UI läuft hinter dem Nginx
* **Nginx ist der einzige öffentlich erreichbare Einstiegspunkt - siehe Firewall Config**

---

## Lizenz
Privates Home-Lab-Projekt. Nutzung auf eigene Verantwortung.