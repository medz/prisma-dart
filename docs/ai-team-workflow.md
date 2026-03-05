# AI 团队协作规范（ORM）

## 1. 目标
- 以多 agents 并行协作推进 ORM 开发。
- 角色固定为：产品、测试、开发1（Core/Runtime）、开发2（Repository/Target）。
- 严格遵守 contract-first、plan 不可变、核心薄/目标层厚、显式编排原则。

## 2. 角色定义

### 产品（Product）
职责：
- 定义阶段目标、范围与非范围（Phase 1-5）。
- 输出可验证需求：contract/plan 规则、能力矩阵、错误语义、验收标准。
- 维护 DoR/DoD 与跨角色交接单。
- 决策冲突：规则缺失、实现偏差、能力限制三类问题的归因。

输入：业务场景、架构原则、历史缺陷与反馈。
输出：需求包、能力矩阵、验收清单、决策记录。

边界：
- 不直接实现 runtime/repository/target 代码。
- 不绕过架构边界要求“隐式 fallback”。

### 测试（QA/Test）
职责：
- 维护分层测试：单元、集成、契约一致性、回归。
- 校验 target/hash/profile 规则与插件流水线顺序。
- 对失败用例进行分级（P0/P1/P2/P3）并给出最小复现。
- 维护门禁：阻断项不允许合并。

输入：产品验收包、开发变更说明。
输出：测试结果单（通过项/失败项/阻断级别/复现步骤/建议修复）。

边界：
- 不修改产品边界定义。
- 不引入跨层实现逻辑，只定义验证与质量结论。

### 开发1（Core/Runtime）
职责：
- 负责 shared/core 与 runtime-core 的类型、校验、生命周期、插件编排与遥测。
- 落实 verify mode（startup/on-first-use/always）与错误封装稳定性。
- 提供 stream-first 执行接口，不引入隐藏 fallback。

负责模块：
- `shared/core`、`runtime-core`。

不负责模块：
- `repository client`、`targets`、解析器/语言层。

### 开发2（Repository/Target）
职责：
- 负责 repository collection API、include 策略、显式事务编排。
- 负责 target adapter/driver 的实现分层与能力映射。
- 落实 one logical query -> one lane statement。

负责模块：
- `repository client`、`targets`。

不负责模块：
- core 类型定义与 runtime-core 生命周期编排。

## 3. 交接协议（固定顺序）
1. 产品 -> 开发1/开发2/测试：下发需求包（含能力矩阵、错误语义、验收标准）。
2. 开发1 <-> 开发2：只通过公开类型/SPI 对接，不越层调用内部实现。
3. 开发1/开发2 -> 测试：提交变更说明（影响面、关键场景、已覆盖测试）。
4. 测试 -> 全员：回传结构化测试结论与阻断级别。
5. 产品 -> 全员：确认是否进入下一阶段或回滚到当前阶段修复。

## 4. 并行开发节奏（一个迭代）
1. 产品拆单：
- 产出一个最小闭环任务（可独立验证）。
- 任务必须满足 DoR 后进入开发。

2. 双开发并行：
- 开发1实现核心能力或边界约束。
- 开发2实现仓储/目标层能力。
- 跨层接口变更先评审，再编码。

3. 测试门禁：
- 先跑改动相关测试，再跑回归桶。
- 若出现 P0/P1 阻断，任务回到开发修复。

4. 完成判定：
- 满足 DoD，进入下一迭代。

## 5. DoR / DoD

DoR（任务可开工）：
- 范围/非范围明确。
- contract/plan 校验规则明确。
- 验收标准可执行且可测。
- 角色交接对象明确。

DoD（任务完成）：
- 代码、测试、文档三者闭环。
- 不违反 contract-first、plan 不可变、显式编排原则。
- 回归通过，风险与取舍已记录。

## 6. Commit 规则（阶段结果即提交）
- 有“可独立验证的最小闭环”就提交，不攒大包。
- 一次提交只做一件事：行为变更 + 对应测试（必要时含最小文档）。
- 接口变更与实现变更尽量拆开提交。
- 缺陷修复提交必须包含回归测试。
- 阻断缺陷修复优先于新功能提交。

推荐提交格式：
- `feat(scope): summary`
- `fix(scope): summary`
- `test(scope): summary`
- `docs(scope): summary`

建议 scope：
- `runtime-core`
- `shared-core`
- `repository`
- `target`
- `qa`
- `workflow`

## 7. 迭代内最小检查清单
- 产品：需求包、验收标准、能力矩阵是否齐全。
- 开发1：核心边界是否被污染、校验链是否完整。
- 开发2：是否出现隐藏 fallback、是否保持单 lane statement。
- 测试：是否覆盖正反例、是否有新增回归用例。
