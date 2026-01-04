## Git LFS support

> **Note:** If git-lfs binary is not installed and not required in your project, LFS hooks won't be executed, and you won't be warned about it.
>
> Git LFS hooks may be slow. Disable them with the global `skip_lfs: true` setting.

Hookflow runs LFS hooks internally for the following hooks:

- post-checkout
- post-commit
- post-merge
- pre-push

Errors are suppressed if git LFS is not required for the project. You can use [`HOOKFLOW_VERBOSE`](../envs/HOOKFLOW_VERBOSE.md) ENV to make hookflow show git LFS output.

To avoid calling LFS hooks set [`skip_lfs: true`](../../configuration/skip_lfs.md) in hookflow.yml or hookflow-local.yml
