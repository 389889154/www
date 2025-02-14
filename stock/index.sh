#!/bin/bash

# 定义颜色代码
RED="\033[31m"
GREEN="\033[32m"
RESET="\033[0m"

# 默认秒数为 10
interval=10

# 如果传递了参数，则使用该参数作为间隔
if [ -n "$1" ]; then
  interval=$1
fi

# 股票代码列表
stocks=(
  "sz002212" # 天融信
  "sz002387" # 维信诺
  "sh600789" # 鲁抗医药
  "sz300284" # 苏交科
  "sz002131" # 利欧股份
  "sz002195" # 岩山科技
  "sz002265" # 建设工业
  "sz002402" # 和而泰
  "sh603211" # 晋拓股份
  "sz300101" # 振芯科技
)

# 临时文件存储数据
tmpfile=$(mktemp /tmp/stock_rank.XXXXXX)

# 无限循环，每`interval`秒运行一次
while true; do
  # 清空屏幕
  clear

  # 清空临时文件
  > "$tmpfile"

  # 循环处理每只股票
  for code in "${stocks[@]}"; do
    # 获取股票数据
    response=$(curl -s "http://qt.gtimg.cn/q=${code}" | iconv -f gbk -t utf-8)
  
    # 提取名称和 rank 并保存到临时文件
    echo "$response" | awk -F '~' '{
      name = $2   # 第2字段是股票名称
      rank = $33  # 第33字段是排名或目标数值
      printf("%s\t%.2f\n", name, rank)
    }' >> "$tmpfile"
  
    # sleep 0 # 防止请求过于频繁
  done

  # 按 rank 数值降序排序并输出
  sort -k2,2nr "$tmpfile" | while IFS=$'\t' read -r name rank; do
    color=$([ $(echo "$rank > 0" | bc) -eq 1 ] && echo "$RED" || echo "$GREEN")
    printf "%-20s ${color}%+10.2f${RESET}\n" "$name" "$rank"
  done

  # 清理临时文件
  rm -f "$tmpfile"

  # 每`interval`秒暂停一次
  sleep $interval
done