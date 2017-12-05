package com.bupt.dao;

import com.bupt.entity.FrameInfo;
import org.springframework.stereotype.Repository;

@Repository
public interface FrameInfoMapper {
    int deleteByPrimaryKey(Long id);

    int deleteByBaseInfoID(Long baseId);

    int insert(FrameInfo record);

    int insertSelective(FrameInfo record);

    FrameInfo selectByPrimaryKey(Long id);

    FrameInfo selectByBaseInfoID(Long baseId);

    int updateByPrimaryKeySelective(FrameInfo record);

    int updateByPrimaryKey(FrameInfo record);
}