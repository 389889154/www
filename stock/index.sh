# #!/bin/bash

# stocks=(
#   "sz002212" #
#   "sz002387" #
#   "sh600789" #
#   "sz300284" #
#   "sz002131" #
#   "sz002195" #
#   "sz002265" #
#   "sz002402" #
#   "sh603211" #
#   "sz300101" #
# )

# # 循环处理每只股票
# for code in "${stocks[@]}"; do
#   # 获取股票数据
#   response=$(curl -s "http://qt.gtimg.cn/q=${code}" | iconv -f gbk -t utf-8)
#   name=''
#   rank=0
#   echo $response | awk -F '~' '{
#   for (i=1; i<=NF; i++) {
#   if (i == 2) {
#   printf " %-8s ",  $i
#   name=$1
#   }
#   if (i == 33) {
#   rank=$i
#   if ($i > 0){
#   printf "\033[31m %-8s\n\033[0m" ,  $i
#   }else{
#   printf "\033[32m %-8s\n\033[0m" ,  $i
#   }

  
#   break
#   }
   
    
#   }
# }'

# done

#!/bin/bash

# 定义颜色代码
RED="\033[31m"
GREEN="\033[32m"
RESET="\033[0m"

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
  
  # sleep 0.1 # 防止请求过于频繁
done

# 按 rank 数值降序排序并输出
sort -k2,2nr "$tmpfile" | while IFS=$'\t' read -r name rank; do
  color=$([ $(echo "$rank > 0" | bc) -eq 1 ] && echo "$RED" || echo "$GREEN")
  printf "%-20s ${color}%+10.2f${RESET}\n" "$name" "$rank"
  # printf "%-20s ${color}%+8.2f${RESET}\n" "$name" "$rank"
done

# 清理临时文件
rm -f "$tmpfile"