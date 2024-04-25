# key="\-ld64"
# grep  ${key} 58.html 
# if [ $? -ne 0 ]; then  
# echo fail
# else
# echo ok
# fi

# hook_dir = '.git/hooks/'
# cd hook_dir





key="\-ld64"

cd '.git/hooks/'

if test -e ok; then
    echo "文件存在"
else
touch ok
echo "文件不存在"
fi



grep  -i ${key} ok 
if [ $? -ne 0 ]; then  
echo 未安装

cat >> ok <<EOF

grep  '\-ld64' 58.html 
if [ \$? -ne 0 ]; then  
echo fail
else
echo ok
fi
EOF

echo 安装完成
else

echo 已安装

fi

chmod 777 ok

exit 0


