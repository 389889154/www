stocks=(
    "sz002212"   # 天融信
    "sz002387"   # 维信诺
    "sh600789"   # 鲁抗医药
    "sz300284"   # 苏交科
)

# 循环处理每只股票
for code in "${stocks[@]}"; do
    # 获取股票数据
    response=$(curl -s "http://qt.gtimg.cn/q=${code}" | iconv -f gbk -t utf-8)
    echo $response | awk -F '~' '{
  for (i=1; i<=NF; i++) {
  if (i == 2) {
  printf " %s ",  $i
  }
  if (i == 33) {
  printf "%s\n",  $i
  break
  }
   
    
  }
}'

    
done