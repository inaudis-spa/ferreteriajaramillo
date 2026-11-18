<?php
return [
    'db' => [
        'dsn' => getenv('LACUSTRE_DB_DSN') ?: 'mysql:host=127.0.0.1;dbname=ferreteria_lacustre;charset=utf8mb4',
        'user' => getenv('LACUSTRE_DB_USER') ?: 'root',
        'pass' => getenv('LACUSTRE_DB_PASS') ?: '',
    ],
    'image_max' => 8 * 1024 * 1024,
    'video_max' => 40 * 1024 * 1024,
];
