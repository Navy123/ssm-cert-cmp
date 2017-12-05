package com.bupt.dao;

import com.bupt.entity.LibInfo;
import org.springframework.stereotype.Repository;

@Repository
public interface LibInfoMapper {
    int deleteByPrimaryKey(Long id);

    int deleteByBaseInfoID(Long baseId);

    int insert(LibInfo record);

    int insertSelective(LibInfo record);

    LibInfo selectByPrimaryKey(Long id);

    LibInfo selectByBaseInfoID(Long baseId);

    int updateByPrimaryKeySelective(LibInfo record);

    int updateByPrimaryKeyWithBLOBs(LibInfo record);

    int updateByPrimaryKey(LibInfo record);
}