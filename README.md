# Olio Rails (API)

The backend application service for [olio](https://github.com/chasms/olio)

Minimal Rails 5 API-only backend for accounts, JWT auth, categorized addons (images/fonts), and user creations.

## Getting Started

Fast path (local development):

```bash
git clone <repo-url>
cd olio-rails
# Ensure correct Ruby (see Gemfile). Example with rbenv:
rbenv install $(grep -Eo '[0-9]\.[0-9]\.[0-9]+' Gemfile | head -1) || true
gem install bundler
cp config/secrets.yml.example config/secrets.yml 2>/dev/null || echo "Create config/secrets.yml (see snippet below)"
bin/setup          # bundle install + db:setup (creates, migrates, seeds)
bin/rails server   # starts Puma on http://localhost:3000
```

Then in another terminal create an account and log in:

```bash
curl -X POST http://localhost:3000/signup \
	-H "Content-Type: application/json" \
	-d '{"registration":{"username":"demo","email":"demo@example.com","password":"secret123","password_confirmation":"secret123"}}'

curl -X POST http://localhost:3000/login -d "username=demo&password=secret123"
```

Copy the returned token and call an authenticated endpoint:

```bash
curl -H "Authorization: Bearer <TOKEN>" http://localhost:3000/creations
```

Run tests:

```bash
bin/rails test
```

If `bin/setup` fails (e.g. PostgreSQL auth), ensure you have a local Postgres user with createdb rights or adjust `config/database.yml` accordingly.

For a manual setup (alternative to `bin/setup`):

```bash
bundle install
bin/rails db:create db:migrate db:seed
```

Troubleshooting quick tips:

- Missing secret: add `hmac_secret` & `secret_key_base` to `config/secrets.yml` (development).
- PG connection refused: start PostgreSQL (`brew services start postgresql@14` or similar).
- Token auth errors: confirm `Authorization: Bearer <token>` header and token not truncated.

> Want Docker? Not included yet—add a `Dockerfile` + `docker-compose.yml` mapping Postgres & app as a future enhancement.

## Stack

- Rails (~> 5.0.2) (API mode) – see `config/application.rb`
- PostgreSQL
- JWT auth via `Auth.issue` / `Auth.decode` (`lib/auth.rb`)
- ActiveModel Serializers (0.10.0)
- CORS enabled globally (Rack::Cors in `config/application.rb`)

## Data Model

- `Account` (`app/models/account.rb`) – `has_secure_password`, has many `Creation`
- `Creation` (`app/models/creation.rb`) – JSON composition + title, belongs to Account
- `Category` (`app/models/category.rb`) – has many `Addon`
- `Addon` (`app/models/addon.rb`) – image/font resource; font helper `Addon.fonts`

Serializers: `AccountSerializer`, `CreationSerializer`, `CategorySerializer`, `CategoryWithAddonsSerializer`, `AddonSerializer` (see `app/serializers/`).

## Authentication

JWT (HMAC) is used. Secret is pulled from `Rails.application.secrets.hmac_secret` (configure in `config/secrets.yml` or environment). `ApplicationController` provides `current_account` and `authenticate` before actions.

Authorization header format:

```
Authorization: Bearer <token>
```

Example secrets file (you must create it):

```yml
development:
	secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
	hmac_secret: "dev_hmac_secret"
test:
	secret_key_base: <%= ENV["TEST_SECRET_KEY_BASE"] %>
	hmac_secret: "test_hmac_secret"
production:
	secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
	hmac_secret: <%= ENV["HMAC_SECRET"] %>
```

Generate a secret: `bin/rails secret`.

## Routes / Endpoints

See `config/routes.rb` for source of truth.

Public (no auth):

- `POST /signup` (alias `POST /registrations`) – create account
- `POST /login` – obtain JWT
- `GET /categories` – list categories
- `GET /categories/:name` – list addons inside named category
- `GET /addons` – all categories with embedded addons (via `CategoryWithAddonsSerializer`)

Authenticated:

- `GET /me` (or `GET /accounts`) – current account
- CRUD `creations`:
  - `GET /creations`
  - `GET /creations/:id`
  - `POST /creations` (JSON body `{ title, addons }`)
  - `PATCH/PUT /creations/:id`
  - `DELETE /creations/:id`

Note: `AddonsController` exists but no direct `resources :addons` route (addons accessed through categories endpoint).

## Creation Payload Shape

POST /creations raw JSON example:

```json
{ "title": "My Art", "addons": [{ "name": "Example", "kind": "image" }] }
```

Controller currently parses raw body (`request.env['RAW_POST_DATA']`), which is deprecated; consider migrating to strong params.

## Setup

```bash
git clone <repo-url>
cd olio-rails
cp config/secrets.yml.example config/secrets.yml  # (create manually if example not present)
bin/setup  # installs gems, creates & seeds DB
bin/rails server
```

Prerequisites:

- Ruby (version defined in Gemfile; ensure compatible, e.g. 2.3.x for Rails 5.0.2 unless upgraded)
- PostgreSQL running locally
- Environment variables: `SECRET_KEY_BASE`, optionally `HMAC_SECRET` in production

## Database & Seeding

Schema is in `db/schema.rb`. Seed data populates categories, addons, and fonts (`db/seeds.rb`, `db/fonts.rb`).

Run:

```bash
bin/rails db:setup      # create + load schema + seed
bin/rails db:seed       # reseed
```

To reset:

```bash
bin/rails db:drop db:create db:migrate db:seed
```

## Testing

Uses Rails built-in test framework.

```bash
bin/rails test
```

Fixtures live in `test/fixtures/` (e.g. `addons.yml`).

## Example cURL Workflow

Signup:

```bash
curl -X POST http://localhost:3000/signup \
	-H "Content-Type: application/json" \
	-d '{"registration":{"username":"demo","email":"demo@example.com","password":"secret123","password_confirmation":"secret123"}}'
```

Login (form-encoded):

```bash
curl -X POST http://localhost:3000/login \
	-d "username=demo&password=secret123"
```

List creations (authenticated):

```bash
curl -H "Authorization: Bearer <TOKEN>" http://localhost:3000/creations
```

## CORS

Configured to allow all origins (see middleware block in `config/application.rb`). Adjust for production security (restrict origins, methods, and headers).

## Maintenance Scripts

```bash
bin/update   # bundle install, migrate, etc.
```

## Notes / Caveats

- Raw body parsing (`RAW_POST_DATA`) is deprecated; replace with `request.body.read` + JSON + strong params.
- `RegistrationsController#create` references a fixed `Creation.find(3)` which may not exist; remove or safeguard.
- No pagination, rate limiting, or comprehensive error handling yet.
- Add environment-specific secrets management (Rails credentials, dotenv, or ENV vars) for production readiness.
- Consider adding proper font/addon storage & CDN integration.

## Roadmap Ideas

- Pagination for categories & addons
- Improved validation & error serializer
- Swagger/OpenAPI documentation
- Token refresh & revocation strategy
- Replace manual JSON parse with strong params
- Add request specs & model validations tests

## License

Currently unspecified (add a LICENSE file).

---

This API is a foundation for authenticated creative resource management. Extend it with pagination, richer search, and improved security hardening as needed.
