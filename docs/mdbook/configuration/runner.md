## `runner`

You should specify a runner for the script. This is a command that should execute a script file. It will be called the following way: `<runner> <path-to-script>` (e.g. `ruby .hookflow/pre-commit/lint.rb`).

**Example**

```yml
# hookflow.yml

pre-commit:
  scripts:
    "lint.js":
      runner: node
    "check.go":
      runner: go run
```
