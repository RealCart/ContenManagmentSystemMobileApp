# 🚀 CMS API - Documentation

> AI-powered Instagram Post Generator with GPT-4o Vision

**Version:** 1.0.0 | **Base URL:** `http://localhost:8080`

---

## 📋 Table of Contents

- [Authentication](#-authentication)
- [Users](#-users)
- [Posts](#-posts)
- [Error Handling](#-error-handling)

---

## 🔐 Authentication

### 1. Health Check

```http
GET /api/auth/health
```

**Response:**
```json
"Auth service is running"
```

---

### 2. Register User

```http
POST /api/auth/register
Content-Type: application/json
```

**Request Body:**
```json
{
  "username": "yakupovdev",
  "password": "password123"
}
```

**Response (Success):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ5YWt1cG92ZGV2IiwiaWF0IjoxNzMxNjk0MjM4LCJleHAiOjE3MzE3ODA2Mzh9.7K3xP9mQ4nR5sT6uV8wX0yZ1aB2cD3eF4gH5iJ6kL7m",
  "username": "yakupovdev",
  "message": "User registered successfully"
}
```

**Response (Error - Username Exists):**
```json
{
  "timestamp": "2025-11-15T18:30:38.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Username already exists",
  "path": "/api/auth/register"
}
```

**Response (Error - Validation Failed):**
```json
{
  "timestamp": "2025-11-15T18:30:38.000+00:00",
  "status": 400,
  "error": "Validation Failed",
  "errors": {
    "username": "Username must be between 3 and 50 characters",
    "password": "Password must be at least 8 characters"
  },
  "path": "/api/auth/register"
}
```

---

### 3. Login

```http
POST /api/auth/login
Content-Type: application/json
```

**Request Body:**
```json
{
  "username": "yakupovdev",
  "password": "password123"
}
```

**Response (Success):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ5YWt1cG92ZGV2IiwiaWF0IjoxNzMxNjk0MjM4LCJleHAiOjE3MzE3ODA2Mzh9.7K3xP9mQ4nR5sT6uV8wX0yZ1aB2cD3eF4gH5iJ6kL7m",
  "username": "yakupovdev",
  "message": "Login successful"
}
```

**Response (Error - Invalid Credentials):**
```json
{
  "timestamp": "2025-11-15T18:30:38.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Invalid username or password",
  "path": "/api/auth/login"
}
```

---

## 👤 Users

### 4. Get Current User Info

```http
GET /api/users/me
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

**Response (Success):**
```json
{
  "id": 1,
  "username": "yakupovdev",
  "createdAt": "2025-11-15T18:15:30",
  "totalPosts": 3
}
```

**Response (Error - Unauthorized):**
```json
{
  "timestamp": "2025-11-15T18:30:38.000+00:00",
  "status": 403,
  "error": "Forbidden",
  "message": "Access Denied",
  "path": "/api/users/me"
}
```

---

## 📝 Posts

### 5. Generate Post (Without Saving)

```http
POST /api/posts/generate
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
Content-Type: multipart/form-data
```

**Request Body:**
```json
{
  "photo": "[binary file]",
  "description": "Beautiful sunset at the beach with palm trees",
  "hashtags": ["sunset", "beach", "nature"],
  "size": "MEDIUM"
}
```

**Response (Success - With Photo):**
```json
{
  "generatedDescription": "🌅 The golden hour transforms the sky into a breathtaking canvas of warm oranges, soft pinks, and deep purples as the sun sets over the tranquil ocean. The silhouettes of palm trees frame this stunning view perfectly, their dark outlines creating a beautiful contrast against the vibrant sky.\n\nThe gentle waves reflect the sun's last rays, creating a shimmering path of light across the water. This peaceful moment captures the essence of tropical paradise - where time seems to slow down and all that matters is the beauty unfolding before your eyes.\n\nWhat's your favorite sunset spot? Drop it in the comments! 👇\n\n#sunset #beach #nature",
  "originalDescription": "Beautiful sunset at the beach with palm trees",
  "hashtags": "#sunset #beach #nature",
  "tempPhotoPath": "uploads\\temp\\temp_f4e3d2c1-b5a6-4789-cdef-1234567890ab.jpg",
  "size": "MEDIUM",
  "generatedAt": "2025-11-15T18:20:30"
}
```

**Response (Success - Without Photo):**
```json
{
  "generatedDescription": "✨ Beautiful sunset at the beach creates the perfect moment to pause and appreciate nature's daily masterpiece. The warm colors painting the sky remind us of life's simple pleasures and the beauty that surrounds us every day.\n\nTake a moment to breathe, reflect, and be grateful for these peaceful moments.\n\n#sunset #beach #nature",
  "originalDescription": "Beautiful sunset at the beach with palm trees",
  "hashtags": "#sunset #beach #nature",
  "tempPhotoPath": null,
  "size": "MEDIUM",
  "generatedAt": "2025-11-15T18:20:30"
}
```

---

### 6. Save Generated Post

```http
POST /api/posts/save
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
Content-Type: application/json
```

**Request Body:**
```json
{
  "generatedDescription": "🌅 The golden hour transforms the sky into a breathtaking canvas of warm oranges, soft pinks, and deep purples as the sun sets over the tranquil ocean. The silhouettes of palm trees frame this stunning view perfectly.\n\nWhat's your favorite sunset spot? Drop it in the comments! 👇\n\n#sunset #beach #nature",
  "originalDescription": "Beautiful sunset at the beach with palm trees",
  "hashtags": "#sunset #beach #nature",
  "tempPhotoPath": "uploads\\temp\\temp_f4e3d2c1-b5a6-4789-cdef-1234567890ab.jpg",
  "size": "MEDIUM"
}
```

**Response (Success):**
```json
{
  "id": 1,
  "generatedDescription": "🌅 The golden hour transforms the sky into a breathtaking canvas of warm oranges, soft pinks, and deep purples as the sun sets over the tranquil ocean. The silhouettes of palm trees frame this stunning view perfectly.\n\nWhat's your favorite sunset spot? Drop it in the comments! 👇\n\n#sunset #beach #nature",
  "originalDescription": "Beautiful sunset at the beach with palm trees",
  "hashtags": "#sunset #beach #nature",
  "photoPath": "uploads\\f4e3d2c1-b5a6-4789-cdef-1234567890ab.jpg",
  "size": "MEDIUM",
  "createdAt": "2025-11-15T18:21:45"
}
```

**Response (Error - Validation Failed):**
```json
{
  "timestamp": "2025-11-15T18:30:38.000+00:00",
  "status": 400,
  "error": "Validation Failed",
  "errors": {
    "generatedDescription": "Generated description is required",
    "size": "Size is required"
  },
  "path": "/api/posts/save"
}
```

---

### 7. Generate and Save Post (Legacy)

```http
POST /api/posts/generate-and-save
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
Content-Type: multipart/form-data
```

**Request Body:**
```json
{
  "photo": "[binary file]",
  "description": "Epic mountain hiking adventure",
  "hashtags": ["mountains", "hiking", "adventure"],
  "size": "LONG"
}
```

**Response (Success):**
```json
{
  "id": 2,
  "generatedDescription": "🏔️ Standing at the peak, surrounded by majestic mountains that touch the sky, this moment reminds me why I love adventure. The crisp mountain air, the stunning panoramic views, and the sense of accomplishment after a challenging hike make every step worth it.\n\nThere's something incredibly humbling about being in nature's presence, witnessing its raw beauty and power. The journey to the top tested my limits, but the reward? Absolutely breathtaking.\n\nEvery mountain top is within reach if you just keep climbing. What's your next adventure?\n\n#mountains #hiking #adventure",
  "originalDescription": "Epic mountain hiking adventure",
  "hashtags": "#mountains #hiking #adventure",
  "photoPath": "uploads\\a1b2c3d4-e5f6-7890-abcd-ef1234567890.jpg",
  "size": "LONG",
  "createdAt": "2025-11-15T18:25:12"
}
```

---

### 8. Get All User Posts

```http
GET /api/posts
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

**Response (Success):**
```json
[
  {
    "id": 2,
    "generatedDescription": "🏔️ Standing at the peak, surrounded by majestic mountains that touch the sky, this moment reminds me why I love adventure. The crisp mountain air, the stunning panoramic views, and the sense of accomplishment after a challenging hike make every step worth it.\n\nThere's something incredibly humbling about being in nature's presence, witnessing its raw beauty and power. The journey to the top tested my limits, but the reward? Absolutely breathtaking.\n\nEvery mountain top is within reach if you just keep climbing. What's your next adventure?\n\n#mountains #hiking #adventure",
    "originalDescription": "Epic mountain hiking adventure",
    "hashtags": "#mountains #hiking #adventure",
    "photoPath": "uploads\\a1b2c3d4-e5f6-7890-abcd-ef1234567890.jpg",
    "size": "LONG",
    "createdAt": "2025-11-15T18:25:12"
  },
  {
    "id": 1,
    "generatedDescription": "🌅 The golden hour transforms the sky into a breathtaking canvas of warm oranges, soft pinks, and deep purples as the sun sets over the tranquil ocean. The silhouettes of palm trees frame this stunning view perfectly.\n\nWhat's your favorite sunset spot? Drop it in the comments! 👇\n\n#sunset #beach #nature",
    "originalDescription": "Beautiful sunset at the beach with palm trees",
    "hashtags": "#sunset #beach #nature",
    "photoPath": "uploads\\f4e3d2c1-b5a6-4789-cdef-1234567890ab.jpg",
    "size": "MEDIUM",
    "createdAt": "2025-11-15T18:21:45"
  }
]
```

**Response (Empty):**
```json
[]
```

---

### 9. Get Post by ID

```http
GET /api/posts/1
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

**Response (Success):**
```json
{
  "id": 1,
  "generatedDescription": "🌅 The golden hour transforms the sky into a breathtaking canvas of warm oranges, soft pinks, and deep purples as the sun sets over the tranquil ocean. The silhouettes of palm trees frame this stunning view perfectly.\n\nWhat's your favorite sunset spot? Drop it in the comments! 👇\n\n#sunset #beach #nature",
  "originalDescription": "Beautiful sunset at the beach with palm trees",
  "hashtags": "#sunset #beach #nature",
  "photoPath": "uploads\\f4e3d2c1-b5a6-4789-cdef-1234567890ab.jpg",
  "size": "MEDIUM",
  "createdAt": "2025-11-15T18:21:45"
}
```

**Response (Error - Not Found):**
```json
{
  "timestamp": "2025-11-15T18:30:38.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Post not found or access denied",
  "path": "/api/posts/999"
}
```

---

### 10. Get Post Photo

```http
GET /api/posts/1/photo
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

**Response (Success):**
```
Content-Type: image/jpeg
Content-Disposition: inline; filename="f4e3d2c1-b5a6-4789-cdef-1234567890ab.jpg"

[binary image data]
```

**Response (Error - Not Found):**
```json
{
  "timestamp": "2025-11-15T18:30:38.000+00:00",
  "status": 404,
  "error": "Not Found"
}
```

---

### 11. Delete Post

```http
DELETE /api/posts/1
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

**Response (Success):**
```
204 No Content
```

**Response (Error - Not Found):**
```json
{
  "timestamp": "2025-11-15T18:30:38.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Post not found or access denied",
  "path": "/api/posts/1"
}
```

---

## ⚠️ Error Handling

### Common HTTP Status Codes

| Code | Status | Description |
|------|--------|-------------|
| **200** | OK | Request successful |
| **204** | No Content | Request successful, no content returned |
| **400** | Bad Request | Invalid request data |
| **401** | Unauthorized | Missing or invalid token |
| **403** | Forbidden | Access denied |
| **404** | Not Found | Resource not found |
| **500** | Internal Server Error | Server error |

---

## 📊 Post Size Reference

| Size | Description | Typical Length |
|------|-------------|----------------|
| **SHORT** | Brief caption | 1-2 sentences |
| **MEDIUM** | Standard post | 3-5 sentences |
| **LONG** | Detailed story | 6-10 sentences |

---

## 🛠️ Technical Details

- **Authentication:** JWT Bearer Token
- **Token Lifetime:** 24 hours
- **Image Formats:** JPEG, PNG, GIF, WebP
- **Max Image Size:** 10MB
- **AI Model:** GPT-4o Vision

---

Made with ❤️ by **yakupovdev**
