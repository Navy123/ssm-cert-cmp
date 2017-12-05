package com.bupt.services.impl;

import com.bupt.dao.BaseInfoMapper;
import com.bupt.dao.PatchInfoMapper;
import com.bupt.entity.BaseInfoWithBLOBs;
import com.bupt.entity.PatchInfoWithBLOBs;
import com.bupt.services.PatchInfoServiceInter;
import com.bupt.utils.PageModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by hxg on 2017/9/8.
 */
@Service
public class PatchInfoServiceImpl implements PatchInfoServiceInter {
    @Autowired
    private PatchInfoMapper patchInfoDao;
    @Autowired
    private BaseInfoMapper baseInfoDao;

    @Override
    public PageModel selectByBaseIDPagination(Long baseId, Long pageNumber, int pageSize) {
        PageModel pageModel = new PageModel();
        pageModel.setCurrentPage(pageNumber);
        pageModel.setPageSize(pageSize);
        long totalRecords = patchInfoDao.countTotalSizeByBaseID(baseId);
        pageModel.setTotalRecords(totalRecords);
        if(totalRecords==0){
            BaseInfoWithBLOBs baseInfo = baseInfoDao.selectByPrimaryKey(baseId);
            baseInfo.setIsExistPatch(false);
            baseInfoDao.updateByPrimaryKeyWithBLOBs(baseInfo);
        }
        long offset = (pageNumber-1)*pageSize;
        List<PatchInfoWithBLOBs> list =  patchInfoDao.selectByBaseIDPagination(baseId,offset,pageSize);
        pageModel.setDatas(list);
        return pageModel;
    }

    @Override
    public int savePatchInfo(PatchInfoWithBLOBs patchInfo) {
        BaseInfoWithBLOBs baseInfo = baseInfoDao.selectByPrimaryKey(patchInfo.getBaseId());
        if(baseInfo.getIsExistPatch()==false){
            baseInfo.setIsExistPatch(true);
            baseInfoDao.updateByPrimaryKeyWithBLOBs(baseInfo);
        }
        return patchInfoDao.insert(patchInfo);
    }

    @Override
    public int editPatchInfo(PatchInfoWithBLOBs patchInfo) {
        patchInfo.setGmtModified(new Date(System.currentTimeMillis()));
        return patchInfoDao.updateByPrimaryKeyWithBLOBs(patchInfo);
    }

    @Override
    public boolean deletePatchInfoes(String patchIds) {
        patchIds = patchIds.replaceAll("，",",");
        String[] ids = patchIds.split(",");
        for (String id:ids) {
            long patchId = Long.parseLong(id);
            patchInfoDao.deleteByPrimaryKey(patchId);
        }
        return true;
    }
}
