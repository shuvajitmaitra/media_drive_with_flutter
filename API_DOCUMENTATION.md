# MediaDrive Backend API Documentation

## Overview

This backend is an Express + MongoDB API for managing folders, items, and email OTP verification.

- Default port: `3000`
- Default MongoDB URI: `mongodb://127.0.0.1:27017/mediadrive`
- Content type for request bodies: `application/json`

## Authentication / Owner Identification

All `/folders` and `/items` endpoints require an owner email header. The middleware accepts the first available value from these headers:

- `x-user-email`
- `x-owner-email`
- `email`
- `user`

Example:

```http
x-user-email: alice@example.com
```

If no header is provided, the API returns:

```json
{
  "error": "missing_owner",
  "message": "Provide owner email in one of: x-user-email, x-owner-email, email, user"
}
```

If the value is not a valid email, the API returns:

```json
{
  "error": "invalid_owner",
  "message": "Invalid email format"
}
```

## Readiness And Health

### `GET /healthz`

Returns process and database status.

Example response:

```json
{
  "status": "ok",
  "uptime": 123.45,
  "pid": 42,
  "db": "connected",
  "timestamp": "2026-04-12T10:00:00.000Z"
}
```

### `GET /readyz`

Returns whether MongoDB is connected.

- `200 OK` when the database is connected
- `503 Service Unavailable` when it is not connected

Example success response:

```json
{
  "status": "ready",
  "db": "connected"
}
```

Example failure response:

```json
{
  "status": "not-ready",
  "db": "disconnected"
}
```

## OTP API

Base path: `/otp`

### `POST /otp/send`

Sends a 6-digit OTP email.

Request body:

```json
{
  "email": "alice@example.com",
  "purpose": "signin"
}
```

Accepted `purpose` values in validation:

- `signin`
- `signup`
- `reset`

Important behavior:

- The current implementation validates `purpose` but does not use the submitted value.
- Sent emails are always stored and sent with purpose `"verification"`.
- OTPs expire in 5 minutes.

Success response:

```json
{
  "email": "alice@example.com",
  "message": "OTP sent to email.",
  "messageId": "<provider-message-id>",
  "from": "configured-mail-user@example.com"
}
```

### `POST /otp/verify`

Verifies a previously sent OTP.

Request body:

```json
{
  "email": "alice@example.com",
  "otp": "123456"
}
```

Success response:

```json
{
  "email": "alice@example.com",
  "message": "OTP verified successfully.",
  "purpose": "verification"
}
```

Failure responses:

- No OTP found or already expired:

```json
{
  "message": "No OTP found for this email or OTP expired."
}
```

- OTP expired:

```json
{
  "message": "OTP has expired."
}
```

- Invalid OTP:

```json
{
  "message": "Invalid OTP."
}
```

## Folder API

Base path: `/folders`

All folder routes require an owner email header and a healthy database connection.

### Folder Object

Example shape:

```json
{
  "_id": "6618f0d5b3d5c49a9f8b1234",
  "owner": "alice@example.com",
  "name": "Projects",
  "parent": null,
  "ancestors": [],
  "createdAt": "2026-04-12T10:00:00.000Z",
  "updatedAt": "2026-04-12T10:00:00.000Z",
  "__v": 0
}
```

Uniqueness rule:

- Folder names must be unique among sibling folders for the same owner.

### `POST /folders`

Creates a root folder or a subfolder.

Request body:

```json
{
  "name": "Projects",
  "parentId": null
}
```

`parentId` is optional. If omitted or `null`, the folder is created at the root.

Success response:

```json
{
  "_id": "6618f0d5b3d5c49a9f8b1234",
  "owner": "alice@example.com",
  "name": "Projects",
  "parent": null,
  "ancestors": [],
  "createdAt": "2026-04-12T10:00:00.000Z",
  "updatedAt": "2026-04-12T10:00:00.000Z",
  "__v": 0
}
```

Common errors:

- `404` if `parentId` does not belong to the current owner
- `409` if a sibling folder already has the same name

### `GET /folders`

Lists root folders for the current owner.

Success response:

```json
[
  {
    "_id": "6618f0d5b3d5c49a9f8b1234",
    "owner": "alice@example.com",
    "name": "Projects",
    "parent": null,
    "ancestors": [],
    "createdAt": "2026-04-12T10:00:00.000Z",
    "updatedAt": "2026-04-12T10:00:00.000Z",
    "__v": 0
  }
]
```

### `GET /folders/:id`

Returns one folder plus its direct child folders and direct items.

Success response:

```json
{
  "folder": {
    "_id": "6618f0d5b3d5c49a9f8b1234",
    "owner": "alice@example.com",
    "name": "Projects",
    "parent": null,
    "ancestors": [],
    "createdAt": "2026-04-12T10:00:00.000Z",
    "updatedAt": "2026-04-12T10:00:00.000Z",
    "__v": 0
  },
  "children": [],
  "items": []
}
```

Common errors:

- `404` if the folder is not found for the current owner

### `PATCH /folders/:id`

Renames a folder.

Request body:

```json
{
  "name": "Renamed Folder"
}
```

Success response: updated folder document.

Common errors:

- `404` if the folder is not found
- `409` if the new name already exists among siblings

### `PATCH /folders/:id/move`

Moves a folder to another parent and updates descendant ancestor chains.

Request body:

```json
{
  "newParentId": "6618f0d5b3d5c49a9f8b9999"
}
```

To move a folder to the root:

```json
{
  "newParentId": null
}
```

Success response:

```json
{
  "ok": true
}
```

Common errors:

- `404` if the folder is not found
- `404` if `newParentId` is not found for the current owner
- `400` for invalid cyclic moves

### `DELETE /folders/:id`

Deletes a folder and all direct items in that folder.

Important behavior:

- This is not recursive.
- The request fails if the folder still has child folders.
- Direct items in the folder are deleted automatically before the folder is deleted.

Success response:

```json
{
  "ok": true
}
```

Common errors:

- `400` if the folder still has subfolders

## Item API

Base path: `/items`

All item routes require an owner email header and a healthy database connection.

### Item Object

Example shape:

```json
{
  "_id": "6618f2c0b3d5c49a9f8b5678",
  "owner": "alice@example.com",
  "folder": "6618f0d5b3d5c49a9f8b1234",
  "name": "design.png",
  "url": "https://cdn.example.com/design.png",
  "mime": "image/png",
  "size": 24576,
  "kind": "image",
  "createdAt": "2026-04-12T10:10:00.000Z",
  "updatedAt": "2026-04-12T10:10:00.000Z",
  "__v": 0
}
```

Schema notes:

- `kind` defaults to `"file"`
- `rootFolder` exists in the schema but is not populated by the current route handlers
- Item names must be unique within the same folder for the same owner

### `POST /items`

Creates one item in a folder.

Request body:

```json
{
  "folderId": "6618f0d5b3d5c49a9f8b1234",
  "name": "design.png",
  "url": "https://cdn.example.com/design.png",
  "mime": "image/png",
  "size": 24576,
  "kind": "image"
}
```

Success response: created item document.

Common errors:

- `404` if the folder does not exist for the current owner
- `409` if an item with the same name already exists in that folder

### `POST /items/bulk`

Creates multiple items in one request.

Request body:

```json
{
  "items": [
    {
      "folderId": "6618f0d5b3d5c49a9f8b1234",
      "name": "design.png",
      "url": "https://cdn.example.com/design.png",
      "mime": "image/png",
      "size": 24576,
      "kind": "image"
    },
    {
      "folderId": "6618f0d5b3d5c49a9f8b1234",
      "name": "brief.pdf",
      "url": "https://cdn.example.com/brief.pdf",
      "mime": "application/pdf",
      "size": 102400,
      "kind": "file"
    }
  ]
}
```

Rules:

- Minimum 1 item
- Maximum 1000 items
- All referenced folders must belong to the current owner
- Insert uses unordered bulk write, so partial success is possible

Full success response:

```json
{
  "ok": true,
  "inserted": 2,
  "total": 2,
  "items": [
    {
      "_id": "6618f2c0b3d5c49a9f8b5678",
      "owner": "alice@example.com",
      "folder": "6618f0d5b3d5c49a9f8b1234",
      "name": "design.png",
      "url": "https://cdn.example.com/design.png",
      "mime": "image/png",
      "size": 24576,
      "kind": "image",
      "createdAt": "2026-04-12T10:10:00.000Z",
      "updatedAt": "2026-04-12T10:10:00.000Z",
      "__v": 0
    }
  ]
}
```

Partial success response:

```json
{
  "ok": false,
  "partial": true,
  "inserted": 1,
  "failed": 1,
  "errors": [
    {
      "index": 1,
      "code": 11000,
      "errmsg": "duplicate key error ..."
    }
  ]
}
```

Possible status codes:

- `200` for complete success
- `207` for partial success
- `404` if one or more folder IDs do not belong to the current owner

### `PATCH /items/:id`

Updates an item name and/or moves it to another folder.

Request body:

```json
{
  "name": "updated-name.png",
  "folderId": "6618f0d5b3d5c49a9f8b9999"
}
```

Both fields are optional, but at least one meaningful change should be supplied by the client.

Success response: updated item document.

Common errors:

- `400` if the item ID is invalid
- `404` if the item is not found
- `404` if the target folder is not found
- `409` if the new item name already exists in the destination folder

### `DELETE /items/:id`

Deletes one item.

Success response:

```json
{
  "ok": true
}
```

Common errors:

- `400` if the item ID is invalid
- `404` if the item is not found

### `DELETE /items/bulk`

Deletes multiple items.

Request body:

```json
{
  "ids": [
    "6618f2c0b3d5c49a9f8b5678",
    "6618f2c0b3d5c49a9f8b5679"
  ]
}
```

Rules:

- Minimum 1 ID
- Maximum 1000 IDs
- Items belonging to another owner are ignored, not treated as an error

Success response:

```json
{
  "ok": true,
  "attempted": 2,
  "deleted": 1
}
```

Implementation note:

- Because `DELETE /items/:id` is declared before `DELETE /items/bulk`, Express may match `/items/bulk` against the `/:id` route first, treating `"bulk"` as an item ID and returning `400`.
- If that happens in practice, move the `/bulk` delete route above `/:id` in the router.

## Shared Error Behavior

### Database unavailable

Protected `/folders` and `/items` routes return `503` when MongoDB is not connected:

```json
{
  "error": "db_unavailable",
  "message": "Database is not connected"
}
```

### Validation errors

Zod validation errors return `400`:

```json
{
  "error": "validation_error",
  "message": "Unexpected error",
  "details": []
}
```

The exact `details` array depends on the failing schema.

### Invalid Mongo ObjectId cast

Unhandled Mongoose cast errors return `400`:

```json
{
  "error": "invalid_id",
  "message": "Unexpected error"
}
```

### Duplicate key errors

Unhandled duplicate key errors return `409`:

```json
{
  "error": "duplicate_key",
  "message": "Unexpected error",
  "details": {}
}
```

Some route handlers also override this with more specific messages such as folder/item name conflicts.

### Route not found

Unknown routes return `404`:

```json
{
  "error": "route_not_found",
  "method": "GET",
  "path": "/unknown"
}
```

### Internal server error

Fallback server error response:

```json
{
  "error": "internal_error",
  "message": "Unexpected error"
}
```

## Environment Variables

The codebase expects these environment variables:

- `PORT`
- `MONGO_URI`
- `MAIL_USER`
- `MAIL_PASS`

## Notes For Integrators

- There is a `User` model in the codebase, but there are currently no public user CRUD or auth endpoints besides OTP send/verify.
- All ownership is based on the email header supplied by the client.
- Folder contents returned by `GET /folders/:id` include only direct children and direct items, not recursive descendants.
