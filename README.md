![Build Status](https://github.com/tekintian/hookflow/actions/workflows/test.yml/badge.svg?branch=master)
[![codecov](https://codecov.io/gh/tekintian/hookflow/graph/badge.svg)](https://codecov.io/gh/tekintian/hookflow)

# Hookflow

Git hooks 管理器，适用于 Node.js、Ruby、Python 等各类项目。

## 特性

- **快速** - Go 编写，支持并行执行
- **强大** - 可精确控制执行逻辑和文件传递
- **简单** - 单一二进制文件，无依赖

**说明**: 由于 lefthook 不支持 macOS 10.15，本项目对 lefthook 进行了改造以支持 macOS 10.15，并保留了 lefthook v2.0 的所有功能和配置方式。

## 安装

### Go

```bash
go install github.com/tekintian/hookflow/v1@v1.0.0
```

### NPM

```bash
npm install hookflow --save-dev
```

### Ruby

```bash
gem install hookflow
```

### Python

```bash
pipx install hookflow
```

更多安装方式: [apt][install-apt], [brew][install-brew], [winget][install-winget] 等。

## 快速开始

```bash
# 配置 hooks
vim hookflow.yml

# 安装到 git 项目
hookflow install

# 正常使用 git
git add -A && git commit -m '...'
```

## 配置示例

### 并行执行

```yml
pre-push:
  parallel: true
```

### 文件过滤

```yml
pre-commit:
  jobs:
    - name: lint frontend
      run: yarn eslint {staged_files}

    - name: lint backend
      run: bundle exec rubocop --force-exclusion {all_files}

    - name: stylelint frontend
      files: git diff --name-only HEAD @{push}
      run: yarn stylelint {files}
```

### Glob 过滤

```yml
pre-commit:
  jobs:
    - name: lint backend
      glob: "*.rb"
      exclude:
        - "*/application.rb"
        - "*/routes.rb"
      run: bundle exec rubocop --force-exclusion {all_files}
```

### 子目录执行

```yml
pre-commit:
  jobs:
    - name: lint backend
      root: "api/"
      glob: "*.rb"
      run: bundle exec rubocop {all_files}
```

### 运行脚本

```yml
commit-msg:
  jobs:
    - script: "template_checker"
      runner: bash
```

### 标签控制

```yml
pre-push:
  jobs:
    - name: audit packages
      tags:
        - frontend
        - linters
      run: yarn lint

    - name: audit gems
      tags:
        - backend
        - security
      run: bundle audit
```

### Docker 支持

```yml
pre-commit:
  jobs:
    - script: "good_job.js"
      runner: docker run -it --rm <container_id_or_name> {cmd}
```

### 本地配置

```yml
# hookflow-local.yml
pre-push:
  exclude_tags:
    - frontend
  jobs:
    - name: audit packages
      skip: true
```

### 自定义任务

```yml
fixer:
  jobs:
    - run: bundle exec rubocop --force-exclusion --safe-auto-correct {staged_files}
    - run: yarn eslint --fix {staged_files}
```

运行: `hookflow run fixer`

### 输出控制

```yml
output:
  - execution
  - failure
```

## 更多文档

- [配置指南][configuration]
- [使用文档][usage]
- [讨论区][discussion]
- [示例][examples]

[installation]: https://lefthook.dev/guides/installation.html
[install-apt]: https://lefthook.dev/guides/installation.html#debian-based-linux
[install-brew]: https://lefthook.dev/guides/installation.html#homebrew
[install-winget]: https://lefthook.dev/guides/installation.html#winget
[configuration]: https://lefthook.dev/configuration.html
[usage]: https://lefthook.dev/usage.html
[discussion]: https://github.com/tekintian/hookflow/discussions
[examples]: https://github.com/tekintian/hookflow/tree/main/examples
[config-parallel]: https://lefthook.dev/configuration.html#parallel
[config-files]: https://lefthook.dev/configuration.html#files
[config-run]: https://lefthook.dev/configuration.html#run
[config-scripts]: https://lefthook.dev/configuration.html#scripts
[config-tags]: https://lefthook.dev/configuration.html#tags
[usage-local-config]: https://lefthook.dev/usage.html#local-config
[config-output]: https://lefthook.dev/configuration.html#output
[install-node]: https://lefthook.dev/guides/installation.html#nodejs
[install-ruby]: https://lefthook.dev/guides/installation.html#ruby
[install-rpm]: https://lefthook.dev/guides/installation.html#rpm-based-linux
[install-arch]: https://lefthook.dev/guides/installation.html#arch-linux
[install-alpine]: https://lefthook.dev/guides/installation.html#alpine-linux
