package cn.tekin.learnssm.firstssm.mapper;

import cn.tekin.learnssm.firstssm.po.ItemsCustom;
import cn.tekin.learnssm.firstssm.po.ItemsQueryVo;

import java.util.List;

public interface ItemsMapperCustom {
    //商品查询列表
    List<ItemsCustom> findItemsList(ItemsQueryVo itemsQueryVo) throws Exception;
}