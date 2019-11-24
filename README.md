# ITESM-Exchange
---
#### Materia: Desarrollo de aplicaciones en la nube (TC3059)

##### Campus: Santa Fe

##### Integrantes:
1. Andrés Campos Tams A01024385
2. Diego Kaleb Valenzuela Carrillo A01018992

---
## 1. Aspectos generales

### 1.1 Requerimientos técnicos

A continuación se mencionan los requerimientos técnicos mínimos del proyecto, favor de tenerlos presente para que cumpla con todos.

* El equipo tiene la libertad de elegir las tecnologías de desarrollo a utilizar en el proyecto, sin embargo, debe tener presente que la solución final se deberá ejecutar en una de las siguientes plataformas en la nube: [Google Cloud Platform](https://cloud.google.com/?hl=es), [Amazon Web Services](https://aws.amazon.com/) o [Microsoft Azure](https://azure.microsoft.com/es-mx/).
* El proyecto deberá utilizar 
* La solución debe utilizar una arquitectura de microservicios. Si no tiene conocimiento sobre este tema, le recomendamos la lectura [*Microservices*](https://martinfowler.com/articles/microservices.html) de [Martin Fowler](https://martinfowler.com).
* La arquitectura debe ser modular, escalable, con redundancia y alta disponibilidad.
* La arquitectura deberá estar separada claramente por capas (*frontend*, *backend*, *API RESTful*, datos y almacenamiento).
* Deberá utilizarse contenedores [Docker](https://www.docker.com/) y un orquestador como [Kubernetes](https://kubernetes.io/).
* La API deberá utilizar autenticación y estar desplegada detrás de un API Manager como [Cloud Endpoints](https://cloud.google.com/endpoints/).
* El proyecto deberá contar con los archivos de configuración y *scripts* necesarios para crear toda la infraestructura necesaria, utilizando alguna solución de *Infraestructure as a Code* como [Deployment Manager](https://cloud.google.com/deployment-manager/).
* Todo el código, *datasets* y la documentación del proyecto debe alojarse en este repositorio de GitHub. Favor de mantener la estructura de carpetas propuesta.

### 1.2 Estructura del repositorio
El proyecto debe seguir la siguiente estructura de carpetas, la cual generamos por usted:
```
- / 			        # Raíz de todo el proyecto
    - README.md			# Archivo con los datos del proyecto (este archivo)
    - frontend			# Carpeta con la solución del frontend (Web app)
    - backend			  # Carpeta con la solución del backend (CMS)
    - api			      # Carpeta con la solución de la API
    - datasets		  # Carpeta con los datasets y recursos utilizados (csv, json, audio, videos, entre otros)
    - dbs			      # Carpeta con los modelos, catálogos y scripts necesarios para generar las bases de datos
    - models			  # Carpeta donde se almacenarán los modelos de Machine Learning ya entrenados
    - docs			    # Carpeta con la documentación del proyecto
```

### 1.3 Documentación  del proyecto

Como parte de la entrega final del proyecto, se debe incluir la siguiente información:

* Descripción del problema a resolver.
* Diagrama con la arquitectura de la solución.
* Descripción de cada uno de los componentes de la arquitectura.
* Justificación de los componentes seleccionados.
* Explicación del flujo de información en la arquitectura.
* Descripción de las fuentes de información utilizadas (archivos CSV, JSON, TXT, bases de datos, entre otras).
* Guía de configuración, instalación y despliegue de la solución en la plataforma en la nube seleccionada.
* Documentación de la API. Puede ver un ejemplo en [Swagger](https://swagger.io/). 
* El código debe estar documentado siguiendo los estándares definidos para el lenguaje de programación seleccionado.

## 2. Descripción del proyecto

Hoy en día, el Departamento de Programas Internacionales del Tecnológico de Monterrey no tiene su propio sistema de calificaciones, cuando un estudiante está en una universidad en el extranjero, esa universidad debe registrar las calificaciones manualmente o en una plataforma distinta de cualquier sistema ITESM. Posteriormente, al final de cada periodo, Programas Internacionales recibe una lista para cada una de las universidades afiliadas, incluyendo las calificaciones de los estudiantes que asistieron durante ese período.

**El proceso actual lleva mucho tiempo y no es muy transparente**, ya que un estudiante puede verificar sus calificaciones hasta que  Programas Internacionales las apruebe, las envíe a los directores de cada carrera y, hasta ese momento, los carguen en la plataforma del Tecnológico de Monterrey.

Los estudiantes que son candidatos para la graduación tienden a tener problemas con las calificaciones de aquellas materias que tomaron en el extranjero un período antes de su fecha de graduación, por lo que los Programas Internacionales y los departamentos de carreras siempre tienen que "apresurar" el proceso para terminar a tiempo.

## 3. Solución

A continuación aparecen descritos los diferentes elementos que forman parte de la solución del proyecto.

El desarrollo de este proyecto se alojará como un servicio web en línea para estudiantes que estudian un programa universitario en el extranjero. La plataforma se desarrollará utilizando las herramientas de la Plataforma Google Console, que incluyen:  **VPC Networks, Network Services, Storage, Cloud Build, SQL Storage, Kubernetes Engine y Cloud Endpoints.**

Además, se utilizarán herramientas para el desarrollo de la aplicación que son diferentes a las incluidas en Google, las cuales son:
* HTML 5
* Node.js
* Javascript
* CSS
* Python
* Flask
* MySQL
* SQLAlchemy
* Docker

El proyecto pretende optimizar el proceso de calificación para los estudiantes que estudian en América del Norte y Europa. Se espera que la plataforma se use, más adelante, en todo el mundo y con todas las universidades afiliadas al Tecnológico de Monterrey.

El alcance incluye: diseño, desarrollo, prueba, operación e implementación de la solución. 
No incluye: mantenimiento, capacitación o cualquier otro servicio una vez que la solución se implementa y se prueba.

### 3.1 Arquitectura de la solución
![Alt text](docs/Arquitectura-De-Software.png?raw=true "Arquitectura de la solución")
Descripción:
1. **Github**: El desarrollo colaborativo del presente proyecto se realizó a través de la plataforma Github, donde los participantes consultamos, creamos y actualizamos información relevante para la solución del mismo.
2. **Cloud Build**: El repositorio colaborativo está conectado con la plataforma de GCP a través de un disparador (*trigger*) creado en Cloud Build con fines de desarrollo inicial.
3. **Frontend**: Cloud Build realiza cambios directos en la configuración del frontend, mismo que está construido con las siguientes herramientas: **HTML, CSS, Javascript, Node.js y Bootstrap**
4. **Cloud Endpoints**: La conexión para llegar a la instancia de la base de datos con la finalidad de consumir información se realiza mediante la herramienta de Cloud Endpoints, la cual controla el acceso a la información a través de URLs para cada microservicio.
5. **API**: La programación de la API controla las solicitudes con el uso de métodos **POST, GET** y **PUT** para poder insertar, consultar y modificar información de la base de datos, respectivamente.
6. **Backend**: Programado en el lenguaje MySQL, la base de datos almacena toda la información requerida en el proyecto. En conjunto con la API, ésta realiza inserciones, consultas y modificaciones según la actividad que la plataforma lo requiera.
7. **API**: Una vez que la información haya sido consultada, modificada o insertada en la base de datos, la API recibe una confirmación o bien un código de error o éxito.
8. **Cloud Endpoints**: Al terminar el consumo del microservicio dentro del URL, los cambios se ven reflejados en el frontend.
9. **Docker**: La aplicación es entonces, capturada dentro de un contenedor Docker para su publicación.
10. **Kubernetes**: Con la aplicación ya dentro de un contenedor, Kubernetes orquesta la aplicación así como sus diferentes y posibles versiones para su o sus publicaciones.
11. **ITESM-Exchange**: Al finalizar el proceso descrito anteriormente y realizándose el número de veces que se requiera, la solución está disponible para ser consumida en tiempo real y en todo el mundo. 

### 3.2 Descripción de los componentes

*[Incluya aquí una descripción detallada de cada uno de los componentes de la arquitectura así como una justificación de la selección de cada componente]*
1. **Github**: 
2. **Cloud Build**: 
3. **Frontend**: 
    * algo
4. **Cloud Endpoints**:  
5. **API**: 
    * algo
6. **Backend**:
    * algo
7. **Docker**: 
8. **Kubernetes**:  

### 3.3 Frontend

*[Incluya aquí una explicación de la solución utilizada para el frontend del proyecto. No olvide incluir las ligas o referencias donde se puede encontrar información de los lenguajes de programación, frameworks y librerías utilizadas.]*

#### 3.3.1 Lenguaje de programación
#### 3.3.2 Framework
#### 3.3.3 Librerías de funciones o dependencias

### 3.4 Backend

*[Incluya aquí una explicación de la solución utilizada para el backend del proyecto. No olvide incluir las ligas o referencias donde se puede encontrar información de los lenguajes de programación, frameworks y librerías utilizadas.]*

#### 3.4.1 Lenguaje de programación
#### 3.4.2 Framework
#### 3.4.3 Librerías de funciones o dependencias

### 3.5 API

*[Incluya aquí una explicación de la solución utilizada para implementar la API del proyecto. No olvide incluir las ligas o referencias donde se puede encontrar información de los lenguajes de programación, frameworks y librerías utilizadas.]*

#### 3.5.1 Lenguaje de programación
#### 3.5.2 Framework
#### 3.5.3 Librerías de funciones o dependencias

*[Incluya aquí una explicación de cada uno de los endpoints que forman parte de la API. Cada endpoint debe estar correctamente documentado.]*

*[Por cada endpoint debe incluir lo siguiente:]*

* **Descripción**:
* **URL**:
* **Verbos HTTP**:
* **Headers**:
* **Formato JSON del cuerpo de la solicitud**: 
* **Formato JSON de la respuesta**:


## 3.6 Pasos a seguir para utilizar el proyecto

*[Incluya aquí una guía paso a paso para poder utilizar el proyecto, desde la clonación de este repositorio hasta el despliegue de la solución en una plataforma en la nube.]*

## 4. Referencias

*[Incluya aquí las referencias a sitios de interés, datasets y cualquier otra información que haya utilizado para realizar el proyecto y que le puedan ser de utilidad a otras personas que quieran usarlo como referencia]*
