## `script`

Name of a script to execute. The rules are the same as for [`scripts`](./Scripts.md)

### Example

```yml
# hookflow.yml

pre-commit:
  jobs:
    - script: linter.sh
      runner: bash
```

```bash
# .hookflow/pre-commit/linter.sh

echo "Everything is OK"
```
