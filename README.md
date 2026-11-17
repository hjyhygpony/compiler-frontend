# 编译原理实验 1~3 合并系统

本项目把“词法分析器、语法分析器、语法制导三地址代码生成器”合并为一个完整的小型编译前端系统。

系统流程：

```text
input.txt
  -> Lexer.scan() 词法分析，输出 output/tokens.txt
  -> Parser 递归下降语法分析，输出 output/parse.txt
  -> CodeGenerator 三地址代码生成，输出 output/tac.txt
  -> 错误信息输出 output/errors.txt
```

## 运行方式

### 1. 命令行运行

```bash
python main.py input.txt -o output

# 只演示实验一词法分析
python main.py tests/inputs/01_lexer.txt -o output --tokens-only
```

Windows 可以直接双击：

```text
run_cli.bat
```

### 2. 图形界面运行

无需额外依赖的 Tkinter GUI：

```bash
python gui_tkinter.py
```

也可双击：

```text
run_gui_tkinter.bat
```

可选 PyQt6 GUI：

```bash
pip install PyQt6
python gui_pyqt6.py
```

### 3. 生成 exe

指导书要求可运行程序包时，可以在 Windows 下运行：

```text
build_exe.bat
```

生成 `dist/compiler-frontend.exe` 和 `dist/compiler-frontend-gui.exe`。

## 支持的语言结构

赋值语句：

```text
x = a + b;
```

if 语句：

```text
if a > b then x = 1;
```

if-else 语句：

```text
if a > b then x = 1 else x = 2;
```

while 语句：

```text
while a < b do a = a + 1;
```

复合语句：

```text
{
    x = 1;
    y = 2;
};
```

## 项目结构

```text
compiler_merged_system/
├─ main.py                  命令行入口
├─ gui_tkinter.py            标准库 GUI，演示推荐
├─ gui_pyqt6.py              可选 PyQt6 GUI
├─ input.txt                 默认输入文件
├─ output/                   编译输出目录
├─ src/
│  ├─ token_defs.py          Token 类型、Token 结构
│  ├─ lexer.py               词法分析器 Lexer.scan()
│  ├─ parser.py              递归下降语法分析器 Parser
│  ├─ codegen.py             三地址代码生成器
│  └─ pipeline.py            完整编译流程封装
├─ tests/
│  ├─ inputs/                典型输入
│  └─ outputs/               已生成的典型输出
└─ docs/                     合并要求、分工、PPT/报告提纲
```

## 输出文件

- `tokens.txt`：Token 序列，格式为 `TOKEN 属性`。
- `parse.txt`：递归下降分析过程和接受/拒绝结果。
- `tac.txt`：三地址代码序列。
- `errors.txt`：词法/语法错误定位；无错误时输出 `No errors.`。

## 范围说明

本系统不是完整 C 编译器，而是“简单语言 -> 三地址代码”的编译前端。演示时重点说明三个实验如何通过统一 Token、统一接口和统一输出文件合并成完整系统。

## 2026-06-05 更新：增强 parse.txt 展示

`parse.txt` 已改为两栏输出：

```txt
产生式                    | 当前源程序中的真实含义 / 属性值
C -> E relop E             | C => (a3 + 15) > 10; 真->L1, 假->L2
F -> int16                 | F => 10，源程序写作 0xa
S -> id = E                | S => c = b * c + d
```

左栏仍然保留实验要求中的产生式推导；右栏用于验收演示，说明当前的 `S / C / E / T / F` 在源程序中实际代表哪一段内容，以及表达式生成三地址代码时对应的 `place`。

## 拓展版说明

本拓展版保留 `parse.txt` 两栏解释与 `parse_tree.txt` 缩进语法树，并新增：REAL10/REAL8/REAL16、拓展标识符、symbols.txt、constants.txt、常量除零语义检查。详见 `docs/拓展功能说明.md`。

