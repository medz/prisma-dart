# ORM v6 执行计划（6 周）

## 1. 基线（2026-03-05）
- `pub/orm` 全量测试：136 项通过。
- 现状强项：runtime 校验链、插件机制、include/嵌套写基础能力。
- 现状缺口：契约工件信息不足、fluent API 语义未完全收敛、跨层职责仍有耦合点。

## 2. 6 周路线图
| 周次 | 目标 | 产品 | 开发1（Core/Runtime） | 开发2（Repository/Target） | 测试 | 交付物 |
|---|---|---|---|---|---|---|
| 第1周 | 契约工件闭环 | 冻结 contract 字段/兼容策略 | 实现 contract 校验与加载 API | 扩展 schema->contract（relations/capabilities） | round-trip 与反例测试 | 契约规范 v1.1、加载器、回归桶 |
| 第2周 | Stream-first 执行面 | 定义兼容期 API 策略 | 增加流式执行主接口与桥接 | 将查询流入口统一到流式执行 | 大结果流式与插件顺序压测 | 新执行接口与迁移说明 |
| 第3周 | 生命周期与能力一致性 | 冻结 capability 决策表 | runtime 启动期能力校验 | target 错误改为结构化信封 | 生命周期负例与能力负例 | 能力校验矩阵、错误信封统一 |
| 第4周 | Include 计划化 | 定义 include 策略矩阵 | 增加 include 遥测指标 | 抽取 IncludeExecutionPlan | 策略等价性与深度边界回归 | include 计划器与预算基线 |
| 第5周 | 嵌套写显式编排 | 定义状态机与失败语义 | 事务边界插件事件 | 抽取 nested orchestration 模块 | 原子性/回滚/幂等回归 | 显式编排器与回退策略 |
| 第6周 | 集成收敛 | 范围收口与验收 | 门禁自动化与稳定性修复 | 门禁自动化与稳定性修复 | 全量回归与波动治理 | 发布候选、验收报告、迁移文档 |

## 3. 阶段 Gate
| 阶段 | 阻断门禁 | 阈值门禁 |
|---|---|---|
| Phase 1 | 契约与 plan 基础契约测试全绿 | flake rate <= 1% |
| Phase 2 | verify mode 与生命周期矩阵全绿 | runtime/client 关键失败路径覆盖率 >= 85% |
| Phase 3 | lowering/codec/marker 语义测试全绿 | lowering p95 < 2ms |
| Phase 4 | fluent 验收矩阵全绿（FA-01..FA-12） | include 查询放大系数受控 |
| Phase 5 | 嵌套写原子性与回滚矩阵全绿 | P0/P1 缺陷为 0 |

## 4. Fluent 验收矩阵（摘录）
- `FA-01` 链式不可变：任意变换后旧状态不变。
- `FA-02` where 合并/覆盖语义稳定。
- `FA-03` orderBy append/replace 语义稳定。
- `FA-04` select/distinct 追加语义稳定。
- `FA-05` include 合并与关系错误码稳定。
- `FA-06` skip/take 边界错误码稳定。
- `FA-07` `unbounded()` 只影响 `take`。
- `FA-08` 终止操作到 action 映射唯一。
- `FA-09` `stream()` 与 `list()` 一致性。
- `FA-10` include 单查/多查策略结果等价。
- `FA-11` include 深度边界行为稳定。
- `FA-12` 模型别名映射稳定。

## 5. 必增测试清单
契约测试：
- `contract_hash_is_stable_under_model_and_field_permutation`
- `runtime_rejects_plan_target_mismatch`
- `runtime_rejects_plan_storage_hash_mismatch`
- `runtime_rejects_plan_profile_hash_mismatch`
- `contract_relation_definition_validation_matrix`
- `generated_client_public_api_snapshot_compat`
- `runtime_error_taxonomy_snapshot`

回归测试：
- `plugin_onRow_called_per_row_and_in_plugin_order`
- `multi_plugin_hook_order_before_onRow_after_onError`
- `fluent_where_merge_replace_matrix`
- `fluent_select_distinct_append_matrix`
- `fluent_include_merge_replace_matrix`
- `verify_on_first_use_resets_after_reconnect`
- `adapter_driver_error_does_not_corrupt_connection_state`
- `nested_mutation_two_level_atomic_rollback`

## 6. 度量目标
| 维度 | 指标 | 目标 |
|---|---|---|
| 稳定性 | 测试通过率 | 100% |
| 稳定性 | flake rate | <= 0.5% |
| 稳定性 | 阻断缺陷数 | P0/P1 = 0 |
| 性能 | 全量测试时长 | <= 60s |
| 性能 | runtime 执行开销 p95 | 插件额外开销 <= 15% |
| DX | 首次成功查询时间 | <= 15 分钟 |
| DX | 生成产物可用率 | 100% |

## 7. 本周可执行任务（立即开工）
1. 产品：冻结 `where/include/orderBy` 语义文档与命名收敛规则。
2. 开发1：补 runtime contract 加载与结构化错误码映射。
3. 开发2：补 schema relation 到 contract emitter 的完整链路。
4. 测试：建立 `generated_client_public_api_snapshot_compat` 与 fluent 验收矩阵骨架。

