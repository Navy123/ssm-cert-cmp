package com.bupt.dao;

import com.bupt.entity.CodeInfo;
import org.springframework.stereotype.Repository;

@Repository
public interface CodeInfoMapper {
    int deleteByPrimaryKey(Long id);

    int deleteByBaseInfoID(Long baseId);

    int insert(CodeInfo record);

    int insertSelective(CodeInfo record);

    CodeInfo selectByPrimaryKey(Long id);

    CodeInfo selectByBaseInfoID(Long baseId);

    int updateByPrimaryKeySelective(CodeInfo record);

    int updateByPrimaryKey(CodeInfo record);
}