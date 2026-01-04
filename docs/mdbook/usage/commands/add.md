## `hookflow add`

Installs the given hook to Git hook.

With argument `--dirs` creates a directory `.git/hooks/<hook name>/` if it doesn't exist. Use it before adding a script to configuration.

**Example**

```bash
$ hookflow add pre-push  --dirs
```

Describe pre-push commands in `hookflow.yml`:

```yml
pre-push:
  jobs:
    - script: "audit.sh"
      runner: bash
```

Edit the script:

```bash
$ vim .hookflow/pre-push/audit.sh
...
```

Run `git push` and hookflow will run `bash audit.sh` as a pre-push hook.
