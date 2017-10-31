功能：
1、新增了邮件提醒功能
（若想生效自行修改文件\source\function.php 257行 把里面的邮箱账号密码换一下）
2、新增飞信短信提醒功能
（同上 修改\source\api.php 72行 应该只支持移动手机号吧?）
3、新增短网址功能
（创建项目时就看得到了 借鉴了wooyun http://zone.wooyun.org/content/10175 不过我不是修改的文中提到的文件
文中的文件推断是模版的临时文件）
4、增加个人设置功能
（其实就是为了方便修改手机号和邮箱而已~还可以关闭邮件和短信提醒哦~）
5、使用Bootstrap框架，界面更美观。

升级方式：
1、直接使用本包提供的所有文件（别忘了修改config.php .htaccess）
2、在原有的xsser.me源码基础上升级:
	首先直接覆盖所有文件！
	然后在数据库中,oc_user表中添加两个字段，根据xssplatform.sql添加下吧~


1、修改config.php里面的数据库连接字段，包括用户名，密码，数据库名，访问URL起始和伪静态的设置。 
2、在web根目录下有一个xssplatform.sql，导入库。
3、进入数据库执行语句修改域名为自己的。 
UPDATE oc_module SET 
code=REPLACE(code,'http://xsser.me','http://yourdomain/xss')
同时替换authtest.php中的网址代码

备注：注册成功用户后，修改管理员表中的adminlevel为1时 可定义自身为最高管理员可发送邀请码
4、建立.htaccess文件写入以下代码：

RewriteEngine On
RewriteRule ^([0-9a-zA-Z]{6})$ /xss/index.php?do=code&urlKey=$1 [L] 
RewriteRule ^do/auth/(\w+?)(/domain/([\w\.]+?))?$  /xss/index.php?do=do&auth=$1&domain=$3 [L] 
RewriteRule ^register/(.*?)$ /xss/index.php?do=register&key=$1 [L] 
RewriteRule ^register-validate/(.*?)$ /xss/index.php?do=register&act=validate&key=$1 [L]
RewriteRule ^login$ /xss/index.php?do=login [L]



范例：
//apache
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^([0-9a-zA-Z]{6})$ /index.php?do=code&urlKey=$1 [L] 
RewriteRule ^do/auth/(\w+?)(/domain/([\w\.]+?))?$  /index.php?do=do&auth=$1&domain=$3 [L] 
RewriteRule ^register/(.*?)$ /index.php?do=register&key=$1 [L] 
RewriteRule ^register-validate/(.*?)$ /index.php?do=register&act=validate&key=$1 [L]
</IfModule>


//nginx
rewrite "^/([0-9a-zA-Z]{6})$" /index.php?do=code&urlKey=$1 last;
rewrite "^/do/auth/(\w+?)(/domain/([\w\.]+?))?$" /index.php?do=do&auth=$1&domain=$3 last;
rewrite "^/register/(.*?)$" /index.php?do=register&key=$1 last;
rewrite "^/register-validate/(.*?)$" /index.php?do=register&act=validate&key=$1 last;

备注-最全修改指南：
http://blog.csdn.net/cnsecs/article/details/9159357