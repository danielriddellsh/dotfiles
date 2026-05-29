---
name: bruno
description: Author and run Bruno API tests using the Bruno CLI (`bru`). Use this skill whenever the user wants to write, generate, scaffold, edit, or run `.bru` files / Bruno collections / API tests for a repo — including "add an API test for this endpoint", "create a Bruno collection", "run the bru tests and tell me what failed", "test these routes against staging", or any mention of Bruno, `bru run`, `.bru`, or API request collections. Covers two jobs: (1) writing valid `.bru` request/environment files with headers, auth, body, and assertion/test blocks, and (2) executing them via `bru run`, capturing the JSON report, and summarizing pass/fail. Trigger it even when the user names an endpoint or repo and asks to "test the API" without saying "Bruno", as long as the project uses (or should use) Bruno.
---

# Bruno API Testing

Two jobs: **write** `.bru` files for a repo's API, and **execute** them with the
Bruno CLI, then report what passed and what failed.

## Prerequisite: the CLI

Execution needs the Bruno CLI (`bru`). Check, install if missing:

```bash
bru --version || npm install -g @usebruno/cli
```

`bru` is the command. The npm package is `@usebruno/cli`. Writing `.bru` files
needs no CLI — they're plain text — but running them does.

## Collection layout

A Bruno collection is a folder with a `bruno.json` at its root. Requests are
`.bru` files (anywhere in the tree, foldered however you like). Environments
live in `environments/*.bru`. Minimal `bruno.json`:

```json
{ "version": "1", "name": "my-api", "type": "collection" }
```

When scaffolding into a repo, put the collection where the team expects tests
(e.g. `./bruno/` or `./api-tests/`). Create `bruno.json` first if absent —
`bru run` resolves the collection from it.

## Writing `.bru` files

A `.bru` request is block-structured. Order of blocks is flexible; `meta` and
the method block (`get`/`post`/`put`/`delete`/...) are the core. Use `{{var}}`
for variables resolved from the active environment or runtime `--env-var`.

```
meta {
  name: Get User
  type: http
  seq: 1
}

get {
  url: {{baseUrl}}/users/{{userId}}
  body: none
  auth: bearer
}

headers {
  Accept: application/json
}

auth:bearer {
  token: {{token}}
}

script:pre-request {
  bru.setVar("ts", Date.now());
}

tests {
  test("status is 200", function() {
    expect(res.getStatus()).to.equal(200);
  });
  test("returns the right user", function() {
    expect(res.getBody().id).to.equal(bru.getVar("userId"));
  });
}
```

Notes that matter:

- **Body variants** set the method block's `body:` and add a matching block:
  `body: json` + `body:json { ... }`; also `body:text`, `body:xml`,
  `body:form-urlencoded`, `body:multipart-form`, `body: none`.
- **Auth variants**: `auth: bearer|basic|none` with a matching `auth:bearer`,
  `auth:basic` block. Keep secrets in env vars, never hardcoded.
- **Assertions**: the `assert` block does simple expression checks
  (`res.status: eq 200`); the `tests` block runs JS for richer logic. Prefer
  `tests` for anything beyond a single value compare.
- **Response API** inside scripts/tests: `res.getStatus()`, `res.getBody()`,
  `res.getHeader(name)`; request vars via `bru.getVar` / `bru.setVar`.

Environment file `environments/local.bru`:

```
vars {
  baseUrl: http://localhost:8080
  userId: 42
}
```

Mark sensitive values as secret in the app only — secrets do NOT flow through
the CLI, so for `bru run` pass them with `--env-var TOKEN=...` instead.

### Scaffolding from a repo

When asked to test an existing service: read its routes (router definitions,
OpenAPI/Swagger spec, handler signatures) to derive method, path, required
headers, and body shape. One `.bru` per endpoint, foldered by resource. If an
OpenAPI spec exists, prefer importing it: `bru import openapi -s <spec> -o <dir>`
then refine the generated files. Always show the user the generated files (or a
diff) before running anything that hits a real server.

## Running and parsing results

Use the bundled helper — it runs `bru run` with a JSON reporter and prints a
compact pass/fail summary, so you don't re-parse the report by hand each time:

```bash
python scripts/run_bru.py --dir <collection-dir> [targets...] \
    [--env <name>] [--env-var KEY=VAL ...] [--bail] [--sandbox developer]
```

Examples:

```bash
# whole collection against the 'local' environment
python scripts/run_bru.py --dir ./bruno --env local

# one folder, override a secret token at runtime, stop on first failure
python scripts/run_bru.py --dir ./bruno users --env staging \
    --env-var token=$JWT --bail
```

The helper exits non-zero when any request/assertion fails (so it slots into CI
and you can trust the exit code). It writes the raw JSON report to
`<collection-dir>/.bruno-report.json` if you need full detail.

### Calling `bru` directly

If the helper can't cover a case, the raw command is:

```bash
cd <collection-dir> && bru run [targets] --env <name> \
    --env-var KEY=VAL --reporter-json report.json [--bail]
```

Key flags: `--env`/`--env-file` (environment), `--env-var` (override one var,
repeatable), `--reporter-json|--reporter-junit|--reporter-html` (reports),
`--bail` (stop on first failure), `--tests-only`, `--tags`/`--exclude-tags`,
`--iteration-count`, `--parallel`. Since CLI v3 the JS sandbox defaults to
`safe`; add `--sandbox=developer` only if scripts need npm packages or fs access
(and tell the user, since it loosens the sandbox).

## Reporting back to the user

After a run, lead with the verdict: total requests, passed/failed assertion
counts, then each failure as `request name — assertion — expected vs actual`.
Don't dump the whole JSON report unless asked. If the run failed because the
target server was unreachable (connection refused, DNS), say so plainly — that's
an environment problem, not a test failure.

## Safety

`bru run` makes real network calls and can mutate data (POST/PUT/DELETE).
Before running write-operations against anything that isn't clearly local, name
the environment you're about to hit and confirm. Never put real credentials in
`.bru` files committed to a repo — use environment vars or `--env-var`.
