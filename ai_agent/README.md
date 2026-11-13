# AI Agent 配置

此目录保存实际文件，`~/.claude` 通过软链接使用它们：

| 实际文件 | 软链接 |
| --- | --- |
| `ai_agent/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `ai_agent/skills/task-flow/` | `~/.claude/skills/task-flow` |

## 新电脑配置

### 1. 安装依赖并获取仓库

安装 Git 和 [Claude Code](https://code.claude.com/docs/en/setup)，并完成 Claude Code 的认证配置。

```sh
mkdir -p "$HOME/.config"
git clone https://github.com/Weissle/dotfiles "$HOME/.config/dotfiles"
```

如果已经克隆，使用现有仓库。以下命令假定仓库位于 `~/.config/dotfiles`；使用其他路径时，修改下一步的 `agent_config`。

task-flow 依赖 Ponytail 的 `ponytail:ponytail-review`，需要单独安装：

```sh
claude plugin install ponytail --marketplace DietrichGebert/ponytail --scope user
```

### 2. 备份现有配置并创建软链接

复制整个代码块执行。现有文件、目录或软链接会移到独立的备份目录，备份位置会打印到终端。

```sh
(
    set -eu
    agent_config="$HOME/.config/dotfiles/ai_agent"
    test -f "$agent_config/CLAUDE.md"
    test -d "$agent_config/skills/task-flow"

    mkdir -p "$HOME/.claude/skills" "$HOME/.claude/backups"
    backup_dir="$(mktemp -d "$HOME/.claude/backups/ai-agent.XXXXXX")"
    printf '原配置备份目录：%s\n' "$backup_dir"

    for entry in CLAUDE.md skills/task-flow; do
        target="$HOME/.claude/$entry"
        if [ -e "$target" ] || [ -L "$target" ]; then
            mv "$target" "$backup_dir/"
        fi
        ln -s "$agent_config/$entry" "$target"
    done
)
```

### 3. 验证并启动新会话

```sh
ls -ld "$HOME/.claude/CLAUDE.md" "$HOME/.claude/skills/task-flow"
claude plugin validate "$HOME/.claude/skills/task-flow"
claude plugin details task-flow@skills-dir
```

`ls` 输出中的链接目标应指向 dotfiles 仓库。全局规则会从 `~/.claude/CLAUDE.md` 读取；task-flow 在新会话中加载。

`~/.claude/skills/` 下插件的自动发现方式已在 Claude Code 2.1.318 上确认。如果其他版本没有发现插件，可以显式加载：

```sh
claude --plugin-dir "$HOME/.config/dotfiles/ai_agent/skills/task-flow"
```

新会话中使用 `/task-flow:simple-task` 或 `/task-flow:complex-task`。更多用法见 [task-flow README](skills/task-flow/README.md)。

## 日常维护

直接编辑本目录中的文件，或通过 `~/.claude` 中的软链接编辑；两种方式修改的都是同一份实际文件。通过 Git 提交和推送，再在其他电脑更新仓库，即可同步配置。修改 task-flow 后启动新会话。

软链接使用绝对路径，移动或删除仓库会使链接失效；移动后重新执行链接步骤。认证信息、个人 `settings.json` 和 Ponytail 插件需要在每台电脑单独配置。
