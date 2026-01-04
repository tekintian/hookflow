## `extends`

You can extend your config with another one YAML file. Its content will be merged. Extends for `hookflow.yml`, `hookflow-local.yml`, and [`remotes`](./remotes.md) configs are handled separately, so you can have different extends in these files.

You can use asterisk to make a glob.

**Example**

```yml
# hookflow.yml

extends:
  - /home/user/work/hookflow-extend.yml
  - /home/user/work/hookflow-extend-2.yml
  - hookflow-extends/file.yml
  - ../extend.yml
  - projects/*/specific-hookflow-config.yml
```

> The extends will be merged to the main configuration in your file. Here is the order of settings applied:
>
> - `hookflow.yml` – main config file
> - `extends` – configs specified in [extends](./extends.md) option
> - `remotes` – configs specified in [remotes](./remotes.md) option
> - `hookflow-local.yml` – local config file
>
> So, `extends` override settings from `hookflow.yml`, `remotes` override `extends`, and `hookflow-local.yml` can override everything.


