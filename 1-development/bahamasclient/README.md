# Bahamas Client

This is a Ruby on Rails API that handles invoicing logic for clients in the Bahamas, where invoices can have an additional client eligible for tax deductions.
The API provides endpoints to store and retrieve clients associated with invoices.

## Stack:

- Ruby 3.0.3
- Rails ~> 7.1.3
- Sqlite3 ~> 1.4

## How to run the project:

The first step is install the dependencies by running:

```bash
bundle install
```

To make sure the database is configured:

```bash
rails db:create
rails db:migrate
```

Then run:

```bash
bin/rails server
```

And the project will start at http://127.0.0.1:3000

## API Routes

### Store Bahamas Client

Endpoint: /store-bahamas-client/:invoice_id

Method: POST

Query Parameters:
fiscal_id: (string) The fiscal ID of the client.
name: (string) The name of the client.
email: (string) The email of the client.

Response:
200 Ok: When the client already exists in the database and has been assigned to the invoice.

201 Created: When the client is successfully stored.

422 Unprocessable Entity: When there are validation errors.

#### Example:

Request: POST /store-bahamas-client/1234?fiscal_id=999999999&name=Bob&email=bob@bob.com

Response:

```json
{
  "id": "1",
  "fiscal_id": "999999999",
  "name": "Bob",
  "email": "bob@bob.com",
  "created_at": "2024-08-11T12:34:56.789Z",
  "updated_at": "2024-08-11T12:34:56.789Z",
  "invoices": []
}
```

### Retrieve Bahamas Client

Endpoint: /retrieve-bahamas-client/:invoice_id

Method: GET

Response:

200 OK: When the client is found.
404 Not Found: When the client is not found.

#### Example:

Request: GET /retrieve-bahamas-client/1234

Response:

```json
{
  "id": "1",
  "fiscal_id": "999999999",
  "name": "Bob",
  "email": "bob@bob.com",
  "created_at": "2024-08-11T12:34:56.789Z",
  "updated_at": "2024-08-11T12:34:56.789Z",
  "invoices": [
    {
      "id": "1234",
      "created_at": "2024-08-10T12:34:56.789Z",
      "updated_at": "2024-08-10T12:34:56.789Z"
    }
  ]
}
```

### Clients CRUD

Endpoints:

- GET /clients: List all clients.
- GET /clients/:id: Show a specific client.
- POST /clients: Create a new client.

  POST Request Parameters:

  fiscal_id: (string) The fiscal ID of the client.

  name: (string) The name of the client.

  email: (string) The email of the client.

- PATCH/PUT /clients/:id: Update a client.
- DELETE /clients/:id: Delete a client.

### Invoices CRUD

Endpoints:

- GET /invoices: List all invoices.
- GET /invoices/:id: Show a specific invoice.
- POST /invoices: Create a new invoice.

  POST Request Parameters:

  id: (integer) The unique identifier of the invoice.

- PATCH/PUT /invoices/:id: Update an invoice.
- DELETE /invoices/:id: Delete an invoice.

## Model Schema

### Client

id: integer - Primary key

fiscal_id: string - Unique fiscal ID of the client

name: string - Name of the client

email: string - Email address of the client

created_at: datetime - Timestamp when the record was created

updated_at: datetime - Timestamp when the record was last updated

### Invoice

id: integer - Primary key

created_at: datetime - Timestamp when the record was created

updated_at: datetime - Timestamp when the record was last updated

### InvoiceClient (Join Table)

id: integer - Primary key

client_id: integer - Foreign key referencing a client

invoice_id: integer - Foreign key referencing an invoice
