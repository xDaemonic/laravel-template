include .env

upload:
	 git add -A && git commit -m "local upload $(date '+%Y-%m-%d %H:%M:%S')" && git pull && git push

create:
	composer create-project laravel/laravel ./project \
	&& cd project \
	&& npm install \
	&& composer install \
	&& composer require predis/predis \
	&& composer require livewire/livewire && php artisan livewire:publish --config \
	&& composer require opcodesio/log-viewer && php artisan log-viewer:publish \
	&& composer require spatie/laravel-permission && php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider" \
	&& composer require laravel/horizon && php artisan horizon:install \
	&& composer require filament/filament:"^3.3" -W && php artisan filament:install --panels \
	&& cd ../ && docker compose build \
	&& docker volume create ${DB_VOLUME} && docker volume create ${REDIS_VOLUME}

