package cn.tekin.ssm.dao;

import cn.tekin.ssm.po.User;

/**
 * Created by Brian on 2016/2/24.
 */
public interface UserDao {
    //根据id查询用户信息
    public User findUserById(int id) throws Exception;

}
