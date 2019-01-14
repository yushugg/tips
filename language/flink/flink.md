## 大数据

1. yarn：资源管理
2. hadoop：批处理(含有hdfs、map reduce等生态)
3. storm：流式处理；无状态，core storm只支持more than once
4. spark：批处理、流式处理(micro batch)
5. flink：批处理(用流式处理的方式)、流式处理；有状态
6. kafka：可对接storm、flink去消费数据；分为producer和consumer的dilivery guarantee；默认保证at least once，允许设置producer异步提交实现at most once(读完消息先commit后处理消息还是反之)，如果满足幂等性，at least once就等于是exactly once

## 配置

1. flink：jobmanager，taskmanager；配置的时候以一个taskmanager为单位思考，taskslots、taskmemory、taskcores都是以一个taskmanager为单位
2. spark：driver、worker；配置的时候以一个worker为单位去思考，同上