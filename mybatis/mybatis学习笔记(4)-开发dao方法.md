# mybatis学习笔记(4)-开发dao方法

标签： mybatis

---

**Contents**

  - [SqlSession使用范围](#sqlsession使用范围)
  - [原始dao开发方法](#原始dao开发方法)
    - [dao接口](#dao接口)
    - [dao接口实现类](#dao接口实现类)
    - [测试代码](#测试代码)
    - [总结原始dao开发问题](#总结原始dao开发问题)
  - [mapper代理方法](#mapper代理方法)
    - [开发规范](#开发规范)
    - [代码](#代码)
    - [一些问题总结](#一些问题总结)



---


本文讲解SqlSession，并对两种方法(原始dao开发和mapper代理开发)分别做简单展示


## SqlSession使用范围

- SqlSessionFactoryBuilder

通过`SqlSessionFactoryBuilder`创建会话工厂`SqlSessionFactory`将`SqlSessionFactoryBuilder`当成一个工具类使用即可，不需要使用单例管理`SqlSessionFactoryBuilder`。在需要创建`SqlSessionFactory`时候，只需要new一次`SqlSessionFactoryBuilder`即可。


- `SqlSessionFactory`

通过`SqlSessionFactory`创建`SqlSession`，使用单例模式管理`sqlSessionFactory`（工厂一旦创建，使用一个实例）。将来mybatis和spring整合后，使用单例模式管理`sqlSessionFactory`。


- `SqlSession`

`SqlSession`是一个面向用户（程序员）的接口。SqlSession中提供了很多操作数据库的方法：如：`selectOne`(返回单个对象)、`selectList`（返回单个或多个对象）。

`SqlSession`是线程不安全的，在`SqlSesion`实现类中除了有接口中的方法（操作数据库的方法）还有数据域属性。

`SqlSession`最佳应用场合在方法体内，定义成局部变量使用。


## 原始dao开发方法

程序员需要写dao接口和dao实现类

[mybatis之dao接口开发完整示例](https://github.com/tekintian/mybatis_demo/tree/v0.2.0)

### dao接口

```java
public interface UserDao {
    //根据id查询用户信息
    public User findUserById(int id) throws Exception;

    //根据用户名列查询用户列表
    public List<User> findUserByName(String name) throws Exception;

    //添加用户信息
    public void insertUser(User user) throws Exception;

    //删除用户信息
    public void deleteUser(int id) throws Exception;
}
```

### dao接口实现类

```java
package cn.tekin.mybatis.dao;

import cn.tekin.mybatis.po.User;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

/**
 * Created by Brian on 2016/2/24.
 */
public class UserDaoImpl implements UserDao{
    // 需要向dao实现类中注入SqlSessionFactory
    // 这里通过构造方法注入
    private SqlSessionFactory sqlSessionFactory;

    public UserDaoImpl(SqlSessionFactory sqlSessionFactory){
        this.sqlSessionFactory = sqlSessionFactory;
    }


    @Override
    public User findUserById(int id) throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        User user = sqlSession.selectOne("test.findUserById",id);
        //释放资源
        sqlSession.close();
        return user;
    }

    @Override
    public List<User> findUserByName(String name) throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();

        List<User> list = sqlSession.selectList("test.findUserByName", name);

        // 释放资源
        sqlSession.close();

        return list;
    }

    @Override
    public void insertUser(User user) throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //执行插入操作
        sqlSession.insert("test.insertUser", user);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }

    @Override
    public void deleteUser(int id) throws Exception {
        SqlSession sqlSession = sqlSessionFactory.openSession();

        //执行插入操作
        sqlSession.delete("test.deleteUser", id);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }
}
```

### 测试代码

```java
package cn.tekin.mybatis.dao;

import java.io.InputStream;

import cn.tekin.mybatis.po.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Before;
import org.junit.Test;



public class UserDaoImplTest {

	private SqlSessionFactory sqlSessionFactory;

	// 此方法是在执行testFindUserById之前执行
	@Before
	public void setUp() throws Exception {
		// 创建sqlSessionFactory

		// mybatis配置文件
		String resource = "SqlMapConfig.xml";
		// 得到配置文件流
		InputStream inputStream = Resources.getResourceAsStream(resource);

		// 创建会话工厂，传入mybatis的配置文件信息
		sqlSessionFactory = new SqlSessionFactoryBuilder()
				.build(inputStream);
	}

	@Test
	public void testFindUserById() throws Exception {
		// 创建UserDao的对象
		UserDao userDao = new UserDaoImpl(sqlSessionFactory);

		// 调用UserDao的方法
		User user = userDao.findUserById(1);
		
		System.out.println(user);
	}

}

```

### 总结原始dao开发问题

1.dao接口实现类方法中存在大量模板方法，设想能否将这些代码提取出来，大大减轻程序员的工作量。

2.调用sqlsession方法时将statement的id硬编码了

3.调用sqlsession方法时传入的变量，由于sqlsession方法使用泛型，即使变量类型传入错误，在编译阶段也不报错，不利于程序员开发。

[mybatis之dao接口开发完整示例](https://github.com/tekintian/mybatis_demo/tree/v0.2.0)

## mapper代理方法

程序员只需要mapper接口（相当 于dao接口）

程序员还需要编写mapper.xml映射文件

程序员编写mapper接口需要遵循一些开发规范，mybatis可以自动生成mapper接口实现类代理对象。

[mybatis之mapper代理开发完整示例](https://github.com/tekintian/mybatis_demo/tree/v0.3.0)

### 开发规范

- 在mapper.xml中namespace等于mapper接口地址

```xml
<!--
 namespace 命名空间，作用就是对sql进行分类化管理,理解为sql隔离
 注意：使用mapper代理方法开发，namespace有特殊重要的作用,namespace等于mapper接口地址
 -->
<mapper namespace="cn.tekin.mybatis.mapper.UserMapper">
```

- mapper.java接口中的方法名和mapper.xml中statement的id一致

- mapper.java接口中的方法输入参数类型和mapper.xml中statement的parameterType指定的类型一致。

- mapper.java接口中的方法返回值类型和mapper.xml中statement的resultType指定的类型一致。

```xml
<select id="findUserById" parameterType="int" resultType="cn.tekin.mybatis.po.User">
    SELECT * FROM  user  WHERE id=#{value}
</select>
```

```java
//根据id查询用户信息
public User findUserById(int id) throws Exception;
```

总结：以上开发规范主要是对下边的代码进行统一生成：

```java
User user = sqlSession.selectOne("test.findUserById", id);
sqlSession.insert("test.insertUser", user);
```


### 代码

[mybatis之mapper代理开发完整示例](https://github.com/tekintian/mybatis_demo/tree/v0.3.0)

### 一些问题总结

- 代理对象内部调用`selectOne`或`selectList`
   - 如果mapper方法返回单个pojo对象（非集合对象），代理对象内部通过selectOne查询数据库。
   - 如果mapper方法返回集合对象，代理对象内部通过selectList查询数据库。


- mapper接口方法参数只能有一个是否影响系统开发

mapper接口方法参数只能有一个，系统是否不利于扩展维护?系统框架中，dao层的代码是被业务层公用的。即使mapper接口只有一个参数，可以使用包装类型的pojo满足不同的业务方法的需求。

注意：持久层方法的参数可以包装类型、map...等，service方法中建议不要使用包装类型（不利于业务层的可扩展）。

