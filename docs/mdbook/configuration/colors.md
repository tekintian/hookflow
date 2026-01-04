## `colors`

**Default: `auto`**

Whether enable or disable colorful output of Hookflow. This option can be overwritten with `--colors` option. You can also provide your own color codes.

**Example**

Disable colors.

```yml
# hookflow.yml

colors: false
```

Custom color codes. Can be hex or ANSI codes.

```yml
# hookflow.yml

colors:
  cyan: 14
  gray: 244
  green: '#32CD32'
  red: '#FF1493'
  yellow: '#F0E68C'
```

