MVC设计模式：
    分成4个python文件--models.py(database tables)
                       views.py(business logic)一个url对应的函数内容，处理Request
                       urls.py(URL configuration)
                       xx.html(template)
    
                       还有setting.py负责所有的配置

创建project：
    django-admin.py startproject mysite

启动服务器：
    python manage.py runserver [端口号]

启动交互界面：
    python manage.py shell

Django模板：
    {{ xx }} variable
    {% if xx %} template tag
    {{ xx|date: "F j, Y" }} |为管道过滤

Django模板系统的基本规则：
    1. 写模板，创建Template对象
    2. 创建Context对象，一个字典为参数
    3. 调用render()方法

    t = template.Template('My name is {{name}}.')
    c = template.Context({'name': 'Adrian'})
    print t.render(c)

Django模板中遍历复杂数据结构的关键是句点符号（.），类似对象中访问成员变量，调用方法的时候，不能用圆括号，所以不能传递参数，只能调用不需参数的方法
在方法查找过程中,如果某方法抛出一个异常,除非该异常有一个 silent_variable_failure 属性并且值为 True ,否则的话它将被传播。如果异常被传播,模板里的指定变量会被置为空字符串

防止自动执行的方法：
    如果模板文件里包含了{{ account.delete }} ,对象又具有 delete() 方法,而且delete() 有alters_data=True 这个属性,那么在模板载入时, delete()方法将不会被执行。 它将静静地错误退出。

默认情况下，如果一个变量不存在，模板系统会把它展示为空字符串，不做任何事情来表示失败

{% if xxx %} 不允许and or嵌套，即不能使用圆括号进行嵌套，要么分层，要么移到模板之外一定要有{% endif %}

{% for xx in xx_list reversed %}反向迭代
{% empty %}当内容为空时，进行的操作输出
{% endfor %}
for loop的一些变量：
    forloop.counter
    forloop.counter0
    forloop.revcounter
    forloop.revcounter0
    forloop.first 一个boolean值，可以用来判断是不是第一次循环
    forloop.last
    forloop.parentloop 指向上一级循环的forloop对象的引用，用于嵌套循环

{% ifequal xx yy %}
{% else %}
{% endifequal %}

{# This is a comment #}
{% comment %}
{% endcomment %}

{% include 'xx/yy.html' %}

模板加载：
    !!!使用的都是/而不是\
    settings.py中修改TEMPLATE_DIRS
        TEMPLATE_DIRS = (
                os.path.join(BASE_DIR, 'templates').replace('\\', '/'),
        )
    加载使用：t = get_template('xx.html')
    或者自动加载同时渲染：return render_to_response('xx.html', {'yy':fdsf})
    或者前面赋值使用xx.html中的变量名，然后return render_to_response('xx.html', locals())

模板继承：
    先设计基础框架
    {% block blockname %}...{% endblock %}
    其他继承，则只需{% extends "base.html" %}，然后填充每个block的具体内容
    如果需要访问父模板中的块的内容，使用{{ block.super }}

Model：
    DATABASE_ENGINE--使用哪个数据库引擎, postgresql_psycopg2, mysql, sqlite3, oracle
    DATABASE_NAME--数据库名，如果是sqlite，输入完整的数据库文件系统路径
    DATABASE_USER--连接数据库使用的用户，sqlite空白即可
    DATABASE_PASSWORD--用户密码，sqlite空白即可
    DATABASE_HOST--连接哪一台主机的数据库服务器，sqlite或本机空白即可
    DATABASE_PORT--端口号

    没有显式地为这些模型定义任何主键的话，会自动生成一个自增长的整数主键字段，每个Django模型都要求单独的主键，id

    settings.py中配置INSTALLED_APPS
    然后，python manage.py validate验证模型的有效性
    python manage.py sqlall books生成create table语句
    python manage.py syncdb同步到数据库中，syncdb不支持修改和删除

    插入数据，新建一个表的相应对象即可，然后p.save()会保存到数据库中
    或者使用表.objects.create(xx='xx', yy='yy')即可一步到位存到数据库中
    表.objects.all()相当于select all
    更新数据只需要修改对应对象的属性，然后记得要p.save()即可!!!

    数据过滤：
        表.objects.filter(name='Apress', xx='xx')，返回的是一个list
            like语句--name__contains='press'
            icontains(大小写无关的like)
            startswith, endswith, range

        表.objects.get(name='Apress')，返回的是单个对象

        表.DoesNotExist 不存在的异常

    排序：
        表.objects.order_by("name")，跟all()差不多，获取所有的对象，指定了排序部分
        逆序用"-name"

    更新：
        表.objects.filter(id=52).update(name = 'xxx')
        表.objects.all().update(name = 'xxx')
        返回收到影响的数目

    删除：
        p.delete()

表单：
    !!!即使客户端有js可以验证登陆，服务器端也要重新验证一次，因为用户可能会关闭js
    !!!每次都应该给成功的POST请求做重定向，防止刷新后重复发送数据
    HttpRequest对象:
        request.path--除域名以外的请求路径，以正斜杠开头--/hello/
        request.get_host()--主机名--127.0.0.1:8000 or www.example.com
        request.get_full_path()--请求路径，可能包含查询字符串--/hello/?print=true
        request.is_secure()--如果https则True，否则False

    request.META，一个python字典，包含所有本次http请求的header信息
        HTTP_REFERER--进站前链接网页，如果有的话
        HTTP_USER_AGENT--用户浏览器的user-agent字符串，如果有的话
        REMOTE_ADDR--客户端IP

    request.GET, request.POST类字典对象：
        q = request.GET['q']
        request.POST.get('name', '')

    Form对象
        from django import forms
        class ContactForm(forms.Form):
            subject = forms.CharField()
            email = forms.EmailField(required=False)
            message = forms.CharField()
        判断数据是否合法--f.is_valid()
        error信息--f.errors--dict
        f.cleaned_data--转换成相应的python类型数据，叫做清理数据，清理成Unicode对象，日期型会转成datetime.date型对象
        可以在form对象中添加自定义的验证方法，如def clean_message(self)
