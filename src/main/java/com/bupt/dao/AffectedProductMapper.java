package com.bupt.dao;

import com.bupt.entity.AffectedProduct;
import com.bupt.entity.AffectedProductWithBLOBs;
import org.springframework.stereotype.Repository;

@Repository
public interface AffectedProductMapper {
    int deleteByPrimaryKey(Long id);

    int deleteByBaseInfoID(Long baseId);

    int insert(AffectedProductWithBLOBs record);

    int insertSelective(AffectedProductWithBLOBs record);

    AffectedProductWithBLOBs selectByPrimaryKey(Long id);

    AffectedProductWithBLOBs selectByBaseInfoID(Long baseId);

    int updateByPrimaryKeySelective(AffectedProductWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(AffectedProductWithBLOBs record);

    int updateByPrimaryKey(AffectedProduct record);
}