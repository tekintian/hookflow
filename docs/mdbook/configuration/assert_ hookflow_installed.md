## `assert_hookflow_installed`

**Default: `false`**

When set to `true`, fail (with exit status 1) if `hookflow` executable can't be found in $PATH, under node_modules/, as a Ruby gem, or other supported method. This makes sure git hook won't omit `hookflow` rules if `hookflow` ever was installed.
