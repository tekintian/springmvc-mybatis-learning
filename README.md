# springmvc + mybatis 学习笔记
本笔记转至 [brianway](http://brianway.github.io/) , 本人加入和更新了部分自己学习过程中的内容和代码。

笔记内容主要是 mybatis 和 springmvc 的一些基本概念和使用方法，涉及概念介绍、环境搭建、编程细节、运行调试等方面。


**如果觉得不错，请先在这个仓库上点个 star 吧**，这也是对我的肯定和鼓励，谢谢了。不定时进行调整和补充，需要关注更新的请 Watch、Star、Fork


-----

## 目录

  - [mybatis](/mybatis)
    - [mybatis学习笔记(1)-对原生jdbc程序中的问题总结.md](/mybatis/mybatis学习笔记(1)-对原生jdbc程序中的问题总结.md)
    - [mybatis学习笔记(2)-mybatis概述.md](/mybatis/mybatis学习笔记(2)-mybatis概述.md)
    - [mybatis学习笔记(3)-入门程序一.md](/mybatis/mybatis学习笔记(3)-入门程序一.md)
    - [mybatis学习笔记(3)-入门程序二.md](/mybatis/mybatis学习笔记(3)-入门程序二.md)
    - [mybatis学习笔记(4)-开发dao方法.md](/mybatis/mybatis学习笔记(4)-开发dao方法.md)
    - [mybatis学习笔记(5)-配置文件.md](/mybatis/mybatis学习笔记(5)-配置文件.md)
    - [mybatis学习笔记(6)-输入映射.md](/mybatis/mybatis学习笔记(6)-输入映射.md)
    - [mybatis学习笔记(7)-输出映射.md](/mybatis/mybatis学习笔记(7)-输出映射.md)
    - [mybatis学习笔记(8)-动态sql.md](/mybatis/mybatis学习笔记(8)-动态sql.md)
    - [mybatis学习笔记(9)-订单商品数据模型分析.md](/mybatis/mybatis学习笔记(9)-订单商品数据模型分析.md)
    - [mybatis学习笔记(10)-一对一查询.md](/mybatis/mybatis学习笔记(10)-一对一查询.md)
    - [mybatis学习笔记(11)-一对多查询.md](/mybatis/mybatis学习笔记(11)-一对多查询.md)
    - [mybatis学习笔记(12)-多对多查询.md](/mybatis/mybatis学习笔记(12)-多对多查询.md)
    - [mybatis学习笔记(13)-延迟加载.md](/mybatis/mybatis学习笔记(13)-延迟加载.md)
    - [mybatis学习笔记(14)-查询缓存之一级缓存.md](/mybatis/mybatis学习笔记(14)-查询缓存之一级缓存.md)
    - [mybatis学习笔记(15)-查询缓存之二级缓存.md](/mybatis/mybatis学习笔记(15)-查询缓存之二级缓存.md)
    - [mybatis学习笔记(16)-mybatis整合ehcache.md](/mybatis/mybatis学习笔记(16)-mybatis整合ehcache.md)
    - [mybatis学习笔记(17)-spring和mybatis整合.md](/mybatis/mybatis学习笔记(17)-spring和mybatis整合.md)
    - [mybatis学习笔记(18)-mybatis逆向工程.md](/mybatis/mybatis学习笔记(18)-mybatis逆向工程.md)

-----

## 安装和使用

环境准备:

- jdk 1.8+
- intellij IDEA 15.0.2+
- mysql 5.1+
- maven 3.3+
- tomcat 8+


数据库导入:

- 新建一个数据库,项目中默认的数据库名为 `mybatis001`
- 导入 [sourcecode/sql](/sourcecode/sql) 中的 [create.sql](/sourcecode/sql/create.sql) 创建数据表
- 导入 [sourcecode/sql](/sourcecode/sql) 中的 [data.sql](/sourcecode/sql/data.sql) 添加测试数据



源码导入:

- 将 sourcecode 中的任意子文件夹拷贝出来作为项目根目录,打开即可
- 每个子文件夹的项目请参考 [sourcecode 说明](#sourcecode说明)


-----

## sourcecode 说明

该文件夹下是涉及到的源码，其中 mybatis 部分都是直接新建的 web 工程，springmvc 部分都是使用 maven 构建的。

我使用的 IDE 是 intellij IDEA 15.0.2,以下每个子文件夹对应一个 project。

- [mybatis](/sourcecode/mybatis):mybatis 部分前 16 篇笔记用到的源码
- [mybatis-spring](/sourcecode/mybatis-spring):mybatis 部分笔记(17)对应的源码
- [mybatis-generator](/sourcecode/mybatis-generator):逆向工程的源码
- [springmvcfirst](/sourcecode/springmvcfirst):springmvc 部分前两篇笔记对应的非注解方式配置的源码
- [springmvcsecond](/sourcecode/springmvcsecond):springmvc 部分前几篇笔记对应的注解方式配置的源码
- [**learnssm-firstssm**](/sourcecode/learnssm-firstssm):**核心代码**,springmvc 和 mybatis 整合部分的笔记几乎所有的源码


-----

## 赞助

如果您觉得该项目对您有帮助，请扫描下方二维码对我进行鼓励，以便我更好的维护和更新，谢谢支持！

![支付宝](http://yunnan.ws/pay/tekin/pay.jpg)



- [My Github Page](http://tekin.yunnan.ws/)
- [云南网](http://yunnan.ws/)


-----

**All Copyright Reserved**