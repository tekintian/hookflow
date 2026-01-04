## `templates`

> Added in hookflow `1.10.8`

Provide custom replacement for templates in `run` values.

With `templates` you can specify what can be overridden via `hookflow-local.yml` without a need to overwrite every jobs in your configuration.

## Example

### Override with hookflow-local.yml

```yml
# hookflow.yml

templates:
  dip: # empty

pre-commit:
  jobs:
    # Will run: `bundle exec rubocop file1 file2 file3 ...`
    - run: {dip} bundle exec rubocop {staged_files}
```

```yml
# hookflow-local.yml

templates:
  dip: dip # Will run: `dip bundle exec rubocop file1 file2 file3 ...`
```

### Reduce redundancy

```yml
# hookflow.yml

templates:
  wrapper: docker-compose run --rm -v $(pwd):/app service

pre-commit:
  jobs:
    - run: {wrapper} yarn format
    - run: {wrapper} yarn lint
    - run: {wrapper} yarn test
```
