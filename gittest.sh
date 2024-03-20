grep   'ld64' 58.html 
if [ $? -ne 0 ]; then  
echo fail
else
echo ok
fi