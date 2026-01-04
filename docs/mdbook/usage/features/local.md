## Local config

You can extend and override options of your main configuration with `hookflow-local.yml`. Don't forget to add the file to `.gitignore`.

You can also use `hookflow-local.yml` without a main config file. This is useful when you want to use hookflow locally without imposing it on your teammates.

```yml
# hookflow.yml (committed into your repo)

pre-commit:
  jobs:
    - name: linter
      run: yarn lint
    - name: tests
      run: yarn test
```

```yml
# hookflow-local.yml (ignored by git)

pre-commit:
  jobs:
    - name: tests
      skip: true # don't want to run tests on every commit
    - name: linter
      run: yarn lint {staged_files} # lint only staged files
```
