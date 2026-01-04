## `fail_text`

You can specify a text to show when the command or script fails.

**Example**

```yml
# hookflow.yml

pre-commit:
  commands:
    lint:
      run: yarn lint
      fail_text: Add node executable to $PATH
```

```bash
$ git commit -m 'fix: Some bug'

Hookflow v1.1.3
RUNNING HOOK: pre-commit

  EXECUTE > lint

SUMMARY: (done in 0.01 seconds)
🥊  lint: Add node executable to $PATH env
```
