git���
    git cmd option Զ�ˣ�github�ϣ� ���ˣ�local��
    (git remote add origin https://github.com/yushugg/xx.git remote����github�ϵĲֿ�
     git push origin master origin����github�ϵĲֿ�����masterΪ���صķ�֧
     git pull origin master
     git commit -m "xx yy")

����һ��Զ�̵Ĳֿ⣺
    ����github.com�ϴ���һ���ֿ�
    Ȼ�󱾵�clone����git clone https://github.com/yushugg/xx.git
    ���У�originΪĬ�ϵ�Զ�ֿ̲��shortname
    ÿ�ε��ύ����Ϊgit add .;git commit -m "message";git push origin master;�鿴Ŀǰ״̬��git status��

�����ȱ��ش�����Ȼ��github remote����ӣ�
    mkdir xx
    git init
    ...write something...
    git add .
    git commit -m 'xx yy'
    git remote add origin https://github.com/yushugg/xx.git
    git push origin master

cloneһ��Զ�̵Ĳֿ⣺
    git clone xxx.git [�����Ѵ��ڵ�Ŀ¼��]

����ssh key��
    ssh-keygen -C "...@mail..." -t rsa��Ȼ����profile�м����µ�key
    add new key to the ssh-agent: ssh-add ~/.ssh/id_rsa
    ������ͨ�ԣ�ssh -T git@github.com

branch and checkout:
    �½�һ����֧��git branch [branch-name]
    ɾ��һ����֧��git branch -d [branch-name]
    �л���testing��֧��git checkout testing
    �ϲ���֧����master��֧�£�git merge [branch-name] ��branch�ϲ���master

ignore �ļ���
    .gitignore���������

�鿴�仯��diff��
    git diff (--cached)

�鿴��ʷ��log��
    git log (-p -2)

�Ƴ����޸��ļ���
    git rm xxx  git; mv file_from file_to
    git remote rename file_from file_to
    git remote rm paul

git config��
    git config --global user.name xxx
    git config --list
