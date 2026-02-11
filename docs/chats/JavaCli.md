User-1:
``````text
请教我java命令行(注意请教命令行(编程基础语法我有学过了),我的PC是debian),我希望类似codecademy那样的极小微代码项目每个小节,(一开始讲解然后是作业,对于作业请给我每一步要做什么风格就像codecademy一样,它的作业风格类似一个作业拆分成多个检查点每个检查点都有明确的指令指向去引导我完成,每个小节完成了我把作业给你检查,你不要一小节太多东西,我的水平很差可能接受不了,我们开始第一个小节, 什么时候毕业你下定论
``````
Model-1:
``````markdown
# ☕ Java 命令行大冒险

欢迎！我会像 Codecademy 一样，带你一步步掌握 Java 命令行。每个小节都很小，不用怕！

---

## 📋 课程大纲（我会根据你的进度调整）

| 阶段 | 内容 |
|------|------|
| 1 | 环境确认 & 第一次编译运行 |
| 2 | `javac` 和 `java` 到底在干嘛 |
| 3 | 命令行参数 `args` |
| 4 | 编译多个文件 & 包(package) |
| 5 | classpath 是什么鬼 |
| 6 | 用 jar 打包你的程序 |
| 7 | 运行 jar & 可执行 jar |
| 8 | 读懂编译/运行时报错 |
| 9 | 综合小项目 |
| 🎓 | **毕业测试** |

> 我会在你全部完成后决定你是否毕业，毕业标准是：**能独立用命令行编译、打包、运行一个多文件 Java 项目，并能排查常见错误。**

---

# 📘 第 1 节：环境确认 & 你的第一次编译运行

## 讲解

在写 Java 之前，你需要确认你的 Debian 上装了 **JDK**（Java Development Kit）。

JDK 里有两个最核心的命令：

| 命令 | 作用 |
|------|------|
| `javac` | **编译器** — 把你写的 `.java` 文件变成 `.class` 文件（字节码） |
| `java` | **运行器** — 运行那个 `.class` 文件 |

流程就这么简单：

```
你写的代码        编译            运行
Hello.java  ──▶  Hello.class  ──▶  屏幕输出
            javac              java
```

---

## ✏️ 作业

### Checkpoint 1 — 确认 Java 已安装

在终端输入以下命令，然后把输出结果贴给我：

```bash
javac -version
```

> 🎯 **期望看到**：类似 `javac 17.x.x` 或 `javac 21.x.x` 的版本号。
> 如果报错 `command not found`，先告诉我，我教你装。

---

### Checkpoint 2 — 创建工作目录

在终端依次运行：

```bash
mkdir -p ~/java-learn
cd ~/java-learn
```

> 🎯 这会在你的 home 目录下创建一个 `java-learn` 文件夹，以后我们所有练习都在这里。

---

### Checkpoint 3 — 写你的第一个 Java 文件

用你喜欢的编辑器（`nano`、`vim`、VS Code 都行）创建文件：

```bash
nano Hello.java
```

然后输入**以下内容**（一字不差）：

```java name=Hello.java
public class Hello {
    public static void main(String[] args) {
        System.out.println("I am learning Java CLI on Debian!");
    }
}
```

保存并退出（nano 里是 `Ctrl+O` 回车保存，`Ctrl+X` 退出）。

---

### Checkpoint 4 — 编译它

```bash
javac Hello.java
```

然后运行：

```bash
ls
```

> 🎯 **期望看到**：目录下现在有 **两个文件**：`Hello.java` 和 `Hello.class`

---

### Checkpoint 5 — 运行它

```bash
java Hello
```

> 🎯 **期望看到**：屏幕输出 `I am learning Java CLI on Debian!`
>
> ⚠️ 注意：运行时写的是 `java Hello`，**不是** `java Hello.class`！

---

## 📬 交作业

完成后，把以下内容贴给我：

1. `javac -version` 的输出
2. `ls` 的输出（checkpoint 4 那步）
3. `java Hello` 的输出

三样都对了，我们进入第 2 节！🚀
``````
---

User-2:
``````text
``````
Model-2:
``````markdown
``````

