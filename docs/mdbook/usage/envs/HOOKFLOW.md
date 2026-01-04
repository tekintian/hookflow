## `HOOKFLOW`

Use `HOOKFLOW=0 git ...` or `HOOKFLOW=false git ...` to disable hookflow when running git commands.

**Example**

```bash
HOOKFLOW=0 git commit -am "Hookflow skipped"
```

When using NPM package `hookflow` in CI, and your CI sets `CI=true` automatically, use `HOOKFLOW=1` or `HOOKFLOW=true` to install hooks in the postinstall script:

**Example**

```bash
HOOKFLOW=1 npm install
HOOKFLOW=1 yarn install
HOOKFLOW=1 pnpm install
```

