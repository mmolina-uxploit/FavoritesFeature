# FavoritesFeature

`FavoritesFeature` es un caso de estudio arquitectónico en Swift diseñado para demostrar la **gestión del cambio, fronteras explícitas y dependencias direccionales**. El propósito del proyecto no es la funcionalidad de "favoritos" en sí, sino la creación de un núcleo de software inmune a la erosión tecnológica y cambios de infraestructura.

---

## Project Overview
El sistema resuelve el acoplamiento entre la lógica de negocio y detalles volátiles (UI, DB, Network). Implementa una arquitectura donde el **Domain** es el componente más estable, permitiendo que el backend o la persistencia cambien radicalmente sin tocar una sola línea de lógica de aplicación. 


## Engineering Goals
* **Aislamiento del Dominio:** Dependencia cero de frameworks externos (Swift Standard Library únicamente).
* **Inversión de Dependencias:** Uso de contratos para que la infraestructura dependa del dominio y no a la inversa.
* **Testabilidad como Sensor:** TDD utilizado para detectar acoplamientos prematuros y fallas en el diseño de fronteras.
* **Sustituibilidad:** Capacidad de intercambiar la capa de datos (In-memory/Local/Remote) sin modificar Casos de Uso.


## Architecture
Implementa una **Arquitectura Hexagonal (Clean)** basada en la estabilidad estructural. Las dependencias siempre apuntan hacia el código más estable (Domain).

* **Domain (Core):** Entidades e invariantes. Contiene `protocols` que expresan necesidades de negocio sin conocer detalles técnicos.
* **Application (Use Cases):** Orquestación de la intención del negocio. Define el *qué* se hace, coordinando los contratos del dominio.
* **Infrastructure:** Detalles técnicos (Persistencia/API). Implementa los contratos del dominio y es totalmente reemplazable.
* **UI:** Capa de integración mínima. Observa estado y ejecuta casos de uso; no contiene lógica de negocio.


## Architectural Decisions (ADR-lite)

**Decision: Dependency Inversion via Domain Protocols**
* **Context:** La persistencia es un detalle propenso a cambios (CoreData, Realm, SwiftData).
* **Why:** Protege el modelo de dominio de APIs externas y cambios en proveedores de datos.
* **Tradeoffs:** Incrementa la cantidad de archivos iniciales y la ceremonia de código.

**Decision: TDD as Architectural Linter**
* **Context:** Necesidad de asegurar que las fronteras no se erosionen por conveniencia técnica.
* **Why:** Si un test de Use Case requiere infraestructura real (DB o Red), es una señal inmediata de contaminación arquitectónica.
* **Tradeoffs:** Requiere disciplina; prohíbe el uso de singletons o estado global.


## Technology Stack
* **Swift:** Tipado fuerte para definición de contratos e interfaces.
* **XCTest:** Validación de fronteras y lógica de negocio en aislamiento total.
* **Mocks de Infraestructura:** Para ejecución y testing sin dependencias laterales.


## Testing Strategy
* **Qué se protege:** Invariantes de negocio y el flujo de los Casos de Uso.
* **Qué NO se testea:** Frameworks de Apple (UI) o integraciones de sistema operativo.
* **Rol de los Tests:** Actúan como validación de diseño. Si un test es difícil de escribir, el problema es la arquitectura (acoplamiento), no el test.


## Project Structure
* `Domain/`: Entidades de negocio y definiciones de protocolos.
* `Application/`: Lógica de Casos de Uso (Orquestación).
* `Infrastructure/`: Adaptadores de datos (In-memory / Mocks).
* `Presentation/`: Capa de UI y ViewModels.


## Execution
1.  Abrir `FavoritesFeature.xcodeproj`.
2.  `Cmd + U` para ejecutar la suite de validación técnica (Tests). Los tests confirman la integridad de las fronteras.
3.  Ejecutar en Simulador para validar la integración mínima de UI.


## Engineering Tradeoffs & Limitations
* **Complejidad Inicial:** Se acepta una mayor "ceremonia" de código a cambio de reducir drásticamente el costo de cambio futuro.
* **Abstracción de Persistencia:** El sistema está optimizado para ser *resiliente* al cambio, no para ser *rápido* de implementar en una fase inicial de prototipado simple.


