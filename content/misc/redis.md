## Redis分布式锁
### 使用
1. 获取锁：通过 SETNX 命令，确保在key不存在时才会成功；指定PX参数，即过期时间，避免死锁；指定value为请求id，标记获取锁的一方，以避免错误解锁和实现可重入。
2. 解锁：首先获取value，然后和获取锁是传入的value一致时再删除key。这两步通过LUA脚本执行，已实现原子性。
3. 续期：通过单独的线程，定期检查过期时间，快到时主动续期。
4. 公平性：可以通过redis set数据结构来实现按获取锁的时间排序。按排序获取锁，确保先请求的先获取成功。
5. 安全性：集群模式下，节点宕机可能造成数据一致性问题，影响安全性。可以使用redlock算法。
6. redlock：
   1. 分别向N个节点获取分布式锁，如果有N/2+1个成功，并且过期时间-获取耗时>0，则获取成功。否则需要发送解锁命令到所有节点。 
### 问redis分布式锁的底层实现，可以直接答使用，不用深入redis代码层面。
## 部署模式
1. 单机：简单；性能，可用性；
2. 主从：性能（适合读多写少）；可用性；
3. 哨兵：性能，自动故障转移（线上高可用）；故障转移时不可用；
4. 集群：性能，自动故障转移（大数据量高并发读写）；配置复杂，恢复时一致性；
   1. 节点间通过16379端口和gossip协议通信
### 哨兵和集群的选择：
1. 哨兵：更快速的故障转移，更简单；哨兵本身的故障，不支持分片。（适合小规模的高可用需求，需结合其它客户端或proxy实现负载均衡）
2. 集群：更大规模数据和高并发，可伸缩；配置复杂，故障转移慢一点。（适合大规模分布式存储和负载均衡）
### 其他八股文
1. 应用场景： 1. 缓存 2. 分布式锁 3. 会话存储 4. 计数 5. 排行榜 6. 消息队列
2. 数据结构: 1. String 2. Hash 3. Set 4. List 5. ZSet
3. 持久化方式: 1. RDB 数据集快照 2. AOF 所有写操作命令
4. 过期策略：1. 定期删除 定期随机检查有过期时间的键 2. 惰性删除 访问时检查过期
5. 事务实现：1. MULTI命令开启一个事务 2. EXEC执行事务中所有命令 3. WATCH命令用于监控一个或多个键，如果事务执行前被其他命令修改，事务将被打断。
6. 主动复制：1. 主节点执行写命令时会发送命令到从节点 2. 从节点定期发送SYNC命令到主节点同步数据
7. 集群模式实现：1. 数据按哈希槽分片存储 2. 客户端计算数据所在的节点后发送请求