## Remotes

Use configurations from other Git repositories via `remotes` feature.

Hookflow will automatically download the remote config files and merge them into existing configuration.

```yml
remotes:
  - git_url: https://github.com/tekintian/hookflow
    configs:
      - examples/remote/ping.yml
```
