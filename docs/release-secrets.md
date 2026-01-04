# GitHub Actions Release Secrets

本文档说明了 Hookflow 项目在 GitHub Actions release workflow 中所需的各类密钥（Secrets）和 Token 的获取方法。

## 概述

Hookflow 的发布流程（`.github/workflows/release.yml`）会将二进制文件发布到多个平台和包管理器。每个平台都需要相应的认证凭据。

## 必需的 Secrets

以下是所有需要配置在 GitHub Repository Settings → Secrets and variables → Actions 中的 secrets：

| Secret 名称 | 描述 | 用途 | 必需 |
|-------------|--------|--------|------|
| `GITHUB_TOKEN` | GitHub 自动提供的 Token | 发布到 GitHub Releases、创建 artifacts | ✅ 自动提供 |
| `NPM_API_KEY` | NPM 发布 Token | 发布到 npm registry | ⚠️ 可选 |
| `RUBYGEMS_API_KEY` | RubyGems API Key | 发布到 RubyGems | ⚠️ 可选 |
| `PYPI_API_KEY` | PyPI API Token | 发布到 PyPI | ⚠️ 可选 |
| `HOMEBREW_TOKEN` | GitHub Personal Access Token | 更新 Homebrew formula | ⚠️ 可选 |
| `WINGET_TOKEN` | GitHub Personal Access Token | 发布到 Winget | ⚠️ 可选 |
| `CLOUDSMITH_API_KEY` | Cloudsmith API Key | 推送到 Linux 仓库 | ⚠️ 可选 |
| `SNAPCRAFT_STORE_CREDENTIALS` | Snapcraft 登录凭据 | 发布到 Snap Store | ⚠️ 可选 |
| `AUR_SSH_KEY` | AUR SSH 私钥 | 更新 Arch User Repository | ⚠️ 可选 |

> **注意**: `GITHUB_TOKEN` 由 GitHub Actions 自动提供，无需手动配置。

---

## 详细获取方法

### 1. GITHUB_TOKEN

**自动提供，无需配置**

GitHub Actions 在每次运行时自动提供此 token，权限在 workflow 文件中定义：

```yaml
permissions:
  attestations: write
  contents: write
  id-token: write
```

该 token 用于：
- 创建 GitHub Release
- 上传 release assets
- 生成 artifact attestations

---

### 2. NPM_API_KEY

**用途**: 发布 `hookflow-darwin-x64` 和 `hookflow-darwin-arm64` 到 npm registry

#### 获取步骤：

1. 登录 [npmjs.com](https://www.npmjs.com/)
2. 点击右上角头像 → **Access Tokens**
3. 点击 **Generate New Token**
4. 选择 **Granular Access Token**（推荐）或 **Automation Token**
5. 配置权限：
   - **Packages and scopes**: Select packages → All packages
   - **Publish**: ✅ Enable
6. 生成 token 并复制（⚠️ 只显示一次）
7. 复制到剪贴板

#### 添加到 GitHub：

1. 打开你的仓库
2. 进入 **Settings** → **Secrets and variables** → **Actions**
3. 点击 **New repository secret**
4. Name: `NPM_API_KEY`
5. Secret: 粘贴刚才复制的 token
6. 点击 **Add secret**

#### 验证：

```bash
npm whoami --registry=https://registry.npmjs.org
```

---

### 3. RUBYGEMS_API_KEY

**用途**: 发布 `hookflow` gem 到 RubyGems

#### 获取步骤：

1. 登录 [rubygems.org](https://rubygems.org/)
2. 点击右上角头像 → **Edit profile**
3. 滚动到底部 → **API Access**
4. 点击 **Add new API key**
5. 填写信息：
   - **Description**: `GitHub Actions - hookflow`
   - **MFA**: 如果启用了两步验证，需要验证
6. 点击 **Create**
7. 复制 API key（⚠️ 只显示一次）

#### 添加到 GitHub：

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. Name: `RUBYGEMS_API_KEY`
4. Secret: 粘贴刚才复制的 API key
5. 点击 **Add secret**

#### 验证：

```bash
gem push --key YOUR_API_KEY hookflow-*.gem
```

---

### 4. PYPI_API_KEY

**用途**: 发布 `hookflow` Python 包到 PyPI (Python Package Index)

#### 前置要求：

1. [注册 PyPI 账号](https://pypi.org/account/register/)
2. 启用 [2FA (Two-Factor Authentication)](https://pypi.org/help/#tfa)（**必需**）

#### 获取 API Token：

1. 登录 [pypi.org](https://pypi.org/)
2. 进入 **Account settings**
3. 找到 **API tokens** 部分
4. 点击 **Add API token**
5. 填写信息：
   - **Description**: `GitHub Actions - hookflow`
   - **Scope**: 选择 **Entire account**（推荐）或特定项目
   - **API Token Scope**: **Project**: New/Upload
6. 点击 **Add API token**
7. 复制 token（⚠️ 只显示一次）

#### 添加到 GitHub：

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. Name: `PYPI_API_KEY`
4. Secret: 粘贴刚才复制的 token
5. 点击 **Add secret**

#### 验证：

```bash
python -m twine check dist/*
python -m twine upload --repository-url https://upload.pypi.org/legacy/ dist/*
```

---

### 5. HOMEBREW_TOKEN

**用途**: 提交 PR 更新 [homebrew-core](https://github.com/Homebrew/homebrew-core) 仓库中的 `hookflow` formula

#### 获取步骤：

1. 登录 [GitHub.com](https://github.com/)
2. 进入 **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
3. 点击 **Generate new token (classic)**
4. 配置权限：
   - **Note**: `Homebrew Bump Formula - hookflow`
   - **Expiration**: 选择合适的过期时间（建议 No expiration）
   - **Scopes**:
     - ✅ `repo` (Full control of private repositories)
     - ✅ `workflow` (Update GitHub Action workflows)
5. 点击 **Generate token**
6. 复制 token（⚠️ 只显示一次）

> **提示**: 新版 Fine-grained tokens 也可用，但需要配置：
> - Resource owner: Homebrew
> - Permissions: Contents → Read and write, Pull requests → Read and write

#### 添加到 GitHub：

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. Name: `HOMEBREW_TOKEN`
4. Secret: 粘贴刚才复制的 token
5. 点击 **Add secret**

#### 工作原理：

- workflow 使用 `dawidd6/action-homebrew-bump-formula@v3` action
- 自动创建 PR 到 `Homebrew/homebrew-core`
- 更新 formula 的 SHA256 checksum 和版本号

---

### 6. WINGET_TOKEN

**用途**: 创建 PR 更新 [Winget](https://github.com/microsoft/winget-pkgs) 仓库中的 hookflow 包

#### 获取步骤：

1. 登录 [GitHub.com](https://github.com/)
2. 进入 **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
3. 点击 **Generate new token (classic)**
4. 配置权限：
   - **Note**: `Winget Releaser - hookflow`
   - **Expiration**: 选择合适的过期时间（建议 No expiration）
   - **Scopes**:
     - ✅ `repo` (Full control of private repositories)
     - ✅ `workflow` (Update GitHub Action workflows)
5. 点击 **Generate token**
6. 复制 token（⚠️ 只显示一次）

#### 添加到 GitHub：

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. Name: `WINGET_TOKEN`
4. Secret: 粘贴刚才复制的 token
5. 点击 **Add secret**

#### 配置说明：

在 `.github/workflows/release.yml` 中，还需配置 fork 用户：

```yaml
- name: Publish to Winget
  uses: vedantmgoyal2009/winget-releaser@v2
  with:
    identifier: tekintian.hookflow
    fork-user: mrexox  # 改为你的 GitHub 用户名
    token: ${{ secrets.WINGET_TOKEN }}
```

#### 工作原理：

- winget-releaser 会自动 fork `microsoft/winget-pkgs`
- 在你的 fork 中创建 PR 更新包版本
- PR 创建后由 Winget maintainers 合并

---

### 7. CLOUDSMITH_API_KEY

**用途**: 推送 DEB、RPM、APK 包到 [Cloudsmith](https://cloudsmith.io/~tekintian/repos/hookflow/) 仓库

#### 前置要求：

1. [注册 Cloudsmith 账号](https://cloudsmith.io/user/sign-up/)
2. 确认你有 `tekintian/hookflow` 仓库的管理权限

#### 获取 API Key：

1. 登录 [cloudsmith.io](https://cloudsmith.io/)
2. 进入 **User Settings** → **API Keys**
3. 点击 **Create New API Key**
4. 填写信息：
   - **Name**: `GitHub Actions - hookflow release`
   - **Key Type**: API Key
   - **Permissions**:
     - ✅ **Repositories**: Write (Push packages)
     - ✅ **Organisations**: Write (如有需要)
5. 点击 **Create Key**
6. 复制 API key（⚠️ 只显示一次）

#### 添加到 GitHub：

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. Name: `CLOUDSMITH_API_KEY`
4. Secret: 粘贴刚才复制的 API key
5. 点击 **Add secret**

#### 发布的包类型：

workflow 会推送以下包到 Cloudsmith：

| 架构 | 包类型 | 目标 |
|--------|---------|------|
| amd64 | DEB | tekintian/hookflow/any-distro/any-version |
| arm64 | DEB | tekintian/hookflow/any-distro/any-version |
| amd64 | RPM | tekintian/hookflow/any-distro/any-version |
| arm64 | RPM | tekintian/hookflow/any-distro/any-version |
| amd64 | APK | tekintian/hookflow/alpine/any-version |
| arm64 | APK | tekintian/hookflow/alpine/any-version |

---

### 8. SNAPCRAFT_STORE_CREDENTIALS

**用途**: 发布 snap 包到 [Snap Store](https://snapcraft.io/hookflow)

#### 前置要求：

1. [注册 Snapcraft 账号](https://snapcraft.io/auth/)
2. 在 Snap Store 中注册 snap 名称 `hookflow`

#### 获取登录凭据：

**方法 1: 通过 Snapcraft Store UI**

1. 登录 [snapcraft.io](https://snapcraft.io/)
2. 进入 **My account** → **Snap names**
3. 确认 `hookflow` 已注册
4. 运行以下命令进行首次登录：

```bash
snapcraft login
```

这会在本地生成登录凭据。

**方法 2: 通过 Ubuntu One (推荐用于 CI)**

1. 登录 [Ubuntu One](https://login.ubuntu.com/)
2. 进入 **Snap names** → **Your snap names**
3. 确认 `hookflow` 已注册

#### 配置 Snapcraft Macro Token (推荐用于 CI)：

对于非交互式 CI 环境，建议使用 Macro Token：

1. 登录 [snapcraft.io](https://snapcraft.io/)
2. 进入 **Account settings** → **Snapcraft developer accounts**
3. 点击 **Add new Snapcraft developer account**
4. 选择 **Create a new Macro token**
5. 填写信息：
   - **Description**: `GitHub Actions - hookflow`
   - **Permissions**:
     - ✅ **Package management**: Manage and release snaps
6. 点击 **Create**
7. 复制 token（⚠️ 只显示一次）

#### 添加到 GitHub：

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. Name: `SNAPCRAFT_STORE_CREDENTIALS`
4. Secret: 粘贴刚才复制的 token
5. 点击 **Add secret**

> **注意**: snapcraft 的登录格式可以是：
> - Export 格式: `SNAPCRAFT_STORE_CREDENTIALS={ "macaroon": "...", "unbound_discharge": "..." }`
> - 或直接使用 Macro Token

---

### 9. AUR_SSH_KEY

**用途**: 提交 PR 更新 [Arch User Repository (AUR)](https://aur.archlinux.org/packages/hookflow) 和 [hookflow-bin](https://aur.archlinux.org/packages/hookflow-bin)

#### 前置要求：

1. 在 [AUR 注册账号](https://aur.archlinux.org/register/)
2. 上传 SSH public key 到 AUR（见下方）

#### 获取 SSH 密钥对：

**步骤 1: 生成 SSH 密钥对**

```bash
ssh-keygen -t ed25519 -f ~/.ssh/aur -C "aur@yourdomain.com"
```

这将生成：
- 私钥: `~/.ssh/aur`
- 公钥: `~/.ssh/aur.pub`

**步骤 2: 上传公钥到 AUR**

1. 复制公钥内容：

```bash
cat ~/.ssh/aur.pub
```

2. 登录 [AUR](https://aur.archlinux.org/)
3. 进入 **My Account** → **My Account**
4. 找到 **SSH Public Keys** 部分
5. 点击 **Add**
6. 粘贴公钥内容并保存

**步骤 3: 获取私钥内容**

```bash
cat ~/.ssh/aur
```

或使用 base64 编码（推荐）：

```bash
base64 -i ~/.ssh/aur
```

#### 添加到 GitHub：

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. Name: `AUR_SSH_KEY`
4. Secret: 粘贴私钥内容（直接粘贴或 base64 编码的内容）
5. 点击 **Add secret**

> **⚠️ 重要安全提示**:
> - 只上传私钥，不要上传公钥
> - 私钥应该以 `-----BEGIN OPENSSH PRIVATE KEY-----` 开头
> - 如果使用 base64 编码，workflow 中需要解码（但当前 workflow 直接使用，建议使用原始格式）

#### 工作原理：

workflow 会在 Arch Linux 容器中执行：

```bash
# 安装私钥
echo "${AUR_SSH_KEY}" > ~/.ssh/aur
chmod 600 ~/.ssh/aur

# 配置 SSH
echo "Host aur.archlinux.org" >> ~/.ssh/config
echo "  IdentityFile ~/.ssh/aur" >> ~/.ssh/config
echo "  User aur" >> ~/.ssh/config

# 推送更新
ruby packaging/pack.rb publish_aur_hookflow
```

---

## 发布平台关系图

```
┌─────────────────────────────────────────────────────────────────────┐
│                     GitHub Release Tag                          │
└────────────────────┬──────────────────────────────────────────────┘
                     │
                     ▼
            ┌────────────────┐
            │   GitHub     │
            │  Release     │
            └────────────────┘
                     │
        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
   ┌────────┐  ┌──────────┐ ┌──────────┐
   │   NPM  │  │ RubyGems │ │   PyPI   │
   │  Token  │  │  API Key │ │  API Key │
   └────────┘  └──────────┘ └──────────┘
        │            │            │
        ▼            ▼            ▼
   ┌────────┐  ┌──────────┐ ┌──────────┐
   │ npmjs  │  │ rubygems │ │  pypi.org │
   └────────┘  └──────────┘ └──────────┘

        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
   ┌────────┐  ┌──────────┐ ┌──────────┐
   │Homebrew│  │  Winget  │ │Cloudsmith│
   │  Token │  │  Token   │ │ API Key  │
   └────────┘  └──────────┘ └──────────┘
        │            │            │
        ▼            ▼            ▼
   ┌────────┐  ┌──────────┐ ┌──────────┐
   │ homebrew│  │  Winget  │ │Cloudsmith│
   │/core   │  │  PKGS    │ │  repos   │
   └────────┘  └──────────┘ └──────────┘

        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
   ┌────────┐  ┌──────────┐ ┌──────────┐
   │Snapcraft│  │   AUR    │
   │  Creds │  │ SSH Key  │
   └────────┘  └──────────┘
        │            │
        ▼            ▼
   ┌────────┐  ┌──────────┐
   │SnapStore│  │  AUR     │
   └────────┘  └──────────┘
```

---

## 安全最佳实践

### 1. Token 权限最小化

为每个平台配置最小必要权限：

| 平台 | 最小权限建议 |
|------|-------------|
| NPM | 仅发布特定包，而非所有包 |
| RubyGems | 仅发布特定 gem |
| PyPI | 特定项目权限或项目上传权限 |
| Cloudsmith | 仅特定仓库写入权限 |

### 2. Token 过期管理

- **短期 token**: 开发/测试环境，设置 30-90 天过期
- **长期 token**: 生产/发布环境，建议 no expiration
- **定期轮换**: 每 6-12 个月更新一次

### 3. 加密存储

GitHub Secrets 本身已加密，但额外建议：

- 不在代码、commit、PR 中硬编码 token
- 使用环境变量而非命令行参数传递 token
- 定期审查和清理未使用的 secrets

### 4. 审计日志

GitHub Actions 提供审计日志：

1. 进入仓库 → **Settings** → **Actions** → **General**
2. 找到 **Workflow permissions** 或 **Secrets**
3. 查看最近使用情况和修改历史

---

## 故障排查

### NPM 发布失败

```bash
Error: 404 Not Found - PUT https://registry.npmjs.org/...
```

**解决方案**:
- 检查 `NPM_API_KEY` 是否正确
- 确认包名在 npm 中已注册
- 验证 token 是否有发布权限

### RubyGems 发布失败

```bash
ERROR: 403 Forbidden
```

**解决方案**:
- 确认 `RUBYGEMS_API_KEY` 权限
- 检查 gem 名称是否已被占用
- 验证 API key 格式（无额外空格）

### PyPI 发布失败

```bash
HTTPError: 400 Bad Request from https://upload.pypi.org/legacy/
```

**解决方案**:
- PyPI 要求 2FA，确保已启用
- 检查 `PYPI_API_KEY` scope
- 验证 `setup.py` 或 `pyproject.toml` 配置

### Homebrew PR 失败

```yaml
Error: Unable to find formula: hookflow
```

**解决方案**:
- 确认 formula 已在 homebrew-core 中
- 检查 `HOMEBREW_TOKEN` 权限
- 验证 fork 用户名配置

### Snapcraft 登录失败

```bash
Login failed: Invalid credentials
```

**解决方案**:
- 使用 Macro Token 替代普通凭据
- 检查 `SNAPCRAFT_STORE_CREDENTIALS` JSON 格式
- 确认 snap 名称已注册

### AUR SSH 认证失败

```bash
Permission denied (publickey)
```

**解决方案**:
- 验证私钥格式（完整的 PEM 格式）
- 确认公钥已上传到 AUR
- 检查 SSH key 权限（600）

---

## 快速参考

### GitHub Secrets 配置清单

在仓库 **Settings → Secrets and variables → Actions** 中配置：

```bash
✅ GITHUB_TOKEN         (自动提供，无需配置)
⚠️ NPM_API_KEY         (NPM 发布)
⚠️ RUBYGEMS_API_KEY    (RubyGems 发布)
⚠️ PYPI_API_KEY        (PyPI 发布)
⚠️ HOMEBREW_TOKEN      (Homebrew 更新)
⚠️ WINGET_TOKEN        (Winget 更新)
⚠️ CLOUDSMITH_API_KEY  (Cloudsmith 推送)
⚠️ SNAPCRAFT_STORE_CREDENTIALS (Snap Store 发布)
⚠️ AUR_SSH_KEY         (AUR 更新)
```

### 验证命令

```bash
# NPM
npm whoami

# RubyGems
gem owner hookflow

# PyPI
pip show hookflow

# Homebrew
brew search hookflow

# Winget
winget search hookflow

# Snap
snap search hookflow

# AUR (使用 yay)
yay -Ss hookflow
```

---

## 相关资源

- [GitHub Actions Secrets 文档](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [NPM Token 文档](https://docs.npmjs.com/creating-and-viewing-access-tokens)
- [RubyGems API 文档](https://guides.rubygems.org/rubygems-org-api/)
- [PyPI API Token 文档](https://pypi.org/help/#apitoken)
- [Homebrew Formula 文档](https://docs.brew.sh/Formula-Cookbook)
- [Winget Packages 文档](https://learn.microsoft.com/windows/package-manager/winget/)
- [Cloudsmith 文档](https://help.cloudsmith.io/doc/)
- [Snapcraft 文档](https://snapcraft.io/docs/)
- [Arch User Repository 文档](https://wiki.archlinux.org/title/Arch_User_Repository)
