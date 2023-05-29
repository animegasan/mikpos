---

<h1 align="center">Mikpos</h1>
<h3 align="center">The Free Software For Mikrotik Management</h3>

---

<p align="center">
<img alt="Logo Banner" src="https://raw.githubusercontent.com/animegasan/mikpos/main/src/public/assets/images/brand/logo.png"/>
</p>

---

Mikpos is a web-based application (MikroTik API PHP class) management users and payments that can be used in HotSpot and PPPoE MikroTik RouterOS users.
<br>
<br>
The image build on <a href="http://www.alpinelinux.org" target="_blank">Alpine Linux</a> and App Mikpos from <a href="https://github.com/naufkia/mikpos" target="_blank">Naufal Azkia</a>.

---

## Supported Architectures
We utilise the docker manifest for multi-platform awareness. Simply pulling ```animegasan/mikpos:latest``` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | amd64-\<version tag\> |
| arm64 | ✅ | arm64-\<version tag\> |
| armhf	| ✅	| arm32v7-\<version tag\> |

---

## Usage
Here are some example snippets to help you get started creating a container.
### docker-compose (recommended)
```yaml
---
version: "2.1"
services:
  mikhmon:
    image: animegasan/mikpos:latest
    container_name: mikpos
    ports:
      - 8080:8080
    restart: unless-stopped
```
### docker cli

```bash
docker run -d \
  --name=mikpos \
  -p 8080:8080 \
  --restart unless-stopped \
  animegasan/mikpos:latest
```

***Note : If API service in mikrotik changed, add API service after the Mikrotik IP in Add Router form. `<IP_MIKROTIK>:API_SERVICES`***

---

### Web Interface

Visit the url `http://<IP_ADDRESS>:8080` to have access to the Mikpos's web interface.

-   Default username: `admin`
-   Default password: `admin`

**It's highly recommended to change the default access credentials on first start**.

---

## Packages
The package used by this image are:
- nginx
- php7
- php7-fpm
- php7-intl
- php7-sockets
- php7-dom
- php7-xml
- php7-xmlwriter
- php7-simplexml
- php7-tokenizer
- php7-mysqli
- php7-session
- php7-openssl
- php7-json
- php7-curl
- php7-mbstring
- mysql
- mysql-client
- supervisor

---

## Version
### 1.0
#### Feature
   - Self registration
   - Multi Router Mikrotik
   - Hotspot & PPPOE
   - Easy Installation
   - Payment reports
   - Static page for payment method information
   - Supports payments gateway via Tripay.com

---

## Credit
[Naufal Azkia](https://github.com/naufkia), [Hilman Maulana](https://github.com/animegasan).

---
