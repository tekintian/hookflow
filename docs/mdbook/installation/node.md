## Node.js

```bash
npm install --save-dev hookflow
```

```bash
yarn add --dev hookflow
```

```bash
pnpm add -D hookflow
```

> **Note:** If you use `pnpm` package manager make sure to update `pnpm-workspace.yaml`s `onlyBuiltDependencies` with `hookflow` and add `hookflow` to `pnpm.onlyBuiltDependencies` in your root `package.json`, otherwise the `postinstall` script of the `hookflow` package won't be executed and hooks won't be installed.

**Note**: hookflow has three NPM packages with different ways to deliver the executables

 1. [hookflow](https://www.npmjs.com/package/hookflow) installs one executable for your system

    ```bash
    npm install --save-dev hookflow
    ```

 1. **legacy**[^1] [@tekintian/hookflow](https://www.npmjs.com/package/@tekintian/hookflow)  installs executables for all OS

    ```bash
    npm install --save-dev @tekintian/hookflow
    ```

 1. **legacy**[^1] [@tekintian/hookflow-installer](https://www.npmjs.com/package/@tekintian/hookflow-installer) fetches the right executable on installation

    ```bash
    npm install --save-dev @tekintian/hookflow-installer
    ```
[^1]: Legacy distributions are still maintained but they will be shut down in the future.
