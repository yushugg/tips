1. 视觉效果
  页面设计要美观
  考虑页面的兼容性，采用响应式布局（根据不同的设备显示不同效果，包括Mobile的横屏竖屏的情况）

2. 交互
  利用ajax异步验证表单
  初始，聚焦到用户名上

  用户名为空或者格式不对，提示用户名不对，清空密码框，聚焦到用户名框，全选用户名
  用户名不存在，同上
  密码错误，提示密码错误，清空密码框，聚焦到密码框，全选密码

  // or
  只要用户名or密码错误，提示“用户名or密码错误”，清空密码框，聚焦到用户名框，全选用户名

3. 状态提示：
  一个明确的用于状态提示的box
  等待3s，结果没有出来，提示用户继续等待
  等待6s，结果没有出来，提示用户网络不流畅
  设置10s为超时，并告知用户提交表单失败

4. 安全传输
  把密码和时间戳叠加，然后加密，传到后台的是加密的结果以及这个时间戳，如下：
    // 前端
    t = new Date();
    s = encode(pwd + t);
    post(s, t);

    // 后台
    decode(s) === pwd + t;

5. 数据走缓存
  表单提交是post，如果是get，应该考虑数据缓存
  如果请求的url相同，程序会直接从浏览器缓存中拿数据，并给出状态是status: 200 OK(from cache)，为了避免这些问题，要在请求的参数中加点东西
    _t = new Date*1
    _n = Math.random
    为了保证参数的绝对唯一性，可以把时间戳和随机数叠加起来使用
    _s = (new Date*1 + Math.random*1E5)/1E5
    即在get传参处，加上此参数

6. 对于不支持js，或支持不大好处
  使用noscript标签（最常用，也是最实用的）
  hack方式，document.write("<" + "!--")
    document.write("<" + "!--");
    // code...
    // 如果浏览器不支持 javascript，将显示这中间的内容
    // code...
    document.write("--" + ">");

7. 浏览器后退按钮
  ajax拿到success的状态码时，立刻做跳转
  不能使用window.location.href，应该使用window.location.replace替换当前历史记录

8. 记住密码
  当用户成功提交信息时，服务器给前端提供一个token，这个token是用于自动登录的
  只需保存token就行了，这样就很好的避免了cookie中存放用户隐私信息了
  当用户取消了“记住密码”的复选框的时候，应该立即清除相关cookie

9. 防止注入
  表单信息应该做正则匹配，或者信息的过滤，主要是后台考虑

10. 多次提交
  发布之前先从服务器拿token，该token只有一次有效
  后端判断一定时间内用户发布的多条信息，相同的信息去重

11. 容易错误的知识点
  setRequestHeader
  利用ajax来post信息，后台拿不到数据，原因是没有重写请求头的Content-Type
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send($.param({
        "user":$("#user").val(),
        "pwd":$("#pwd").val()
    }));

  checkbox
  页面上，记住密码单独一行


前端美观、安全传输、后台过滤、加密存储、记住密码-token
记住密码不好？不要该功能

认为password只有真正的用户才知道
a. 每个页面都需要对用户的身份进行认证，如果在线，则做相应的操作
b. 千万不要在cookie中存放用户的密码，加密的密码也不行
c. cookie中保存三个东西：用户名、登录序列、登录token
  用户名：明文存放
  登录序列：一个被md5散列过的随机数，仅当强制用户输入password时更新
  登录token：一个被md5散列过的随机数，仅当一个登录session内有效，新的登录session会更新它
  服务器也存这三个东西，服务器的验证用户，需要cookie里的这三个事
d. 不要让cookie有权限访问所有的操作，如下操作一定要用户输入password：
  修改口令
  修改电子邮件
  用户的隐私信息
  用户消费功能
e. 找回password，系统生成一个md5唯一的随机字串：(uid+IP+timestamp+random)放在数据库中，然后设置上时限，给用户发邮件，这个连接中包含md5的字串连接，用户通过连接来设置新的口令
