## `CI`

When using NPM package `hookflow`, set `CI=true` in your CI (if it does not set it automatically) to prevent hookflow from installing hooks in the postinstall script:

```bash
CI=true npm install
CI=true yarn install
CI=true pnpm install
```

> **Note:** Set `HOOKFLOW=1` or `HOOKFLOW=true` to override this behavior and install hooks in the postinstall script (despite `CI=true`).

