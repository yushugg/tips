���ɳ�����̣�
    ���룺����Դ�ļ������м�Ŀ���ļ���o�ļ�����obj�ļ���
    ���ӣ������м�Ŀ���ļ����ɿ�ִ���ļ����ڴ����ʱ������Դ�ļ�̫�࣬�������ɵ��м�Ŀ���ļ�̫�࣬��������ʱ��Ҫ���Ե�ָ���м�Ŀ���ļ���������ڱ���ܲ����㣬���ԣ�����Ҫ���м�Ŀ���ļ����������Windows�����ְ��С����ļ�����Library File)��Ҳ���� .lib �ļ�����UNIX�£���Archive File��Ҳ���� .a �ļ�
makefile����
    target...:prerequisites...
        command
        ...
        ...
    .PHONY : clean 
    clean : 
        -rm edit $(objects)
   һ��Ҫ��һ��Tab����Ϊ��ͷ 
makefileԭ��
   prerequisites�������һ�����ϵ��ļ���target�ļ�Ҫ�µĻ���command�����������ͻᱻִ�С������Makefile�Ĺ���Ҳ����Makefile������ĵ����ݡ�
������
    objects = main.o kbd.o command.o display.o \ 
        insert.o search.o files.o utils.o
    ���ã�$(objects)

gcc ����ѡ�
  -x language ָ���ļ���ʹ�õ�����--c, objective-c, c-header, c++, assembler��
  -x none �ر���һ������ѡ���gcc�Զ������ļ�����׺ʶ���ļ�����
  -c  ��Ԥ�������롢��࣬�����м��ļ�obj�ļ���.o�ļ���
  -S  ��Ԥ�������룬���ɻ����루.s�ļ���
  -E  ��Ԥ�����������ļ��������ض���һ������ļ���
  -o  ָ�������ļ�������
  -g  ֻ���ڱ����ʱ�򣬲���������Ϣ
  -I dir  ����dirĿ¼�е�ͷ�ļ�
  -L dir  ����dirĿ¼�еĿ��ļ�
  -static ���Ӿ�̬��
  -library  ������Ϊlibrary�Ŀ��ļ�
  -w  �ر����и澯
  -Wall ������gcc�ṩ���������õı�����Ϣ
