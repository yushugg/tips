配置环境变量：

    先设置JAVA_HOME，用which java找到java所在地（如果有软连接则一直找到最终的命令所在地），一般为/usr/lib/jvm/java-1.7.0-openjdk-xxx目录
    然后CLASSPATH为.:$JAVA_HOME/lib
    运行的PATH为$JAVA_HOME/bin
