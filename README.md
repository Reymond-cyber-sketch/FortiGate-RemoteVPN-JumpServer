# FortiGate Remote VPN + Jump Server

## 🎥 Video de demostración

> 📌 **Video del laboratorio:**  
> [Agregar aquí el enlace del video]

---

## 👨‍🎓 Información del estudiante

**Nombre:** Reymond Daniel Guerrero Cruz  
**Matrícula:** 2024-0963  

---

## 📌 Descripción del proyecto

Este laboratorio implementa una infraestructura de seguridad de redes utilizando **FortiGate, MikroTik, VPN IPsec, VLANs, Jump Server y servidores protegidos**.

El objetivo principal es controlar el acceso entre diferentes segmentos de red y permitir que los usuarios remotos accedan de forma segura únicamente al **Jump Server**, desde donde pueden utilizar los servicios autorizados del servidor WEB.

---

## 🖥️ Tecnologías utilizadas

- GNS3
- FortiGate VM
- MikroTik CHR
- Windows Server 2022
- Alpine Linux
- VMware Workstation
- VPN IPsec
- RDP
- SSH
- HTTPS
- VLAN
- DHCP

---

## 🌐 Direccionamiento utilizado

| Dispositivo / Red | Dirección IP |
|---|---|
| FortiGate WAN | `198.51.100.98/30` |
| ISP hacia FortiGate | `198.51.100.97/30` |
| FortiGate tránsito | `10.10.10.1/30` |
| MikroTik tránsito | `10.10.10.2/30` |
| Red de usuarios | `10.24.96.0/25` |
| Gateway usuarios | `10.24.96.1` |
| USER-PRIV | `10.24.96.119` |
| USER-NOPRIV | `10.24.96.120` |
| WEB-CAJA | `10.24.96.130/29` |
| Gateway WEB | `10.24.96.129` |
| FortiGate JUMP-LAN | `10.24.96.137/29` |
| JUMP-SERVER | `10.24.96.138/29` |
| Pool VPN | `10.24.99.10 - 10.24.99.20` |
| VPN-CLIENT WAN | `203.0.113.98/30` |
| ISP lado VPN | `203.0.113.97/30` |

---

## 🔐 Políticas principales del FortiGate

### NOPRIV_DENY_ADMIN

Bloquea al usuario no privilegiado el acceso administrativo mediante:

- SSH
- RDP

### USERS_VPN_TO_JUMP

Permite el acceso autorizado hacia el Jump Server mediante:

- HTTPS
- SSH
- RDP

### JUMP_TO_WEB

Permite que el Jump Server acceda al servidor WEB únicamente mediante:

- HTTPS `443`
- SSH `22`
- RDP `3389`

El resto del tráfico queda restringido por las políticas del firewall.

---

## 🔒 VPN IPsec

Se configuró una VPN IPsec entre el cliente remoto y el FortiGate.

El cliente VPN recibe una dirección del rango:

`10.24.99.10 - 10.24.99.20`

El túnel solamente permite acceso al:

`JUMP-SERVER - 10.24.96.138`

El cliente VPN no puede acceder directamente al servidor WEB.

---

## 🖥️ Jump Server

El Jump Server utiliza:

`10.24.96.138/29`

Su función es actuar como punto seguro de administración y acceso a los servidores internos.

Desde este equipo se comprobó acceso hacia `WEB-CAJA` mediante:

- HTTPS
- SSH
- RDP

---

## 🌐 Servidor WEB-CAJA

Dirección:

`10.24.96.130/29`

Servicios habilitados:

| Servicio | Puerto |
|---|---:|
| HTTPS | 443 |
| SSH | 22 |
| RDP | 3389 |

---

## 🧪 Pruebas realizadas

Se comprobaron los siguientes escenarios:

| Prueba | Resultado |
|---|---|
| JUMP → WEB HTTPS | ✅ Permitido |
| JUMP → WEB SSH | ✅ Permitido |
| JUMP → WEB RDP | ✅ Permitido |
| VPN → JUMP RDP | ✅ Permitido |
| VPN → WEB directamente | ❌ Bloqueado |
| USER-PRIV → JUMP RDP | ✅ Permitido |
| USER-NOPRIV → JUMP RDP | ❌ Bloqueado |

---

## 📸 Evidencias

Las capturas del laboratorio se encuentran dentro de la carpeta:

`evidencias/`

Incluyen:

- VPN IPsec establecida
- Políticas del FortiGate
- Interfaces del FortiGate
- Rutas estáticas
- Acceso RDP Jump → WEB
- Pruebas HTTPS, SSH y RDP
- Acceso VPN → Jump
- Bloqueo VPN → WEB
- Pruebas USER-PRIV
- Pruebas USER-NOPRIV

---

## ✅ Resultado

El laboratorio demuestra la implementación de una arquitectura segmentada y controlada mediante FortiGate, donde los accesos se limitan según el rol del usuario y los servicios estrictamente necesarios.

El cliente remoto utiliza una VPN IPsec y solamente puede acceder al Jump Server, mientras que el servidor WEB permanece protegido y accesible únicamente desde los puntos autorizados.
