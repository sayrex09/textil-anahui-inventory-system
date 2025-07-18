echo "🔍 Detectando tecnologías..." && \
php -v 2>/dev/null && \
[ -f composer.json ] && echo "📦 Composer encontrado: $(grep -i require composer.json)" && \
grep -RiE 'bootstrap|jquery|vue|react' . --color=always | head -n 10 && \
grep -RiE 'localhost|mysql|pdo' . --color=always | head -n 10
