<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" data-bs-theme="dark">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Sistema de ventas para gestionar compras, ventas
    clientes, proveedores, productos, categorías, etc. Ideal para pequeños y medianos negocios que deesen 
    automatizar sus procesos y tener a la mano cualquier información sobre su negocio" />
    <meta name="author" content="Anahui.sac" />
    <title>Sistema de venta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>

<style>
    body {
            font-family: 'Inter', sans-serif;
            background-color: #04111a;
        }
        h2, h3, h4 {
            font-weight: 700;
        }
        .highlight {
            color: #fff;
        }
        .bg-gradient-section {
            background: linear-gradient(135deg, #04111a 0%, #6610f2 100%);
            color: white;
            border-radius: 12px;
            padding: 3rem;
        }
        .section-title {
            border-left: 5px solid #FFFF;
            padding-left: 1rem;
        }
        .icon-check {
            color: #FFFF;
            margin-right: 0.5rem;
        }
        
</style>
<body>

    <!--Barra de navegación--->
    <nav class="navbar navbar-expand-md bg-body-secondary">
        <div class="container-fluid">
            <!---Marca navegación-->
            <a class="navbar-brand" href="{{route('panel')}}">
                <img src="{{ asset('assets/img/icon.png') }}" alt="Logo" width="30" height="30" class="d-inline-block align-text-top">
                Corporacion Anahui.sac
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!----Lista de opciones del menú-->
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="{{route('panel')}}">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Acerca de</a>
                    </li>
                </ul>

                <form class="d-flex" action="{{route('login.index')}}" method="get">
                    <button class="btn btn-primary" type="submit">Iniciar sesión</button>
                </form>

            </div>
        </div>
    </nav>

    <!----Carrusel--->
    <div id="carouselExample" class="carousel slide carousel-fade">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="{{asset('assets/img/img_carrusel_1.png')}}" class="d-block w-100" alt="banner de invitacion">
            </div>
            <div class="carousel-item">
                <img src="{{asset('assets/img/img_carrusel_2.png')}}" class="d-block w-100" alt="Banner de publicidad">
            </div>
            <div class="carousel-item">
                <img src="{{asset('assets/img/img_carrusel_3.png')}}" class="d-block w-100" alt="Banner de contáctanos">
            </div>
            <div class="carousel-item">
                <img src="{{asset('assets/img/anahui.png')}}" class="d-block w-100" alt="Banner de contáctanos">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

     <!-- Sección: Problema y Solución -->
    <section class="container py-5">
        <div class="row">
            <div class="col-md-12">
                <h2 class="section-title text-white mb-4">¿Por qué invertir en nuestro sistema?</h2>
                <p class="text-light">En la era digital, muchas pymes aún utilizan métodos manuales para gestionar su inventario. Esto limita su crecimiento, provoca pérdidas y dificulta la toma de decisiones. La falta de visibilidad en tiempo real y de reportes precisos afecta directamente la competitividad del negocio.</p>
                <p class="text-light">Nuestra solución digital transforma la manera en que las empresas manejan su inventario. Es adaptable, segura y escalable para crecer junto a cada negocio.</p>

                <h3 class="text-success fw-semibold mt-5">¿Qué ofrecemos?</h3>
                <ul class="text-light">
                    <li><span class="icon-check">✔</span>Control total del inventario en tiempo real.</li>
                    <li><span class="icon-check">✔</span>Automatización de procesos: ventas, compras y stock.</li>
                    <li><span class="icon-check">✔</span>Reportes inteligentes para decisiones estratégicas.</li>
                    <li><span class="icon-check">✔</span>Diseño multiempresa, adaptable a cada modelo de negocio.</li>
                    <li><span class="icon-check">✔</span>Seguridad avanzada y control de accesos por roles.</li>
                </ul>
                <p class="text-light">Invertir en nuestro sistema es apostar por eficiencia, crecimiento y competitividad.</p>
            </div>
        </div>
    </section>

    <!-- Sección: Objetivos del Sistema -->
    <section class="container py-5">
        <div class="bg-gradient-section">
            <h2 class="section-title mb-4">Objetivos del Proyecto</h2>

            <h4 class="mb-3">🎯 Objetivo General</h4>
            <p>Desarrollar un sistema de gestión de inventario que optimice la logística empresarial, automatice tareas clave y empodere a los negocios con información en tiempo real para tomar mejores decisiones.</p>

            <h4 class="mt-4 mb-3">✅ Objetivos Específicos</h4>
            <ul>
                <li><span class="icon-check">✔</span>Implementar operaciones CRUD eficientes y seguras para la gestión de productos.</li>
                <li><span class="icon-check">✔</span>Actualizar automáticamente los niveles de stock con cada transacción.</li>
                <li><span class="icon-check">✔</span>Asignar roles de usuario con permisos diferenciados para proteger la información.</li>
                <li><span class="icon-check">✔</span>Generar reportes visuales y personalizados sobre el estado del negocio.</li>
                <li><span class="icon-check">✔</span>Crear una interfaz intuitiva y amigable para usuarios sin conocimientos técnicos.</li>
            </ul>
        </div>
    </section>

    <!---Section Ventajas / Desventajas--->
    <div class="container-md">
        <div class="row my-4 g-5">
            <div class="col-lg-6">
                <div class="card border-0">
                    <div class="card-header text-center text-info border-info fs-5 fw-semibold border-3 rounded-start rounded-end">
                        Con un sistema de ventas web
                    </div>
                    <div class="card-body">
                        <ul class="text-light">
                            <li>
                                <p class="card-text mb-2">Tienes acceso a tu sistema 24/7 y desde cualquier parte.</p>
                            </li>
                            <li>
                                <p class="card-text mb-2">Permite la automatización de tareas como la gestión de inventario,
                                    el procesamiento de pedidos y la recopilación de datos,
                                    lo que ahorra tiempo y reduce errores.</p>
                            </li>
                            <li>
                                <p class="card-text mb-2">Proporcionan datos valiosos sobre el comportamiento de los clientes,
                                    lo que te permite tomar mejores desiciones.</p>
                            </li>
                            <li>
                                <p class="card-text mb-2">Puedes expandir tu negocio en línea de manera relativamente sencilla
                                    al agregar más productos, servicios o incluso dirigirte a nuevos mercados.</p>
                            </li>
                        </ul>

                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card border-0">
                    <div class="card-header text-center text-info border-info fs-5 fw-semibold border-3 rounded-start rounded-end">
                        Sin un sistema de ventas web
                    </div>
                    <div class="card-body">
                        <ul class="text-light">
                            <li>
                                <p class="card-text mb-2">Estas sujeto a un horario de funcioamiento específico.</p>
                            </li>
                            <li>
                                <p class="card-text mb-2">Las operaciones sin un sistema web a menudo requieren una mayor cantidad de trabajo manual,
                                    lo que puede llevar más tiempo y aumentar la posibilidad de errores.</p>
                            </li>
                            <li>
                                <p class="card-text mb-2">Dificulta la recopilación y análisis de datos sobre el rendimiento del
                                    negocio y el comportamiento de los clientes.</p>
                            </li>
                            <li>
                                <p class="card-text mb-2">La expansión de un negocio físico puede ser más complicada y costosa en
                                    términos de abrir nuevas ubicaciones o llegar a un mercado más amplio.</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!---Footer--->
    <footer class="text-center text-white">
        <!-- Copyright -->
        <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
            © 2023 Copyright:
            <a class="text-white" href="#">Textil Anahui.com</a>
        </div>
        <!-- Copyright -->
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>

</html>