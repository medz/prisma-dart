# ORM v6 实施蓝图（Dart 化）

## 1. 目标
- 在 v6 未发布阶段完成破坏式收敛，建立统一 fluent API 与 contract-first 运行时边界。
- 所有查询入口统一编译为不可变 Plan。
- 执行层保持单 Plan 单语句；多语句编排仅允许在 repository 层显式表达。

## 2. 范围与非范围
范围：
- 契约工件完整化：relations、capabilities、target、hash 校验链。
- fluent 查询主路径：`where / select / include / orderBy / take / skip / all / stream / firstOrNull / oneOrNull / toPlan`。
- 运行时校验与插件管线稳定化：`beforeExecute -> onRow -> afterExecute -> onError`。
- repository 显式编排：nested mutation、能力差异回退、include 执行策略。

非范围：
- parser/source-provider 新系统。
- 运行时内隐式多语句回退。
- 过度重载的入口矩阵与动态扩展注册。

## 3. 设计原则
- Contract-first：runtime 只执行已验证契约工件。
- Immutable plan：链式查询每一步返回新状态对象。
- Thin core / fat targets：核心负责校验与生命周期；目标层负责方言与驱动细节。
- Explicit behavior：跨语句流程必须显式；不在 lane 中隐藏编排。
- Capability-driven：能力差异由契约声明并驱动确定性策略。

## 4. 分层边界
| 层 | 负责 | 不负责 |
|---|---|---|
| shared/core | contract/plan/error/capability 模型与校验 | include 策略、事务编排 |
| runtime-core | marker 校验、插件管线、连接/事务生命周期、telemetry | 业务编排与回退策略 |
| runtime-sql-family | lowering、codec、marker reader | 多语句工作流 |
| repository-client | include 策略、nested mutation、upsert fallback | 绕过 runtime 校验 |
| targets | adapter/driver 实现与能力声明 | 核心错误语义定义 |

## 5. Fluent API（Dart 形态）
- 使用闭包 Builder + 强类型对象，不以 `Map<String, Object?>` 作为对外主入口。
- 默认不可变链式，终止符明确。
- 示例：

```dart
final users = await db.user
    .where((w) => w.email.equals('a@x.com') & w.active.equals(true))
    .orderBy((o) => [o.createdAt.desc()])
    .take(20)
    .select((s) => s.pick((f) => [f.id, f.email]))
    .all();
```

```dart
final result = await db.order
    .where((w) => w.userId.equals(currentUserId))
    .include((i) => i.items((q) => q.take(10)))
    .firstOrNull();
```

## 6. P0 / P1 能力清单
P0：
- 契约工件与 hash 校验闭环。
- 基础 fluent 查询与关系过滤。
- 基础写能力：`create / update / delete / upsert`，危险操作默认强约束。
- stream-first 执行接口。
- 稳定错误信封与能力门禁。
- 插件管线与执行遥测。

P1：
- `cursor / distinct / groupBy / having / aggregate`。
- include 多策略优化与组合能力。
- 扩展 API（自定义集合能力）与互操作层。

## 7. 迁移策略（v6 未发布）
1. 收敛入口命名与模型访问规范，只保留一条主路径。
2. 先冻结语义，再迁移实现：拆模块但保持行为不变。
3. 将多语句逻辑迁移到 repository，并为旧入口提供短期兼容转发。
4. 强化测试门禁后再移除兼容入口。

## 8. 多角色职责
| 角色 | 主要职责 | 交付物 |
|---|---|---|
| 产品 | 需求边界、验收标准、能力矩阵 | PRD、验收清单、决策记录 |
| 测试 | 分层测试与回归门禁 | 测试计划、Gate 报告、缺陷分级 |
| 开发1 | shared/core + runtime-core | 核心校验链、生命周期、插件执行保障 |
| 开发2 | repository + targets | 策略编排、目标实现、能力映射 |
