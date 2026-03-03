# FavoritesFeature
### Case Study: Architectural Integrity & Boundary Design

**FavoritesFeature** es un estudio de ingeniería en Swift diseñado para demostrar la **gestión de fronteras explícitas** y el control de dependencias direccionales. El propósito de este módulo no es la funcionalidad de "favoritos" per se, sino la creación de un núcleo de software inmune a la erosión tecnológica.

**Engineering Thesis:**
La arquitectura debe proteger el valor del negocio frente a la volatilidad de los detalles. Este sistema implementa una **Arquitectura Hexagonal** donde el dominio es el componente más estable, permitiendo cambios radicales en el almacenamiento o la red sin alterar la lógica de aplicación.

**Core Objectives:**
* **Domain Isolation:** Dependencia cero de frameworks externos (Pure Swift Standard Library).
* **Dependency Inversion:** Los detalles de infraestructura dependen del dominio a través de contratos, nunca a la inversa.
* **Testability as a Design Sensor:** Uso de TDD para detectar acoplamientos prematuros; si un test es difícil de escribir, el diseño es el que falla.
* **Substitutability:** Capacidad de intercambiar la persistencia (CoreData, Realm, In-Memory) sin afectar los Casos de Uso.

**Key Decisions (ADR):**
* **Decision:** Dependency Inversion via Domain Protocols.
* **Why:** Protege la lógica de negocio de APIs externas y cambios en proveedores de datos.
* **Trade-off:** Incrementa la "ceremonia" inicial de código a cambio de una resiliencia total al cambio.

* **Decision:** TDD as Architectural Linter.
* **Why:** Asegura que las fronteras no se erosionen por conveniencia técnica. Si un test de Use Case requiere infraestructura real, es una señal de contaminación arquitectónica.
* **Trade-off:** Prohíbe el uso de Singletons o estado global, exigiendo una inyección de dependencias rigurosa.

**Testing Strategy:**
Los tests actúan como una validación de la **integridad estructural**. No se testean frameworks de Apple ni integraciones de sistema, sino la pureza de las invariantes de negocio y el flujo de los casos de uso en aislamiento total.
