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

# 企业微信 Webhook URL
webhook_url="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=783771bb-ed6f-4725-9c79-6e36989d9bc2"
# 数据港 汉威科技 曼卡龙 岩山科技  维信诺 弘信电子 润建股份 云赛智联
# 股票代码列表
stocks=(
    "sh603629" # 利通电子
    "sz300007" # 岩山科技
    "sh601177" # 杭齿前进
    "sz300657" # 弘信电子
    "sz002276" # 万马股份
    "sz300457" # 赢合科技
    "sz300007" # 汉威科技
)

# 临时文件存储数据
tmpfile=$(mktemp /tmp/stock_rank.XXXXXX)

# 清除屏幕和处理数据的函数
function fetch_and_display_data {
  # 将光标移动到屏幕顶部而不清除屏幕
  clear

  # 清空临时文件
  > "$tmpfile"

  # 存储输出结果
  output=""

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
  done

  # 按 rank 数值降序排序并输出
  sorted_output=$(sort -k2,2nr "$tmpfile" | while IFS=$'\t' read -r name rank; do
    color=$([ $(echo "$rank > 0" | bc) -eq 1 ] && echo "$RED" || echo "$GREEN")
    printf "%-20s ${color}%+10.2f${RESET}\n" "$name" "$rank"
  done)

  # 清理临时文件
  rm -f "$tmpfile"

  # 将输出结果发送到企业微信
  output_message="1\n$sorted_output"
  printf $output_message

  # 发送消息到企业微信
  curl -X POST "$webhook_url" \
       -H "Content-Type: application/json" \
       -d '{
             "msgtype": "text",
             "text": {
               "content": "'"$output_message"'"
             }
           }'
}

# 根据interval决定是否执行循环
if [ "$interval" -eq 0 ]; then
  # 只执行一次
  fetch_and_display_data
else
  # 无限循环，每`interval`秒运行一次
  while true; do
    fetch_and_display_data
    sleep $interval
  done
fi


