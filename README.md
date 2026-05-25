# School Management API

REST API for managing students and school classes.

Test assignment implemented with:

- Ruby on Rails API
- PostgreSQL
- Docker / Docker Compose
- Swagger (OpenAPI)

---

# Requirements

- Docker
- Docker Compose

---

# Run project

Clone repository:

```bash
git clone https://github.com/iampsih/school-management-api.git
cd school-management-api
```

Build and start containers:

```bash
docker compose up --build
```

In another terminal create database and run migrations:

```bash
docker compose exec app bin/rails db:create
docker compose exec app bin/rails db:migrate
docker compose exec app bin/rails db:seed
```

Application will be available at:

```text
http://localhost:3000
```

---

# Swagger / OpenAPI

Swagger UI:

```text
http://localhost:3000/api-docs
```

OpenAPI schema:

```text
http://localhost:3000/api-docs/openapi.yaml
```

---

# API Endpoints

## Create student

```http
POST /students
```

Request:

```json
{
  "student": {
    "first_name": "Merey",
    "last_name": "Bolat",
    "surname": "Test",
    "school_id": 1,
    "classroom_id": 1
  }
}
```

Response:

```json
{
  "id": 1,
  "first_name": "Merey",
  "last_name": "Bolat",
  "surname": "Test",
  "class_id": 1,
  "school_id": 1
}
```

Auth token is returned in header:

```text
X-Auth-Token
```

---

## Delete student

```http
DELETE /students/:user_id
```

Headers:

```text
Authorization: Bearer TOKEN
```

---

## Get school classes

```http
GET /schools/:school_id/classes
```

---

## Get classroom students

```http
GET /schools/:school_id/classes/:class_id/students
```

---

# Run tests

```bash
docker compose exec app bin/rails test
```

---

# Architecture

Project structure:

```text
controllers -> services -> models
```

Business logic is extracted into service layer.

Serializers are used for consistent JSON responses.

---

# Technologies

- Ruby 3.3
- Rails 7.1
- PostgreSQL 16
- Docker Compose
- Minitest