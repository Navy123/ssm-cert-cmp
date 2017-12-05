package com.bupt.dao;

import com.bupt.entity.PatchInfo;
import com.bupt.entity.PatchInfoWithBLOBs;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PatchInfoMapper {
    int deleteByPrimaryKey(Long id);

    int deleteByBaseInfoID(Long baseId);

    int insert(PatchInfoWithBLOBs record);

    int insertSelective(PatchInfoWithBLOBs record);

    PatchInfoWithBLOBs selectByPrimaryKey(Long id);

    List<PatchInfoWithBLOBs> selectByBaseIDPagination(@Param("baseId") Long baseId, @Param("offset") Long offset, @Param("pageSize") int pageSize);

    long countTotalSizeByBaseID(@Param("baseId") Long baseId);

    int updateByPrimaryKeySelective(PatchInfoWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(PatchInfoWithBLOBs record);

    int updateByPrimaryKey(PatchInfo record);
}