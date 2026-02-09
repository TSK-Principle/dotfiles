User-1:
``````text
请教我云(我是云初学者,我没有钱也没有信用卡去启动免费的云套餐,但是朋友告诉我可以用aws-cli和localstack,我用的哥哥的电脑他自己装的debian),我希望类似codecademy那样的极小微代码项目每个小节,(一开始讲解然后是作业,对于作业请给我每一步要做什么风格就像codecademy一样,它的作业风格类似一个作业拆分成多个检查点每个检查点都有明确的指令指向去引导我完成,每个小节完成了我把作业给你检查,你不要一小节太多东西,我的水平很差可能接受不了,我们开始第一个小节, 什么时候毕业你下定论
``````
Model-1:
``````markdown
太棒了！欢迎来到 **“零成本云工程师”** 第一课。

我很喜欢你的朋友给你的建议。**LocalStack** 就像是一个安装在你哥哥电脑里的“模拟器”。真正的 AWS 云需要钱，而 LocalStack 是一个在本地运行的“假”云，但操作方式和真的一模一样。学会了它，以后你有了信用卡，无缝切换到真正的 AWS 只需要改一行配置。

既然你的水平是初学者，而且用的是 Debian (Linux)，我们甚至不需要鼠标，我们将主要在那个黑色的窗口（终端）里通过打字来指挥云。

不用担心，我会带你一步步走。我们这一小节的目标非常小，甚至还没到启动云服务，我们先要装好“方向盘”。

---

## 第 1 课：安装你的“方向盘” (AWS CLI)

### 🎓 概念讲解

**什么是 AWS CLI？**
想象一下，云是一台巨大的超级计算机。

* 你可以用鼠标在网页上点点点来控制它（这叫控制台）。
* 你也可以像黑客一样，敲一行代码控制它。这行代码工具就叫 **AWS CLI** (Command Line Interface)。

专业的云工程师都用 CLI，因为它快、酷，而且可以自动化。既然我们在 Debian 系统上，这正是我们的主场。

---

### 🛠️ 实战作业：配置环境

请打开你哥哥电脑上的 **Terminal (终端)**，通常是一个黑色的图标。

按照下面的**检查点 (Checkpoints)**，一步步操作。每完成一步，你就在心里打个勾。

#### ✅ Checkpoint 1: 检查 Python

LocalStack 是用 Python 写成的，我们需要确保电脑里有它。
在终端输入以下命令并回车：

```bash
python3 --version

```

> **预期结果：** 你应该看到类似 `Python 3.x.x` 的字样。如果没有，请告诉我。

#### ✅ Checkpoint 2: 安装 AWS CLI

我们需要安装这个工具来向云发送指令。在 Debian 上，我们用 `apt` 命令。
*(注意：这可能需要输入你哥哥电脑的密码)*
输入：

```bash
sudo apt update
sudo apt install awscli -y

```

安装完成后，验证是否安装成功：

```bash
aws --version

```

> **预期结果：** 屏幕应该显示类似 `aws-cli/1.x.x ...` 或 `aws-cli/2.x.x ...` 的版本号。

#### ✅ Checkpoint 3: 配置“假”身份

AWS CLI 默认会问你要账号密码。因为我们用的是 LocalStack（模拟器），我们可以随便填，但必须得填，否则 CLI 不让过。

输入以下命令：

```bash
aws configure

```

接下来它会连续问你四个问题，请完全按照下面的内容输入（**不要担心安全问题，因为我们在做假配置**）：

1. `AWS Access Key ID`: 输入 **test** 然后回车。
2. `AWS Secret Access Key`: 输入 **test** 然后回车。
3. `Default region name`: 输入 **us-east-1** 然后回车。
4. `Default output format`: 输入 **json** 然后回车。

---

### 📤 提交作业

恭喜！你刚刚完成了云工程师生涯的第一步配置。

请把以下两个命令的运行结果复制粘贴给我，我来检查你是否准备好进入下一节了：

1. `aws --version` 的输出结果。
2. `aws configure list` 的输出结果。

(等你提交后，我们再进行下一节：安装那个“模拟器”本身)
``````

---

User-2:
``````text

~
> python3 --version
Python 3.13.5

~
> aws --version
aws-cli/2.23.6 Python/3.13.5 Linux/6.12.63+deb13-amd64 source/x86_64.debian.13

~
> aws configure
AWS Access Key ID [None]: test
AWS Secret Access Key [None]: test
Default region name [None]: us-east-1
Default output format [None]: json

~ on aws (us-east-1) took 48s
>
``````
Model-2:
``````markdown
干得漂亮！作业满分通过。
看到 `aws --version` 显示 `Python 3.13.5`，这说明你的基础环境很新，非常好。而且你已经配置好了 `test` 凭证，你的“方向盘”已经装好了。

现在，我们要把“引擎”装进去。但是，为了不把你不小心把你哥哥的电脑系统搞乱（比如安装了一堆乱七八糟的软件），我们要先做一个**隔离区**。在 Python 的世界里，这叫“虚拟环境” (Virtual Environment)。

想象我们在你哥哥的电脑里放了一个独立的沙箱，我们在沙箱里怎么玩都不会影响外面的系统。

---

## 第 2 课：搭建沙箱与安装模拟器 (LocalStack)

### 🎓 概念讲解

1. **虚拟环境 (venv)**：给你的项目穿一件防护服。所有的工具都装在这里面。
2. **LocalStack CLI**：这是启动“假云”的启动器。
3. **Docker**：这是 LocalStack 赖以生存的底层引擎。如果说 LocalStack 是个软件，Docker 就是承载它的操作系统。我们需要确认你哥哥的电脑里有没有它。

---

### 🛠️ 实战作业：搭建环境

请继续在那个黑色窗口（终端）里操作。

#### ✅ Checkpoint 1: 创建你的专属文件夹

我们要把所有东西都放在一个地方。

```bash
mkdir cloud-study
cd cloud-study

```

*(解释：`mkdir` 是制造一个文件夹，`cd` 是走进这个文件夹)*

#### ✅ Checkpoint 2: 创建并进入“隔离沙箱”

这是最关键的一步，保护你哥哥的电脑环境。

```bash
python3 -m venv venv
source venv/bin/activate

```

> **注意：** 执行完第二句后，你的命令行前面应该多了一个 `(venv)` 的字样。这说明你已经进入沙箱了！以后每次学习前，都要确保看到这个标志。

#### ✅ Checkpoint 3: 安装 LocalStack

现在我们在沙箱里，可以大胆地安装软件了。

```bash
pip install localstack

```

等待安装进度条跑完。

#### ✅ Checkpoint 4: 检查引擎 (Docker)

LocalStack 必须依赖 Docker 才能运行。我们需要看看你哥哥有没有装它。

```bash
docker --version

```

---

### 📤 提交作业

请把这一小节的操作结果告诉我，特别是最后一步。
请复制粘贴以下三个信息：

1. 你是否看到了命令行前面有 `(venv)` 字样？(回答是/否)
2. `localstack --version` 的输出结果。
3. `docker --version` 的输出结果 (如果显示 command not found，也请如实告诉我，这很重要)。

(如果你有 Docker，下一节我们就启动云！如果没有，下一节我们要先装 Docker。)
``````

---

User-3:
``````text

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
> localstack --version
LocalStack CLI 4.13.0

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
> docker --version
Docker version 29.2.0, build 0b9d198

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
>
``````
Model-3:
``````markdown
太棒了！你的环境简直完美。
Docker 已经就位，版本也很新；你也在 `(venv)` 沙箱里了。而且我看你的终端提示符 (`~/cloud-study via py v3.13.5...`) 显示你好像用了一些很酷的终端主题，看来你哥哥把电脑配置得很好。

现在，我们要点火启动了！

---

## 第 3 课：启动云端与第一个存储桶

### 🎓 概念讲解

1. **Docker 镜像 (Image)**：LocalStack 就像是一个巨大的压缩包，我们需要先把它从网上“拉”下来（这叫 Pull），然后在 Docker 里运行它。
2. **S3 (Simple Storage Service)**：这是我们要学的第一个云服务。别被名字吓到，把它想象成**“云端无限容量的硬盘”**或者就是一个**“超级文件夹”**。
3. **Endpoint URL (端点)**：这是本节最难的概念。
* 当你敲 `aws` 命令时，它默认会去连接亚马逊美国的服务器 (`aws.amazon.com`)。
* 但我们没有钱，我们要连自己电脑上的 LocalStack。
* 所以我们需要告诉命令：“嘿，别去美国，去连接 `http://localhost:4566` (这是 LocalStack 在你电脑上的门牌号)”。



---

### 🛠️ 实战作业：点火与存储

#### ✅ Checkpoint 1: 启动 LocalStack

我们要让云在后台运行。
输入：

```bash
localstack start -d

```

> **注意：** 第一次运行这个命令时，它会去下载大约几百 MB 的数据（Docker 镜像），可能会卡住一会儿，取决于你的网速。请耐心等待，直到它显示 `Ready.` 或者回到命令行提示符。
> *参数解释：`-d` (Detached) 意思是在后台静默运行，不占用你的打字窗口。*

#### ✅ Checkpoint 2: 检查云是否活了

确认它已经正常工作。
输入：

```bash
localstack status services

```

> **预期结果：** 你应该看到一张表，或者显示 `running` 的状态。只要没有报错说 "Connection refused"，就是成功了。

#### ✅ Checkpoint 3: 创建你的第一个“云文件夹” (S3 Bucket)

现在我们要用 AWS CLI 向这个假云发送指令。我们要创建一个叫 `my-wallet` 的存储桶（Bucket）。

**请仔细输入这行长命令（注意那个 url 参数）：**

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-wallet

```

*(命令翻译：aws 工具 -> 目标地址是本地 -> s3 服务 -> make bucket (mb) -> 名字叫 my-wallet)*

#### ✅ Checkpoint 4: 确认文件夹已创建

我们问问云：“我现在有哪些桶？”

```bash
aws --endpoint-url=http://localhost:4566 s3 ls

```

---

### 📤 提交作业

这一步如果你成功了，你就正式成为“在云上运行过资源的人”了！

请把以下结果复制给我：

1. Checkpoint 3 的输出结果（通常会显示 `make_bucket: ...`）。
2. Checkpoint 4 的输出结果（应该显示出你刚刚创建的桶）。

(如果在第一步下载卡住了或者报错，请直接告诉我，我们来修。)
``````

---

User-4:
``````text

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
> aws --endpoint=http://localhost:4566 s3 mb s3://my-wallet
make_bucket: my-wallet

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1) took 2s
> aws --endpoint=http://localhost:4566 s3 ls
2026-01-31 13:48:47 my-wallet

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
>
``````
Model-4:
``````markdown
太棒了！你成功了！🎉
你现在正式拥有了一个运行在你哥哥电脑里的“私有云存储”，而且你已经成功创建了你的第一个存储桶 `my-wallet`。

哪怕是很多入行的初学者，在这一步都会因为网络配置或者端口问题卡住，你一次就过了，非常有天赋！

现在我们要进行下一步。虽然你做到了，但你有没有发现每次都要打 `--endpoint-url=http://localhost:4566` 这串长长的尾巴非常麻烦？如果不小心打错一个字母，命令就会失败。

这一节，我们要干两件事：

1. 往你的桶里放点东西。
2. 安装一个“魔法工具”，让我们以后再也不用打那串长长的尾巴。

---

## 第 4 课：上传文件与安装“魔法工具”

### 🎓 概念讲解

1. **对象 (Object)**：在云存储(S3)里，文件不叫文件，叫“对象”。
2. **cp (Copy)**：这是 Linux 和 AWS 里通用的命令，意思是“复制”。我们要把本地的文件“复制”到云端。
3. **awslocal**：这是一个专门为 LocalStack 设计的小工具。它会自动帮你在后台加上 `http://localhost:4566`，这样你打命令时就感觉像在用真的 AWS 一样简洁。

---

### 🛠️ 实战作业

#### ✅ Checkpoint 1: 制作一个假文件

我们要先在本地造一个文件，用来测试上传。
输入以下命令：

```bash
echo "Hello Cloud!" > money.txt

```

*(解释：这句话的意思是，把 "Hello Cloud!" 这句话写入到 money.txt 这个文件里。如果文件不存在，它会自动创建。)*

#### ✅ Checkpoint 2: 把文件“扔”进云里

现在，把这个 `money.txt` 上传到你上一节建好的 `my-wallet` 桶里。
*(我们再最后忍受一次长命令)*

```bash
aws --endpoint-url=http://localhost:4566 s3 cp money.txt s3://my-wallet

```

> **注意：** 如果你上一节用 `--endpoint` 也能跑通，那很神奇（可能是新版特性），但标准写法是 `--endpoint-url`，建议养成标准习惯。

#### ✅ Checkpoint 3: 安装“魔法工具” (awslocal)

现在我们要解放双手了。请在你的沙箱里安装这个神器：

```bash
pip install awscli-local

```

#### ✅ Checkpoint 4: 见证魔法

安装好后，我们以后所有的 `aws` 命令都可以换成 `awslocal`，并且**再也不用**写 endpoint 那一长串了！

试着用新命令查看你的桶里有什么：

```bash
awslocal s3 ls s3://my-wallet

```

---

### 📤 提交作业

请把 Checkpoint 4 的输出结果复制给我。

> **预期结果：** 你应该能看到类似 `2026-01-31 ... money.txt` 的字样。这就证明你的文件已经稳稳地躺在“云端”了。

(如果这一步成功，下一节我们将学习如何在这个“云”里搭建一个极简的静态网站！)
``````

---

User-5:
``````text

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1) took 29s
> awslocal s3 ls s3://my-wallet
2026-01-31 13:58:49         13 money.txt

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
>
``````
Model-5:
``````markdown
太棒了！你的进度非常快，而且 `awslocal` 已经完全工作正常。现在的你，打起命令来应该感觉轻松多了吧？

接下来我们要玩个大的。我们将要把你的这个“云盘”变成一个**网站服务器**。

---

## 第 5 课：把存储桶变成网站 (Static Website)

### 🎓 概念讲解

1. **静态网站 (Static Website)**：这是最古老也是最快的一种网站。它只包含纯展示的内容（HTML），就像一张贴在公告栏上的海报，每个人看到的都是一样的。
2. **S3 网站托管**：S3 有个神奇的功能，只要你开启它，你的存储桶就会变成一个网站服务器，外界就可以通过网址访问里面的文件了。
3. **curl**：这是一个命令行版的“浏览器”。它没有图形界面，但是可以帮我们抓取网页的内容。

---

### 🛠️ 实战作业：上线你的第一个网页

#### ✅ Checkpoint 1: 编写网页代码

虽然我们不教写网页，但我们需要一个极其简单的页面。
在终端输入：

```bash
echo "<h1>Hello from LocalStack!</h1>" > index.html

```

*(解释：这行代码创建了一个包含标题的 HTML 文件)*

#### ✅ Checkpoint 2: 创建一个新的桶

我们为了区分刚才的钱包，新建一个专门放网站的桶，叫 `my-site`。

```bash
awslocal s3 mb s3://my-site

```

#### ✅ Checkpoint 3: 开启“网站模式”

这是最关键的一步。我们要告诉云：“嘿，这个桶不仅仅是用来存文件的，它是用来做网站的，首页是 `index.html`。”

```bash
awslocal s3 website s3://my-site --index-document index.html

```

*(如果没有报错，通常不会有任何输出，这就是好消息)*

#### ✅ Checkpoint 4: 上传网页

把刚才写的 `index.html` 上传进去。

```bash
awslocal s3 cp index.html s3://my-site

```

#### ✅ Checkpoint 5: 访问你的网站！

激动人心的时刻到了。
在真正的 AWS 里，你会得到一个很长的网址。在 LocalStack 里，我们的网址是本地的。
我们用 `curl` 这个命令行浏览器来访问它：

```bash
curl http://my-site.s3-website.us-east-1.localhost.localstack.cloud:4566/

```

> **如果上面的命令太长报错或者无法解析**，请尝试这个备用命令（LocalStack 的不同版本有时候网址规则不同）：
> `curl http://localhost:4566/my-site/index.html`

---

### 📤 提交作业

请把 **Checkpoint 5** 的输出结果复制给我。

> **预期结果：** 你应该会在那个黑框框里看到这行代码被“吐”了出来：
> `<h1>Hello from LocalStack!</h1>`

如果你看到了这句话，恭喜你，你已经成功部署了一个网站！
(如果成功，下一节我们来清理战场，学习如何“销毁”资源，这是云工程师省钱的关键！)
``````

---

User-6:
``````text

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
> curl http://localhost:4566/my-site/index.html
<h1>Hello from LocalStack!</h1>

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
>

``````
Model-6:
``````markdown
恭喜！看到那行 `<h1>Hello from LocalStack!</h1>`，意味着你已经成功完成了一次完整的云端部署。

在真实的 AWS 世界里，你刚才开启的每一秒钟都在计费。虽然 LocalStack 是免费的，但**“随手关灯（清理资源）”**是云工程师最重要的素养之一。如果不清理，你的信用卡账单可能会像坐火箭一样起飞。

这也是我们 Level 1 的最后一课：**销毁**。

---

## 第 6 课：清理战场 (销毁资源)

### 🎓 概念讲解

1. **RB (Remove Bucket)**：这是删除存储桶的命令。
2. **非空保护**：这是云厂商为了防止你手滑误删数据做的一个机制。如果一个桶里还有文件，云是不允许你直接把桶删掉的。你必须先清空文件，再删桶。

---

### 🛠️ 实战作业：有始有终

#### ✅ Checkpoint 1: 尝试暴力删除 (并观察失败)

我们要先故意犯个错，看看云是怎么保护数据的。
尝试直接删除 `my-site` 这个桶：

```bash
awslocal s3 rb s3://my-site

```

> **预期结果：** 你应该会看到一个报错，包含 `BucketNotEmpty` 的字样。这是正常的！

#### ✅ Checkpoint 2: 清空文件

既然它嫌桶不空，那我们就把里面的 `index.html` 删掉。
使用 `rm` (remove) 命令：

```bash
awslocal s3 rm s3://my-site/index.html

```

#### ✅ Checkpoint 3: 再次删除桶

现在桶是空的了，再次尝试删除：

```bash
awslocal s3 rb s3://my-site

```

> **预期结果：** 这次应该会显示 `remove_bucket: my-site`。

#### ✅ Checkpoint 4: 最终核查

确认一下它真的消失了。

```bash
awslocal s3 ls

```

> **预期结果：** 你应该只看得到 `my-wallet` (那个钱包桶还在)，但看不到 `my-site` 了。

---

### 🎓 毕业典礼：Level 1 结业

等你提交这最后一次作业（Checkpoint 4 的输出），我就正式宣布你 **Level 1 毕业**。

**请提交：**

1. Checkpoint 1 的报错信息（这很重要，我想确认你看到了那个错误）。
2. Checkpoint 4 的最终列表。

提交后，我会给你做一个简短的总结，并为你颁发这一阶段的“云工程师徽章”。我们就可以结束今天的课程，让你休息一下了！
``````

---

User-7:
``````text
~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
> awslocal s3 rb s3://my-site

remove_bucket failed: s3://my-site An error occurred (BucketNotEmpty) when calling the DeleteBucket operation: The bucket you tried to delete is not empty

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
x awslocal s3 rm s3://my-site/index.html

delete: s3://my-site/index.html

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
> awslocal s3 rb s3://my-site

remove_bucket: my-site

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1)
> awslocal s3 ls

2026-02-06 00:53:45 my-wallet
``````

Model-7:
``````markdown
太棒了！🎉 恭喜你圆满完成了这一系列的挑战。

看到报错 `BucketNotEmpty` 证明你已经触碰到了云安全的“防呆机制”，而最后的 `ls` 列表中只有 `my-wallet`，说明你完美地执行了“清理战场”的任务。

我现在正式宣布：**你已经从“零成本云工程师” Level 1 课程毕业了！** 🎓

---

### 🏆 毕业总结：你现在掌握了什么？

回顾一下，作为一个“没钱也没信用卡”的云初学者，你在短短的时间里完成了惊人的跨越。请不要小看这些技能，这正是真正的云架构师每天在做的事情的基础：

1. **环境配置**：你学会了在 Linux 终端里配置 Python 虚拟环境和 AWS CLI —— **这是专业人士的起手式。**
2. **本地云模拟**：你驾驭了 LocalStack 和 Docker，在没有花一分钱的情况下拥有了自己的私有云。
3. **对象存储 (S3)**：你学会了创建存储桶、上传文件。
4. **静态网站托管**：你亲手部署了一个网页，并成功通过模拟的域名访问了它。
5. **资源生命周期管理**：你学会了最重要的一课——如何安全地销毁资源，防止意外扣费（虽然是在模拟器里，但这个习惯价值千金）。

---

### 🌟 下一步计划

虽然你把决定权交给了我，但我认为**今天是一个完美的暂停点**。你已经吸收了很多新概念，与其急着往下塞，不如让你哥哥稍微夸奖一下你刚才做出的那个网页（虽然已经删了，哈哈）。

当你准备好继续时，我们的 **Level 2** 将会进入 **“计算 (Compute)”** 的世界。
也就是不再只是“存文件”，而是让云帮我们“跑程序”（比如 Lambda 函数或者模拟 EC2 服务器）。

**你现在想怎么做？**

* **选项 A**：休息！今天就到这里，我很满意。
* **选项 B**：我不累，我想趁热打铁，立刻开始 Level 2（学习如何让云帮我运行代码）。

(告诉我你的选择，或者直接关闭窗口去庆祝吧！)
``````

---

User-8:
``````text
B
``````
Model-8:
``````markdown
太棒了！我就喜欢这种趁热打铁的劲头。🔥

欢迎来到 **Level 2：计算 (Compute)**。

如果说 Level 1 的 S3 是云端的“硬盘”（用来存东西），那么 Level 2 我们要学习的就是云端的“大脑”（用来算东西）。

我们将学习最酷的一种计算方式：**Serverless (无服务器/AWS Lambda)**。
以前，你想在云上运行代码，得先买一台虚拟电脑（EC2），装系统，装环境，很麻烦。
现在，有了 Lambda，你只需要把代码“扔”上去，云会自动给你分配资源运行，跑完立刻释放。就像你打车一样，上车付费，下车走人，不需要自己养车。

---

## Level 2 - 第 1 课：打造你的第一个云函数

### 🎓 概念讲解

1. **Lambda 函数**：这就是我们的一段代码。
2. **Runtime (运行时)**：告诉云你的代码是用什么语言写的（我们用 Python）。
3. **Handler (处理器)**：告诉云，代码运行起来后，第一步先执行哪个函数（入口）。
4. **Zip 打包**：AWS Lambda 要求我们将代码打包成 `.zip` 压缩包才能上传。

---

### 🛠️ 实战作业：编写并部署代码

请确保你还在那个黑色的终端里，并且能看到 `(venv)` 的标志。

#### ✅ Checkpoint 1: 编写代码

我们需要写一个极其简单的 Python 程序。
输入下面的命令，创建 `func.py`：

```bash
echo 'def handler(event, context): return "Hello from Level 2!"' > func.py


```

*(解释：这行代码定义了一个叫 `handler` 的函数，它什么都不做，只返回一句话。)*

#### ✅ Checkpoint 2: 准备打包工具

我们需要把这个文件压缩。Debian 系统有时候没有预装 `zip` 工具，我们先安装它（如果你哥哥装过了，这步会很快）。

```bash
sudo apt install zip -y


```

#### ✅ Checkpoint 3: 打包代码

现在把 `func.py` 压缩成 `function.zip`。

```bash
zip function.zip func.py


```

> **预期结果：** 屏幕显示 `adding: func.py (stored 0%)` 之类的信息。

#### ✅ Checkpoint 4: 部署到云端

这是最长的一条命令，请仔细复制。我们要告诉 LocalStack：
“创建一个叫 `my-func` 的函数，用 Python 3.10 跑，代码在压缩包里，入口是 `func` 文件里的 `handler` 函数，角色身份随便填（test-role）。”

```bash
awslocal lambda create-function \
    --function-name my-func \
    --runtime python3.10 \
    --zip-file fileb://function.zip \
    --handler func.handler \
    --role arn:aws:iam::000000000000:role/test-role


```

*(注意：如果命令太长换行了，请确保完整复制)*

---

### 📤 提交作业

如果 Checkpoint 4 成功，云端应该会返回一大串 JSON 数据（包括 FunctionArn, CodeSize 等信息）。

请把你 **Checkpoint 4 的输出结果** 复制给我。
(只要看到那一大串 JSON，就说明你的代码已经成功“住”进云里了！下一节我们来运行它。)
``````

---

User-9:
``````text
~/cloud-study via py v3.13.5 (venv) on aws (us-east-1) took 4s
> awslocal lambda create-function \
          --function-name my-func \
          --runtime python3.10 \
          --zip-file fileb://function.zip \
          --handler func.handler \
          --role arn:aws:iam::000000000000:role/test-role
{
    "FunctionName": "my-func",
    "FunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:my-func",
    "Runtime": "python3.10",
    "Role": "arn:aws:iam::000000000000:role/test-role",
    "Handler": "func.handler",
    "CodeSize": 224,
    "Description": "",
    "Timeout": 3,
    "MemorySize": 128,
    "LastModified": "2026-02-07T06:29:13.695536+0000",
    "CodeSha256": "Y5I2r+Y0RIkYF/Eigd/YQkGHKIEHBH21XkaUiLW3AK8=",
    "Version": "$LATEST",
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "40863100-41ab-41eb-b432-b2179b78f180",
    "State": "Pending",
    "StateReason": "The function is being created.",
    "StateReasonCode": "Creating",
    "PackageType": "Zip",
    "Architectures": [
        "x86_64"
    ],
    "EphemeralStorage": {
        "Size": 512
    },
    "SnapStart": {
        "ApplyOn": "None",
        "OptimizationStatus": "Off"
    },
    "RuntimeVersionConfig": {
        "RuntimeVersionArn": "arn:aws:lambda:us-east-1::runtime:8eeff65f6809a3ce81507fe733fe09b835899b99481ba22fd75b5a7338290ec1"
    },
    "LoggingConfig": {
        "LogFormat": "Text",
        "LogGroup": "/aws/lambda/my-func"
    }
}

~/cloud-study via py v3.13.5 (venv) on aws (us-east-1) took 5s
>
``````
Model-9:
``````markdown
太棒了！🎉 看到那一大串 JSON 代码，就说明你的第一个“云大脑”已经诞生了。

注意看 `State: Pending`（等待中）和 `StateReason: Creating`（正在创建）。在真正的 AWS 里，这可能需要几秒钟准备；在 LocalStack 里，它通常也很快。

现在代码已经上传了，但它还静静地躺在那儿，什么都没做。我们需要“戳”它一下，让它跑起来。这在云术语里叫 **Invoke (调用)**。

---

## Level 2 - 第 2 课：唤醒你的代码 (Invoke)

### 🎓 概念讲解

1. **调用 (Invoke)**：就像你按遥控器按钮一样。你可以手动按（手动调用），也可以设置定时器自动按（定时任务），还可以让别的程序按（API 调用）。
2. **同步 vs 异步**：
* **同步 (RequestResponse)**：你喊它一声，你就站在那儿等，直到它回话。
* **异步 (Event)**：你喊它一声，转身就走，它跑完会把结果记在日志里。
* 我们今天用**同步**，因为我们要立刻看到结果。


3. **Payload (载荷)**：这是你发给函数的“参数”。虽然我们现在的函数很简单，不看参数，但 AWS CLI 总是会把结果存到一个文件里，而不是直接显示在屏幕上（这点和 Python 不一样）。

---

### 🛠️ 实战作业：第一次运行

#### ✅ Checkpoint 1: 发送指令

我们要命令云端运行 `my-func`，并且把它说的话，记在一个叫 `response.json` 的文件里。

输入：

```bash
awslocal lambda invoke --function-name my-func response.json


```

> **预期结果：**
> 你会看到一段像这样的简短回复，只要 `StatusCode` 是 `200`，就说明命令发送成功了：
> ```json
> {
>     "StatusCode": 200,
>     "ExecutedVersion": "$LATEST"
> }
> 
> ```
> 
> 

#### ✅ Checkpoint 2: 查看云的回信

刚才那步只是告诉你“云收到了命令”。真正的运行结果（我们在 Python 里写的 `return "Hello..."`）被保存在了 `response.json` 文件里。

让我们看看文件里写了什么：

```bash
cat response.json


```

---

### 📤 提交作业

请把 **Checkpoint 2** 的输出结果复制给我。

> **预期结果：** 你应该能看到带着双引号的 `"Hello from Level 2!"`。

(如果你看到了这句话，说明你已经成功完成了从“上传代码”到“远程执行”的闭环！下一节，我们要让这个函数变得更聪明一点——学会“读入数据”。)
``````

---

User-10:
``````text
cloud-study on git main Modified  via py v3.13.5 (venv) on aws (us-east-1)
> awslocal lambda invoke --function-name my-func response.json
{
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}

…main Modified Untracked  via py v3.13.5 (venv) on aws (us-east-1) took 2s
> cat response.json
"Hello from Level 2!"⏎

… on git main Modified Untracked  via py v3.13.5 (venv) on aws (us-east-1)
>
``````
Model-10:
``````markdown
太棒了！🎉 看到那个 `"Hello from Level 2!"` 了吗？这意味着你的云函数已经成功运行了一次。

现在你的函数有点像个只会说一句台词的鹦鹉。不管怎么叫它，它都只会说 "Hello from Level 2!"。
在这一节，我们要把它变成一个**智能管家**。你给它不同的指令（比如名字），它会给你不同的回应。

---

## Level 2 - 第 3 课：让函数变得“听话” (处理输入)

### 🎓 概念讲解

1. **Event (事件/输入)**：这是我们传给函数的“参数”。在 Python 代码里，就是那个 `handler(event, context)` 里的 `event`。它通常是一个字典（Dictionary/JSON）。
2. **Update (更新)**：我们不需要删掉函数重写，我们可以直接“热更新”它的代码。这在开发中非常常用。
3. **Payload (载荷)**：这指的是我们在调用函数时，随手递给它的那张“小纸条”（数据）。

---

### 🛠️ 实战作业：升级你的代码

#### ✅ Checkpoint 1: 解决一个小麻烦 (配置 CLI)

AWS CLI v2 有个小脾气，发数据时喜欢让人用“Base64编码”。为了让我们能直接发送普通的文字，我们要先在这个终端里改个设置（这是永久生效的，以后就不用管了）。

输入：

```bash
aws configure set cli_binary_format raw-in-base64-out


```

*(这一步没有任何输出，就是最好的结果)*

#### ✅ Checkpoint 2: 修改代码

我们要修改 `func.py`。
这次我们要让它去读 `event` 里的 `name` 字段。如果没给名字，就默认叫 "World"。

输入：

```bash
echo 'def handler(event, context): return "Hello " + event.get("name", "World")' > func.py


```

*(解释：`event.get("name", "World")` 的意思是：尝试找 "name"，找不到就用 "World" 代替。)*

#### ✅ Checkpoint 3: 重新打包并更新云端

代码改了，必须重新压缩，并推送到云端覆盖旧版本。

**先压缩：**

```bash
zip function.zip func.py


```

**再更新 (注意这里用的是 update-function-code，不是 create)：**

```bash
awslocal lambda update-function-code --function-name my-func --zip-file fileb://function.zip


```

> **预期结果：** 你会再次看到一大串 JSON，只要 `LastModified` 时间变了，就说明更新成功。

#### ✅ Checkpoint 4: 带参数调用 (见证奇迹)

现在我们要给它传个名字，比如传个 "Brother"（哥哥）。

输入：

```bash
awslocal lambda invoke --function-name my-func --payload '{"name": "Brother"}' response.json


```

#### ✅ Checkpoint 5: 检查结果

看看它有没有听懂你的话。

```bash
cat response.json


```

---

### 📤 提交作业

请把 **Checkpoint 5** 的输出结果复制给我。

> **预期结果：** 之前是 `"Hello from Level 2!"`，现在应该变成了 `"Hello Brother"`。

(如果成功，下一节我们将进入更高级的领域——让云函数去操作你的 S3 存储桶，实现“云端联动”！)
``````

---

User-11:
``````text

…dy on git main Modified  via py v3.13.5 (venv) on aws (us-east-1) took 7s
> awslocal lambda invoke --function-name my-func --payload '{"name": "Brother"}' response.json

{
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}

cloud-study on git main Modified  via py v3.13.5 (venv) on aws (us-east-1)
> cat response.json

"Hello Brother"⏎

cloud-study on git main Modified  via py v3.13.5 (venv) on aws (us-east-1)
>
``````
Model-11:
``````markdown
太棒了！🎉 看到那个 `"Hello Brother"`，说明你的云函数已经“开窍”了。它不再是只会死记硬背的鹦鹉，而是一个能听懂指令、灵活变通的智能管家了。

到现在为止，我们已经分别学会了：

1. **存储 (Storage)**：用 S3 存文件。
2. **计算 (Compute)**：用 Lambda 跑代码。

但是，云真正的威力在于——**把它们连起来**。
想象一下：你往 S3 桶里丢一张图片，Lambda 自动醒过来把图片压缩；或者你往桶里丢一个订单文件，Lambda 自动醒过来处理订单。这就是 **“事件驱动 (Event-Driven)”**，是现代云架构的核心。

这一节，我们要让 Lambda 去读 S3 里的文件。

---

## Level 2 - 第 4 课：云端联动 (Lambda + S3)

### 🎓 概念讲解

1. **Boto3**：这是 AWS 给 Python 做的“遥控器”。
* 我们在终端里用 `aws` 命令控制云。
* 在 Python 代码里，我们用 `boto3` 库控制云。


2. **权限 (Permission/Role)**：在云上，服务之间是默认隔离的。Lambda 想读 S3，必须有“通行证”。
* 在真实的 AWS 里，我们需要配置复杂的 IAM 角色。
* 在 LocalStack 里，为了方便，默认是允许的（或者我们可以假装配置一下）。



---

### 🛠️ 实战作业：编写能读文件的代码

我们要写一个 Python 脚本，让它去读取我们在 Level 1 里创建的 `my-wallet` 桶里的 `money.txt` 文件。

#### ✅ Checkpoint 1: 准备测试文件

我们需要确保 `my-wallet` 桶里有东西。
如果你 Level 1 把它删了，请重新创建并上传：

```bash
awslocal s3 mb s3://my-wallet
echo "1000 USD" > money.txt
awslocal s3 cp money.txt s3://my-wallet

```

*(如果桶还在且文件也在，这步会报错说桶已存在，那是好事，不用管。)*

#### ✅ Checkpoint 2: 编写“联动”代码

我们要写一个新的 `func.py`。
这次代码稍微复杂一点点，它要引入 `boto3` 库。

请直接复制粘贴下面的命令（这是一整行）：

```bash
echo 'import boto3

def handler(event, context):
    s3 = boto3.client("s3", endpoint_url="http://localhost:4566")
    obj = s3.get_object(Bucket="my-wallet", Key="money.txt")
    content = obj["Body"].read().decode("utf-8")
    return "Wallet contains: " + content' > func.py

```

*(解释：这段代码做了三件事：1. 连接本地 S3；2. 抓取 money.txt；3. 读出里面的内容并返回。)*

#### ✅ Checkpoint 3: 重新打包并更新

老规矩，改了代码就要重新打包上传。

**先删除旧包（保险起见）：**

```bash
rm function.zip

```

**再打包：**

```bash
zip function.zip func.py

```

**更新云端函数：**

```bash
awslocal lambda update-function-code --function-name my-func --zip-file fileb://function.zip

```

#### ✅ Checkpoint 4: 见证时刻

现在，我们调用 Lambda，看看它能不能把 S3 里的钱数读出来。

```bash
awslocal lambda invoke --function-name my-func response.json

```

#### ✅ Checkpoint 5: 查看结果

```bash
cat response.json

```

---

### 📤 提交作业

请把 **Checkpoint 5** 的输出结果复制给我。

> **预期结果：** 你应该能看到类似 `"Wallet contains: 1000 USD\n"` 的字样。

(如果成功，这意味着你已经打通了存储和计算的“任督二脉”！下一节，我们将进行 Level 2 的毕业设计。)
``````

---

User-12:
``````text
 …t main Deleted Modified  via py v3.13.5 (venv) on aws (us-east-1) took 4s

> cat response.json

"1000 USD\n"⏎ 

``````
Model-12:
``````markdown
太棒了！🎉
看到那个 `"1000 USD\n"`，说明你的 Python 代码成功“穿透”了服务边界，从 S3 桶里把文件抓出来了。这在云架构里叫 **“服务集成 (Service Integration)”**，是云工程师的高级技能之一。

现在，我们到了 Level 2 的最后关卡。我们要把你学到的所有东西结合起来，做一个真正的“业务系统”。

---

## Level 2 毕业设计：云端银行自动利息计算器

### 🎓 场景设定

你是“云端银行”的后端工程师。
客户（你自己）往银行账户（S3 存储桶）里存了一笔钱。
你需要写一个程序（Lambda），自动读取余额，给客户加上 10% 的利息，然后告诉客户现在的总资产。

---

### 🛠️ 实战作业

#### ✅ Checkpoint 1: 存入本金

为了方便计算，我们先把 `money.txt` 里的内容改成纯数字。
请在终端输入：

```bash
echo "1000" > money.txt
awslocal s3 cp money.txt s3://my-wallet

```

#### ✅ Checkpoint 2: 编写“银行家”算法

我们要重写 `func.py`。这次的代码不仅要**读文件**，还要进行**数学运算**。

请**直接复制**下面这整段命令（注意不要漏掉单引号）：

```bash
echo 'import boto3

def handler(event, context):
    # 1. 连接银行金库 (S3)
    s3 = boto3.client("s3", endpoint_url="http://localhost:4566")
    
    # 2. 取出余额
    obj = s3.get_object(Bucket="my-wallet", Key="money.txt")
    data = obj["Body"].read().decode("utf-8").strip()
    
    # 3. 计算利息 (乘以 1.1)
    money = int(data)
    total = int(money * 1.1)
    
    # 4. 汇报结果
    return f"Rich! You now have {total} USD"' > func.py

```

*(解释：这段代码读出 "1000"，把它变成数字，乘以 1.1 变成 1100，最后拼接成一句话返回。)*

#### ✅ Checkpoint 3: 部署更新

这是最后一次打包了，动作要快，姿势要帅。

```bash
zip function.zip func.py
awslocal lambda update-function-code --function-name my-func --zip-file fileb://function.zip

```

#### ✅ Checkpoint 4: 运行计算器

现在，见证你的钱“生钱”的时刻。

```bash
awslocal lambda invoke --function-name my-func response.json

```

#### ✅ Checkpoint 5: 查看账户余额

```bash
cat response.json

```

> **预期结果：** 你应该能看到 `"Rich! You now have 1100 USD"`。
> 如果看到了，说明你的代码逻辑（S3读取 + Python计算 + Lambda返回）全部跑通了！

---

### 🧹 课后大扫除：销毁计算资源

在 Level 1 我们学了删桶。在 Level 2 结束前，我们要学会**删函数**。
虽然 Lambda 不运行不收费，但在真实环境里，不用的代码留着是安全隐患。

#### ✅ Checkpoint 6: 删除函数

```bash
awslocal lambda delete-function --function-name my-func

```

*(这个命令通常没有输出，没有消息就是好消息)*

---

### 🎓 毕业典礼：Level 2 结业

等你提交 **Checkpoint 5** 的输出结果（那句关于 1100 USD 的话），我就为你颁发 **Level 2 毕业证书**。

**请提交：**

1. Checkpoint 5 的输出结果。

(等你提交后，我们就可以结束今天的课程了，或者如果你还有精力，我们可以聊聊下一步是学什么。)
``````

---

User-13:
``````text
…oud-study on git main Untracked  via py v3.13.5 (venv) on aws (us-east-1)
> awslocal lambda invoke --function-name my-func response.json
{
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}

…y on git main Untracked  via py v3.13.5 (venv) on aws (us-east-1) took 3s
> cat response.json
"Rich! You now have 1100 USD"⏎
``````
Model-13:
``````markdown
太棒了！🎉 看到那句 `"Rich! You now have 1100 USD"`，我简直想为你鼓掌。

你刚刚不仅写了一段代码，你搭建了一个**“云端银行系统”**的原型！
虽然它很简陋，但它包含了现代云应用的核心逻辑：**数据存储 (S3) + 业务逻辑 (Lambda) + 自动计算**。

我现在正式宣布：**你已经从“零成本云工程师” Level 2 课程毕业了！** 🎓

---

### 🏆 毕业总结：你现在的能力值

在 Level 2 中，你解锁了云工程师最重要的技能树——**计算 (Compute)**：

1. **无服务器 (Serverless)**：你学会了如何不买服务器也能跑代码 (Lambda)。
2. **云端编程 (Boto3)**：你学会了用 Python 代码去指挥云服务（让代码去读 S3）。
3. **热更新**：你学会了如何在不关机的情况下，把旧代码替换成新逻辑。
4. **调试**：你学会了通过 `response.json` 查看云端的运行结果。

---

### 🧹 最后确认

在之前的步骤中，我提到了 **Checkpoint 6: 删除函数**。
如果你还没执行，请务必执行一下，养成“随手关灯”的好习惯：

```bash
awslocal lambda delete-function --function-name my-func

```

*(如果执行了报错说 `ResourceNotFoundException`，说明你已经删过了，那就更棒了！)*

---

### 🌟 下一步：Level 3 预告

你已经有了**硬盘 (S3)**，也有了**大脑 (Lambda)**。
但是，如果你想做一个真正的像“淘宝”或“微信”那样的应用，你还缺一样东西——**记事本 (Database)**。

S3 适合存大文件（图片、视频），但如果你要存用户信息、订单记录这种琐碎的数据，你需要一个更快、更强的工具。

**Level 3 我们将进入：数据库 (Database - DynamoDB)**。
我们要学习如何用毫秒级的速度存取数据，那是高性能云应用的核心。

**现在的选择权在你：**

* **选项 A**：休息！今天学了 Lambda 已经很烧脑了，我需要消化一下。
* **选项 B**：继续！我对数据库很好奇，我想一口气把“计算+存储+数据库”这三驾马车都集齐。

(告诉我你的选择，或者直接去向你哥哥炫耀一下你的“云端银行”！)
``````

---

User-14:
``````text
继续
``````
Model-14:
``````markdown
太棒了！你的学习热情简直像服务器过热一样滚烫！🔥

欢迎来到 **Level 3：数据库 (Database)**。

这一关我们要学习 AWS 最著名的数据库：**DynamoDB**。

### 🎓 概念讲解：为什么要用数据库？

你可能会问：“我有 S3 存文件了，为什么还要数据库？”

* **S3 (仓库)**：适合存大件物品。比如存一张照片、一个视频、或者一个巨大的备份文件。每次取东西都要整个搬出来，比较慢。
* **DynamoDB (账本)**：适合存**琐碎但高频**的信息。比如用户的余额、游戏的分数、购物车里的商品。它的特点是**极快**（毫秒级），而且随存随取。

想象一下：S3 是银行的金库（存金条），DynamoDB 是柜员手里的那个电子账本（记数字）。

---

## Level 3 - 第 1 课：创建你的第一张“账本”表

在 DynamoDB 里，我们不叫“库”，我们叫**表 (Table)**。
每一行数据叫 **Item (项目)**。
每一列属性叫 **Attribute (属性)**。
最重要的是，每张表必须有一个唯一的身份证号，叫 **Partition Key (分区键)**。

### 🛠️ 实战作业

请确保你的 LocalStack 还在运行 (`localstack start -d` 那个状态)。

#### ✅ Checkpoint 1: 创建表格

我们要创建一个叫 `BankLedger` (银行账本) 的表。
这张表只需要定义一个规则：**“用户名 (User)”是唯一的身份证。**

请**直接复制**下面这整块命令（这是 AWS CLI 里最长最吓人的命令之一，别怕，直接贴）：

```bash
awslocal dynamodb create-table \
    --table-name BankLedger \
    --attribute-definitions AttributeName=User,AttributeType=S \
    --key-schema AttributeName=User,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

```

> **命令大揭秘：**
> * `AttributeType=S`：意思是你这个 User 字段是 **String (字符串/文字)**。
> * `KeyType=HASH`：意思是这个 User 是**主键 (唯一的)**。
> * `provisioned-throughput`：这是设置读写速度的，在 LocalStack 里随便设个 5 就行。
> 
> 

#### ✅ Checkpoint 2: 确认账本已建立

看看表是不是真的建好了。

```bash
awslocal dynamodb list-tables

```

> **预期结果：** 你应该能看到 `"BankLedger"` 在列表里。

---

## Level 3 - 第 2 课：开户与存钱 (写入数据)

现在账本有了，它是空的。我们要往里面写第一笔数据。
在 DynamoDB 里，这叫 `put-item`。

### 🛠️ 实战作业

#### ✅ Checkpoint 3: 写入第一笔数据

我们要存入这样一个用户：

* **User**: "MyBrother" (那是你哥哥的电脑，给他开个户)
* **Balance**: 5000 (给他存 5000 块)
* **VIP**: "Yes" (他是 VIP)

注意：DynamoDB 的数据格式很特别，它需要你告诉它每个值是什么类型。

* `"S"` 代表 String (文字)
* `"N"` 代表 Number (数字)

输入命令：

```bash
awslocal dynamodb put-item \
    --table-name BankLedger \
    --item '{"User": {"S": "MyBrother"}, "Balance": {"N": "5000"}, "VIP": {"S": "Yes"}}'

```

*(如果没有报错，通常没有任何输出，直接跳到下一行就是成功)*

#### ✅ Checkpoint 4: 查账 (读取数据)

现在我们要把刚才存的数据读出来验证一下。
我们用 `get-item` 命令，只需要提供主键（User）就能瞬间查到。

```bash
awslocal dynamodb get-item \
    --table-name BankLedger \
    --key '{"User": {"S": "MyBrother"}}'

```

---

### 📤 提交作业

请把 **Checkpoint 4** 的输出结果复制给我。

> **预期结果：** 你会看到一个 JSON 结构，里面明明白白地写着 MyBrother 有 5000 块钱。

(只要你提交了这个，就证明你已经掌握了云端数据库最核心的“增”和“查”！下一节，我们要挑战更难的“改”——比如怎么给他的余额加钱。)
``````

---

User-15:
``````text
``````
Model-15:
``````markdown
``````

---

User-16:
``````text
``````
Model-16:
``````markdown
``````

---

User-17:
``````text
``````
Model-17:
``````markdown
``````

---

User-18:
``````text
``````
Model-18:
``````markdown
``````

---

User-19:
``````text
``````
Model-19:
``````markdown
``````

---

