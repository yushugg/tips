## sed命令

**不会修改源文件，要修改添加-i参数，或者重定向**  
**a,i,c,d,p命令模式是"/xxx/[aicdp]+st."或者"num i xxx"**  
**s命令模式是"s/origin/sub/num"**  

多个命令可以用大括号扩起来，如"3,6 {/This/{/fish/d}}"， xx.txt
3至6行，如果同时匹配到This和fish就删除这一行
分号为两个命令分割

1. s替换  
    sed "s/origin/sub/num" xx.txt  
    s前面可以加数字，表示行，如3s，3,4s，3,$s，1,+2s  
    origin和sub是正则表达式，引用前面的使用&符号，或者圆括号匹配，使用\1,\2调用之前的变量  
    num表示替换哪一个，g表示一行所有

2. N命令  
    把下一行的内容纳入当成缓冲区做匹配  
    sed "N;s/my/your/" xx.txt  
    将会替换奇数行

3. a命令和i命令  
    sed "1 i xxx" 在第一行添加一行xxx  
    或者通过匹配来添加行，sed "/fish/a xxxx" xx.txt

4. c命令  
    替换匹配行，换掉匹配的一行  
    sed "/fish/c sdafsfa" xx.txt

5. d命令  
    删除匹配行，删除匹配的一整行  
    sed "/fish/d" xx.txt  
    sed "2d" xx.txt

6. p命令  
    打印命令  
    类似grep，找出匹配行，建议和-n一起使用


hold space 和 pattern space  
g: hold space拷贝到pattern space并覆盖  
G: h append to p  
h: p override h  
H: p append to h  
x: swap p and h
