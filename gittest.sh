key="\-ld64"
grep  ${key} 58.html 
if [ $? -ne 0 ]; then  
echo fail
else
echo ok
fi