# Introduction

<img align="right" width="147" height="125" title="Hookflow logo"
     src="./favicon.svg">

**Hookflow** is a Git hooks manager. Here is how to

- **[Install](./installation)** hookflow to your project or globally.

- **[Configure](./configuration)** `hookflow.yml` with detailed options explanation.

**Example:** Run your linters on `pre-commit` hook and forget about the routine.

```yml
# hookflow.yml

pre-commit:
  parallel: true
  jobs:
    - run: yarn run stylelint --fix {staged_files}
      glob: "*.css"
      stage_fixed: true

    - run: yarn run eslint --fix "{staged_files}"
      glob:
        - "*.ts"
        - "*.js"
        - "*.tsx"
        - "*.jsx"
      stage_fixed: true
```

---

<a href="https://tekintian.com/?utm_source=hookflow">
<img src="https://tekintian.com/badges/sponsored-by-tekintian.svg" alt="Sponsored by Tekintian" width="100%" height="54"></a>
