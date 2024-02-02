

* Encoding: UTF-8.
* 计算原始变量的最大值和最小值.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=*.
COMPUTE MaxValue = MAX(last_time).
COMPUTE MinValue = MIN(last_time).

* 对原始变量进行 Max-Min 编码.
COMPUTE last_time_encoded = (last_time - MinValue) / (MaxValue - MinValue).

* 删除中间变量.
DELETE VARIABLES MaxValue MinValue.
