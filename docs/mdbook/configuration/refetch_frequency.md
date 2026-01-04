## `refetch_frequency`

**Default:** Not set

Specifies how frequently Hookflow should refetch the remote configuration. This can be set to `always`, `never` or a time duration like `24h`, `30m`, etc.

- When set to `always`, Hookflow will always refetch the remote configuration on each run.
- When set to a duration (e.g., `24h`), Hookflow will check the last fetch time and refetch the configuration only if the specified amount of time has passed.
- When set to `never` or not set, Hookflow will not fetch from remote.

**Example**

```yml
# hookflow.yml

remotes:
  - git_url: https://github.com/tekintian/hookflow
    refetch_frequency: 24h # Refetches once every 24 hours
```

> WARNING
> If `refetch` is set to `true`, it overrides any setting in `refetch_frequency`.

