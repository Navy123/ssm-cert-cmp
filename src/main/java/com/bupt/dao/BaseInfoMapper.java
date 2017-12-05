package com.bupt.dao;

import com.bupt.entity.BaseInfo;
import com.bupt.entity.BaseInfoWithBLOBs;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BaseInfoMapper {
    int deleteByPrimaryKey(Long id);

    int insert(BaseInfoWithBLOBs record);

    int insertSelective(BaseInfoWithBLOBs record);

    BaseInfoWithBLOBs selectByPrimaryKey(Long id);

    List<BaseInfoWithBLOBs> selectByPagination(@Param("offset") Long offset, @Param("pageSize") int pageSize);

    long countTotalSize();

    int updateByPrimaryKeySelective(BaseInfoWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(BaseInfoWithBLOBs record);

    int updateByPrimaryKey(BaseInfo record);
}