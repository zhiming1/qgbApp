server {
    listen 80;
    server_name _;

    root /var/www/html/public;
    index index.php index.html;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    # PHP 通过 php-fpm 容器处理
    location ~ \.php$ {
        fastcgi_pass   php:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include        fastcgi_params;
    }

    # 静态资源缓存（可选）
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        try_files $uri $uri/ @laravel;
        expires 7d;
        access_log off;
    }

    location @laravel {
        rewrite ^/(.*)$ /index.php?$query_string last;
    }
}