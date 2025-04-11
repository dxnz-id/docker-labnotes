# 📘 Documentation Setup: Laravel Filament `labnotes` with Docker

This documentation explains the steps to run the Laravel Filament `labnotes` project using Docker through the `docker-labnotes` repository.

## 📦 Repositories Used

-   [`labnotes`](https://github.com/dxnz-id/labnotes) — Laravel Filament Project
-   [`docker-labnotes`](https://github.com/dxnz-id/docker-labnotes) — Docker Environment to run `labnotes`

---

## 🚀 Installation Steps

### 1. Clone Both Repositories

```bash
git clone https://github.com/dxnz-id/labnotes.git
git clone https://github.com/dxnz-id/docker-labnotes.git
```

### 2. Setup the `labnotes` Project

Follow the documentation available in [`labnotes`](https://github.com/dxnz-id/labnotes) to configure the project to run normally in development mode.

> Ensure the project runs properly before moving it to Docker.

### 3. Move the Project into Docker

Copy all contents of the `labnotes` folder into the `app/` folder inside `docker-labnotes/`.

```bash
cp -r labnotes/* docker-labnotes/app/
```

> Ensure the directory structure looks like this:

```
docker-labnotes/
├── app/
│   ├── artisan
│   ├── app/
│   ├── public/
│   └── ...
```

### 4. Navigate to the `docker-labnotes` Folder

```bash
cd docker-labnotes
```

### 5. Configure `.env` for Laravel

Copy the example `.env` file and adjust the database configuration in the `docker-compose.yml` file:

```bash
cp .env.example app/.env
```

### 6. Build the Docker Container

```bash
docker compose build
```

### 7. Start Docker

```bash
docker compose up -d
```

### 8. Access the Container

Enter the container using the following command:

```bash
docker exec -it franken bash
```

> `franken` is the name of the main container (app). Ensure it matches the name in the `docker-compose.yml` file.

### 9. Run Migrations and Seeders

Inside the container, run:

```bash
php artisan migrate --seed
```

### 10. Link Storage

Still inside the container, run:

```bash
php artisan storage:link
```

## **Contact**

For any inquiries, feel free to reach out!

<a href="https://www.ko-fi.com/dxnzid">
<img src="https://cdn.ko-fi.com/cdn/kofi3.png?v=3" width="160" alt="ko-fi" />
</a>
