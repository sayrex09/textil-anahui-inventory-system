<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Ventas - Login</title>
    <link href="{{ asset('css/styles.css') }}" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            background: url('{{ asset('assets/img/inventario.png') }}') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .auth-card {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 1rem;
            max-width: 400px;
            width: 100%;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        }

        .auth-logo {
            margin-bottom: 1rem;
        }

        .auth-logo img {
            max-width: 180px;
        }

        .auth-msg {
            font-size: 1.5rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 1rem;
            color: #black;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(30, 58, 138, 0.25);
            border-color: #1e3a8a;
        }

        .auth-button {
            background-color: #1e3a8a;
            color: white;
            width: 100%;
            border: none;
            padding: 0.75rem;
            font-weight: bold;
            border-radius: 0.5rem;
            transition: background-color 0.3s ease;
        }

        .auth-button:hover {
            background-color: #3b82f6;
        }

        .help-block {
            color: red;
            font-size: 0.875rem;
        }

        @media (max-width: 576px) {
            .auth-card {
                margin: 1rem;
                padding: 1.5rem;
            }

            .auth-msg {
                font-size: 1.25rem;
            }
        }
    </style>
</head>
<body>

    <div class="auth-card">
        <div class="auth-logo">
            <img src="{{ url('assets/img/logo.png') }}" alt="Logo del sistema">
        </div>
        <div class="auth-msg">Iniciar sesión</div>
        <form method="POST" action="{{ route('login.login') }}">
            @csrf

            <div class="mb-3">
                <label for="email" class="form-label">Correo electrónico</label>
                <input type="email" name="email" class="form-control" id="email" placeholder="tucorreo@dominio.com" required autofocus>
                @error('email')
                    <div class="help-block">{{ $message }}</div>
                @enderror
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Contraseña</label>
                <input type="password" name="password" class="form-control" id="password" placeholder="********" required>
                @error('password')
                    <div class="help-block">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>
                <label class="form-check-label" for="remember">Recordar sesión</label>
            </div>

            <button type="submit" class="auth-button">Ingresar</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
