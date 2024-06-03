## innodb索引实现
## B-Tree的特点
多叉搜索树，一个节点可以有存储多个元素
### B+-Tree的特点
1. 磁盘IO优化 每个节点通常是一个磁盘页，一次io可以读取一整个节点，减少io次数。一页是16KB。
2. 平衡 叶子结点高度相同，保证性能稳定
3. 顺序访问 叶子节点按顺序排列，使得范围查询更高效
4. 相比B-Tree有哪些不同
   1. 叶子节点冗余存储了非叶子节点的元素
   2. 叶子节点之间有双向指针连接
### 聚簇(cu4)索引
主键索引，叶子节点包含完成的行数据
### 辅助索引
普通索引，叶子节点只包含主键值，需要再查询一次聚簇索引才能得到完整行数据。
如果只需要查询辅助索引包含的字段或主键则不需要多查一次聚簇索引，效率更高。
### 覆盖索引
索引(a,b,c),select id, a, b, c from t1;时可以走覆盖索引，无需回表。Explain的结果中Extra字段有Using index代表走覆盖索引。
### 选择B+Tree的原因
### 其他
1. 3层B+Tree可以存储2000多万数据（假设一行数据1KB)
2. 有时全表扫描比走索引快。比如获取全部数据时，全表扫描少了一次回表操作。需要考虑具体数据。

## 数据库锁
### 分类
1. 按粒度：行锁，表锁，间隙锁
2. 读锁（共享锁），写锁（排他锁）。注意：不影响快照读（因为不需要加锁），只影响当前读。
3. 乐观锁（update where version=x），悲观锁（行锁，表锁）
4. 在事务的隔离级别中，用锁来解决幻读。
5. 当前读可能导致锁竞争和并发性能问题，应该尽量避免当前读也就是数据库锁，比如防超卖中使用乐观锁。
## 事务
### ACID如何实现
1. A 原子性: 根据 undo log 回滚
2. C 一致性: 系统层面由其他三种特性实现，业务层面由业务代码实现
3. I 隔离性: MVCC
4. D 持久性: 宕机后根据redo log恢复，也会根据undolog回滚未提交的事务
### innodb读已提交和可重复读隔离级别下当前读和快照读的幻读问题对比

| 隔离级别\读类型 | 快照读                | 当前读                                |
|----------|--------------------|------------------------------------|
| 读已提交     | 有幻读，每次select都是最新快照 | 有幻读，只有行锁，没有间隙锁，其他事务会在查询范围内插入数据引起幻读 |
| 可重复读     | 通过MVCC解决部分幻读       | 通过行锁和间隙锁解决部分幻读                     |
为什么是部分解决呢？看一下两个case:
1. 事务A快照读，事务B插入一条数据，事务A再当前读是可以读到新数据的。解决方法是都使用当前读。
2. 事务A快照读，事务B插入一条数据，事务A执行Update操作修改了新数据，事务A再快照读，可以读到新数据。因为新数据的trx_id已经被修改为当前事务id，可以被MVCC读到。解决办法同样是使用当前读。
### 三种Log
1. undo log：innodb层
2. redo log：innodb层
3. binlog: MySQL层
4. binlog和redolog如何保证一致：
   1. 先存储redolog，再存储binlog，事务提交后在redolog中写入commit记录
### MVCC 多版本并发控制
1. MVCC只在读已提交和可重复读两种隔离级别中工作。
2. 聚簇索引中有两个隐藏列：
   1. trx_id 修改的事务id
   2. roll_pointer 指针指向上一个版本的记录，形成版本链
3. 快照读：
   1. Read View 中维护了未提交的事务idlist
   2. 读取最新的一行数据，对应的事务id比list中的所有id都小，说明已提交，直接读取
   3. 如果比list都大，或者在list中间，说明未提交，通过roll_point找上一个版本数据，直至找到已提交的数据再读取
   4. 读已提交和可重复读的区别：
      1. 可重复读在事务开始时生成一次read view(通过MVCC解决了不可重复度和幻读)
      2. 读已提交在每次select语句都生成一次read view
4. 当前读: 在可重复读隔离级别，innodb会用间隙锁来解决幻读
   1. select for update 语句不近会加上已有行的行锁，也会加上间隙锁，防止其他事务插入数据。
   2. 如果间隙过大，可能会有没覆盖的地方，还是有幻读问题

## 慢查询优化
1. 检查是否走索引，优化sql和索引
2. 检查走的索引是否是最优的索引
3. 检查select字段是否必须
4. 检查数据量是否过大，需要分表分库
5. 检查数据库实例资源占用，是否需要扩容
6. 并发量太高，考虑读写分离