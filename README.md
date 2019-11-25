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

* **Github**: Para el desarrollo colaborativo del proyecto, Github nos permite trabajar individualmente y a distancia sin perder el trabajo en equipo. Fue seleccionado no sólo por ser la herramienta de desarrollo colaborativa más utilizada sino también por su facilidad para concetarse a Cloud Build, una de las herramientas dentro de Google Console Platform.
* **Cloud Build**: Dentro del desarrollo inicial del proyecto, Cloud Build nos permitió conectarnos directamente al repositorio de Github, lo que optimizó el desarrollo y pruebas en el frontend.
* **Frontend**: 
    * HTML 5: Las vistas dentro de la plataforma ITESM-Exchange están programadas en el lenguaje común HTML. Ha sido elegido por su facilidad en pruebas de diseño, pues no requiere ninguna instalación ni servidor para funcionar, lo que facilita las pruebas y cambios locales.
    * CSS: Al trabajar con vistas en el lenguaje HTML, los estilos CSS son imprescindibles. La calidad de las vistas aumenta así como la diversidad de formatos que pueda tener.
    * Javascript: Utilizado en la conexión del frontend con el API para realizar cambios dentro de las vistas según la información dentro de la base de datos.
    * Node.js: Uso de algunos módulos para el desarrollo del proyecto y su conexión a Cloud Endpoints. Ajax, Bootstrap y JQuery.
    * Bootstrap: Facilita el desarrollo de las vistas proporcionando librerías. Particularmente utilizado para la creación de tablas con la información proporcionada desde la base de datos.
    * Python: La velocidad de desarrollo de la API es considerablemente mayor a la que permite otros lenguajes. Rápida instalación de las librerías utilizadas en la solución como: SQLAlchemy, Flask, CORS, numpy y loggin.
* **Cloud Endpoints**:  La herramienta nos permite acceder al API desarrollada sin importar el lenguaje en el que ésta esté y para qué plataforma sea dirigida. Su sistema de autenticación por medio de llaves y tokens brinda la seguridad que el proyecto necesita para no ser manipulada o corrompida por agentes externos al Tecnológico de Monterrey. 
* **API**: todo desarrollado en el lenguaje de programación *Python*
    * Flask: microframework utilizado por su interacción nativa con bases de datos, lo que agiliza la creación del API.
    * SQLAlchemy: permite representar tablas y entidades de la base de datos a objetos en Python para facilitar la modificación, creación o inserción de información. 
    * CORS: Cross Origin Resource Sharing, programa que permite llamar endpoints dentro del mismo servidor. Cuando se desarrolló, se contaba con un servidor local. Una vez en producción este programa deja de utilizarse porque para cada componente se tienen servidores diferentes.
* **Backend**: La implementación de este servicio se desarrolló sobre la plataforma de GCP en una instancia de SQL Cloud con el lenguaje de programación *MySQL*. Su funcionamiento nativo dentro de la consola de Google, seguridad, administración y escalabilidad optimizaron el desarrollo y uso de la base de datos dentro de la solución.
* **Docker**: Herramienta que facilita desplegar la aplicación mediante el uso de contenedores.
* **Kubernetes**:  A diferencia de otras herramientas dentro de GCP -como App Engine- para desplegar aplicaciones, Kubernetes permite administrar la aplicación y sus servicios como si la infraestructura fuera propia. Políticas de escalabilidad, creación de servicios y versiones así como políticas de seguridad administradas por los desarrolladores y no por el proveedor de servicios en la nube, lo que lo vuelve mucho más flexible.

### 3.3 Frontend
El desarrollo del frontend está programado mediante el uso de un conjunto de herramientas web que tienen como resultado tres vistas: 
* **Login**: página para uso exclusivo de inicio de sesión que redirecciona a alguna de las otras páginas según corresponda el usuario que inició sesión.
* **Students**: dentro de esta vista los estudiantes podrán consultar las calificaciones de los cursos a los que están inscritos. 
* **Teachers**: aquí, los profesores extranjeros pueden ver la lista de sus alumnos, insertar, cambiar o bien, borrar calificaciones de cada uno de ellos.

#### 3.3.1 Lenguajes de programación
- **HTML 5**: Para la creación de la estructura general de las vistas.
- **CSS**: Formatos y estilos dentro de las vistas.
- **JavaScript**: Métodos de conexión; inserción, modificación y eliminación de datos en el frontend en conexión con la base de datos.

#### 3.3.2 Framework
- **Bootstrap**: Utilizado para la creación de tablas con la información proporcionada desde la base de datos.

#### 3.3.3 Librerías de funciones o dependencias
- Node Modules:
    * "fortawesome/fontawesome-free": "5.10.2"
    * "bootstrap": "4.3.1"
    * "chart.js": "2.8.0"
    * "datatables.net-bs4": "1.10.19"
    * "jquery": "3.4.1"
    * "connect": "^3.6.6"
    * "server": "^1.0.18"
    * "jquery.easing": "^1.4.1"
        
#### 3.3.4 Referencias
- [Portal skeleton](https://www.w3schools.com/w3css/tryw3css_templates_portfolio.htm)
- [Bootstrap Tutorial](https://www.w3schools.com/bootstrap4/default.asp)

### 3.4 Backend
El backend está compuesto por una sola instancia con una única base de datos llamada ***itesm-exchange*** la cual está alojada dentro de SQL Cloud de GCP. Es un modelo de base de datos relacional que contiene 5 tablas:
1. **users**:  Los usuarios cuentan con su información personal, correo, contraseña así como relaciones con las siguientes tablas. 
2. **user_type**: Tabla para hacer relacion con la información que debe tener un usuario dependiendo de sus permisos. Los posibles usuarios que pueden ingresar a la plataforma:
    * Estudiantes
    * Profesores
    * Administrador
3. **campus**: Almacena la información y descripción de los diferentes campus del Tecnológico de Monterrey.
4. **courses**: Almacena los diferentes cursos y sus descripciones.
5. **grades**: Asigna a cada estudiante una calificación por curso y profesor.

#### 3.4.1 Lenguaje de programación
- SQL
#### 3.4.2 Framework
- MySQL 5.7

### 3.5 API


#### 3.5.1 Lenguaje de programación
* Python 3.7.5
#### 3.5.2 Framework
* Flask
#### 3.5.3 Librerías de funciones o dependencias
* sqlalchemy
* import os
* import datetime
 * datetime
* passlib.apps
* itsdangerous
* import MySQL
* import mysql.connector
* dateutil
* decimal
* numpy
* import json
* import smtplib, ssl
* import requests
* import http.client
* import base64
* CORS
* logging

#### 3.5.4 Endpoints
1. Crear Usuario
    * **Descripción**:
    * **URL**: **link de Google Endpoints**/api/users
    * **Headers**:
    * **Formato JSON del cuerpo de la solicitud**: 
    * **Formato JSON de la respuesta**:
2. 
    * **Descripción**:
    * **URL**: **link de Google Endpoints**/
    * **Verbos HTTP**:
    * **Headers**: 
        * Key: Content-Type
        * Value: application/json
        * Description: -
    * **Formato JSON del cuerpo de la solicitud**: 
    * **Formato JSON de la respuesta**:


## 3.6 Pasos a seguir para utilizar el proyecto

*[Incluya aquí una guía paso a paso para poder utilizar el proyecto, desde la clonación de este repositorio hasta el despliegue de la solución en una plataforma en la nube.]*

## 4. Referencias
- [Implementa una aplicación web en contenedor](https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app?hl=es-419)
- [Comenzar a usar Endpoints en Kubernetes](https://cloud.google.com/endpoints/docs/openapi/get-started-kubernetes?hl=es-419)
- [Portal skeleton](https://www.w3schools.com/w3css/tryw3css_templates_portfolio.htm)
- [Bootstrap Tutorial](https://www.w3schools.com/bootstrap4/default.asp)
