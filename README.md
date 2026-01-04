![Build Status](https://github.com/tekintian/hookflow/actions/workflows/test.yml/badge.svg?branch=master)
[![codecov](https://codecov.io/gh/tekintian/hookflow/graph/badge.svg?token=d93ya8MfmB)](https://codecov.io/gh/tekintian/hookflow)

# Hookflow

<img align="right" width="147" height="100" title="Hookflow logo"
     src="./logo_sign.svg">

A Git hooks manager for Node.js, Ruby, Python and many other types of projects.

* **Fast.** It is written in Go. Can run commands in parallel.
* **Powerful.** It allows to control execution and files you pass to your commands.
* **Simple.** It is single dependency-free binary which can work in any environment.

📖 [Introduction post](https://tekintian.com/chronicles/hookflow-knock-your-teams-code-back-into-shape?utm_source=hookflow)

<a href="https://tekintian.com/?utm_source=hookflow">
<img src="https://tekintian.com/badges/sponsored-by-tekintian.svg" alt="Sponsored by Tekintian" width="100%" height="54"></a>

## Install

With **Go** (<= 1.24):

```bash
go install github.com/tekintian/hookflow/v1@v1.0.0
```

* or as a go tool

```bash
go get -tool github.com/tekintian/hookflow
```

With **NPM**:

```bash
npm install hookflow --save-dev
```

For **Ruby**:

```bash
gem install hookflow
```

For **Python**:

```bash
pipx install hookflow
```

**[Installation guide][installation]** with more ways to install hookflow: [apt][install-apt], [brew][install-brew], [winget][install-winget], and others.

## Usage

Configure your hooks, install them once and forget about it: rely on the magic underneath.

#### TL;DR

```bash
# Configure your hooks
vim hookflow.yml

# Install them to the git project
hookflow install

# Enjoy your work with git
git add -A && git commit -m '...'
```

#### More details

- [**Configuration**][configuration] for `hookflow.yml` config options.
- [**Usage**][usage] for **hookflow** CLI options, and features.
- [**Discussions**][discussion] for questions, ideas, suggestions.
<!-- - [**Wiki**](https://github.com/tekintian/hookflow/wiki) for guides, examples, and benchmarks. -->

## Why Hookflow

* ### **Parallel execution**
Gives you more speed. [docs][config-parallel]

```yml
pre-push:
  parallel: true
```

* ### **Flexible list of files**
If you want your own list. [Custom][config-files] and [prebuilt][config-run] examples.

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

* ### **Glob and regexp filters**
If you want to filter list of files. You could find more glob pattern examples [here](https://github.com/gobwas/glob#example).

```yml
pre-commit:
  jobs:
    - name: lint backend
      glob: "*.rb" # glob filter
      exclude:
        - "*/application.rb"
        - "*/routes.rb"
      run: bundle exec rubocop --force-exclusion {all_files}
```

* ### **Execute in sub-directory**
If you want to execute the commands in a relative path

```yml
pre-commit:
  jobs:
    - name: lint backend
      root: "api/" # Careful to have only trailing slash
      glob: "*.rb" # glob filter
      run: bundle exec rubocop {all_files}
```

* ### **Run scripts**

If oneline commands are not enough, you can execute files. [docs][config-scripts]

```yml
commit-msg:
  jobs:
    - script: "template_checker"
      runner: bash
```

* ### **Tags**
If you want to control a group of commands. [docs][config-tags]

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

* ### **Support Docker**

If you are in the Docker environment. [docs][config-run]

```yml
pre-commit:
  jobs:
    - script: "good_job.js"
      runner: docker run -it --rm <container_id_or_name> {cmd}
```

* ### **Local config**

If you are a frontend/backend developer and want to skip unnecessary commands or override something in Docker. [docs][usage-local-config]

```yml
# hookflow-local.yml
pre-push:
  exclude_tags:
    - frontend
  jobs:
    - name: audit packages
      skip: true
```

* ### **Direct control**

If you want to run hooks group directly.

```bash
$ hookflow run pre-commit
```

* ### **Your own tasks**

If you want to run specific group of commands directly.

```yml
fixer:
  jobs:
    - run: bundle exec rubocop --force-exclusion --safe-auto-correct {staged_files}
    - run: yarn eslint --fix {staged_files}
```
```bash
$ hookflow run fixer
```

* ### **Control output**

You can control what hookflow prints with [output][config-output] option.

```yml
output:
  - execution
  - failure
```

----

### Guides

* [Install with Node.js][install-node]
* [Install with Ruby][install-ruby]
* [Install with Homebrew][install-brew]
* [Install with Winget][install-winget]
* [Install for Debian-based Linux][install-apt]
* [Install for RPM-based Linux][install-rpm]
* [Install for Arch Linux][install-arch]
* [Install for Alpine Linux][install-alpine]
* [Usage][usage]
* [Configuration][configuration]
<!-- * [Troubleshooting](https://github.com/tekintian/hookflow/wiki/Troubleshooting) -->

<!-- ### Migrate from -->
<!-- * [Husky](https://github.com/tekintian/hookflow/wiki/Migration-from-husky) -->
<!-- * [Husky and lint-staged](https://github.com/tekintian/hookflow/wiki/Migration-from-husky-with-lint-staged) -->
<!-- * [Overcommit](https://github.com/tekintian/hookflow/wiki/Migration-from-overcommit) -->

### Examples

Check [examples][examples]

[documentation]: https://hookflow.dev/