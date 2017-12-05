package com.bupt.services.impl;

import com.bupt.dao.*;
import com.bupt.entity.*;
import com.bupt.pojo.FlawItem;
import com.bupt.services.FlawItemServiceInter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * Created by hxg on 2017/9/10.
 */
@Service
public class FlawItemServiceImpl implements FlawItemServiceInter {
    @Autowired
    private BaseInfoMapper baseInfoDao;
    @Autowired
    private CodeInfoMapper codeInfoDao;
    @Autowired
    private FrameInfoMapper frameInfoDao;
    @Autowired
    private LibInfoMapper libInfoDao;
    @Autowired
    private AffectedProductMapper affectedProductDao;
    @Autowired
    private PatchInfoMapper patchInfoDao;

    @Override
    public boolean saveFlawItem(FlawItem flawItem) {
        BaseInfoWithBLOBs baseInfo = flawItem.getBaseInfo();
        baseInfo.setGmtCreate(new Date(System.currentTimeMillis()));
        baseInfo.setGmtModified(new Date(System.currentTimeMillis()));
        baseInfo.setIsExistPatch(false);
        baseInfo.setIsExistProductList(false);
        baseInfo.setBugType("code");
        baseInfoDao.insert(baseInfo);

        if(baseInfo.getBugType().equals("code")){
            CodeInfo codeInfo = flawItem.getCodeInfo();
            codeInfo.setBaseId(baseInfo.getId());
            codeInfo.setCveId(baseInfo.getCveId());
            codeInfo.setInfluence("influence");
            codeInfoDao.insert(codeInfo);
        }
        if(baseInfo.getBugType().equals("frame")){
            FrameInfo frameInfo = flawItem.getFrameInfo();
            frameInfo.setBaseId(baseInfo.getId());
            frameInfo.setCveId(baseInfo.getCveId());
            frameInfo.setInfluence("influence");
            frameInfoDao.insert(frameInfo);
        }
        if(baseInfo.getBugType().equals("lib")){
            LibInfo libInfo = flawItem.getLibInfo();
            libInfo.setBaseId(baseInfo.getId());
            libInfo.setCveId(baseInfo.getCveId());
            libInfo.setGmtCreate(new Date(System.currentTimeMillis()));
            libInfo.setGmtModified(new Date(System.currentTimeMillis()));
            libInfoDao.insert(libInfo);
        }
        AffectedProductWithBLOBs affectedProduct = flawItem.getAffectedProduct();
        if(affectedProduct!=null){
            String os = affectedProduct.getAffectedOs();
            String soft = affectedProduct.getAffectedSoft();
            if(isEmpty(os)&&isEmpty(soft)){
                baseInfo.setIsExistProductList(false);
            }else {
                baseInfo.setIsExistProductList(true);
                affectedProduct.setBaseId(baseInfo.getId());
                affectedProduct.setCweId(baseInfo.getCveId());
                affectedProduct.setGmtCreate(new Date(System.currentTimeMillis()));
                affectedProduct.setGmtModified(new Date(System.currentTimeMillis()));
                affectedProductDao.insert(affectedProduct);
            }
        }
        baseInfoDao.updateByPrimaryKeyWithBLOBs(baseInfo);
        return true;
    }

    @Override
    public boolean editFlawItem(FlawItem flawItem) {
        BaseInfoWithBLOBs baseInfo = flawItem.getBaseInfo();
        baseInfo.setGmtModified(new Date(System.currentTimeMillis()));
        if(baseInfo.getBugType().equals("code")){
            CodeInfo codeInfo = flawItem.getCodeInfo();
            codeInfo.setInfluence("influence");
            if(codeInfo.getId()!=null){
                codeInfoDao.updateByPrimaryKeySelective(codeInfo);
            }else{
                codeInfo.setBaseId(baseInfo.getId());
                codeInfo.setCveId(baseInfo.getCveId());
                codeInfoDao.insert(codeInfo);
                frameInfoDao.deleteByBaseInfoID(baseInfo.getId());
                libInfoDao.deleteByBaseInfoID(baseInfo.getId());
            }
        }else if(baseInfo.getBugType().equals("frame")){
            FrameInfo frameInfo = flawItem.getFrameInfo();
            frameInfo.setInfluence("influence");
            if(frameInfo.getId()!=null) {
                frameInfoDao.updateByPrimaryKeySelective(frameInfo);
            }else {
                frameInfo.setBaseId(baseInfo.getId());
                frameInfo.setCveId(baseInfo.getCveId());
                frameInfoDao.insert(frameInfo);
                codeInfoDao.deleteByBaseInfoID(baseInfo.getId());
                libInfoDao.deleteByBaseInfoID(baseInfo.getId());
            }
        }else if(baseInfo.getBugType().equals("lib")){
            LibInfo libInfo = flawItem.getLibInfo();
            libInfo.setGmtModified(new Date(System.currentTimeMillis()));
            if(libInfo.getId()!=null) {
                libInfoDao.updateByPrimaryKeySelective(libInfo);
            }else {
                libInfo.setBaseId(baseInfo.getId());
                libInfo.setCveId(baseInfo.getCveId());
                libInfo.setGmtCreate(new Date(System.currentTimeMillis()));
                libInfoDao.insert(libInfo);
                codeInfoDao.deleteByBaseInfoID(baseInfo.getId());
                frameInfoDao.deleteByBaseInfoID(baseInfo.getId());
            }
        }
        AffectedProductWithBLOBs affectedProduct = flawItem.getAffectedProduct();
        if (affectedProduct!=null){
            baseInfo.setIsExistProductList(false);
            if(affectedProduct.getId()!=null){//更新
                baseInfo.setIsExistProductList(true);
                String os = affectedProduct.getAffectedOs();
                String soft = affectedProduct.getAffectedSoft();
                if(isEmpty(os)&&isEmpty(soft)){//表单输入为空
                    baseInfo.setIsExistProductList(false);
                }else {
                    AffectedProductWithBLOBs affectNew  = affectedProductDao.selectByPrimaryKey(affectedProduct.getId());
                    affectNew.setAffectedOs(affectedProduct.getAffectedOs());
                    affectNew.setAffectedSoft(affectedProduct.getAffectedSoft());
                    affectNew.setGmtModified(new Date(System.currentTimeMillis()));
                    affectedProductDao.updateByPrimaryKeyWithBLOBs(affectNew);
                }
            }else if(!isEmpty(affectedProduct.getAffectedOs())||!isEmpty(affectedProduct.getAffectedSoft())){//添加
                baseInfo.setIsExistProductList(true);
                affectedProduct.setBaseId(baseInfo.getId());
                affectedProduct.setCweId(baseInfo.getCveId());
                affectedProduct.setGmtCreate(new Date(System.currentTimeMillis()));
                affectedProduct.setGmtModified(new Date(System.currentTimeMillis()));
                affectedProductDao.insert(affectedProduct);
            }
        }
        baseInfoDao.updateByPrimaryKeySelective(baseInfo);
        return true;
    }

    @Override
    public boolean deleteFlawItems(String flawIds) {
        flawIds = flawIds.replaceAll("，",",");
        String[] ids = flawIds.split(",");
        for (String id:ids) {
            long baseInfoId = Long.parseLong(id);
            codeInfoDao.deleteByBaseInfoID(baseInfoId);
            frameInfoDao.deleteByBaseInfoID(baseInfoId);
            libInfoDao.deleteByBaseInfoID(baseInfoId);
            affectedProductDao.deleteByBaseInfoID(baseInfoId);
            patchInfoDao.deleteByBaseInfoID(baseInfoId);
            baseInfoDao.deleteByPrimaryKey(baseInfoId);
        }
        return true;
    }

    public boolean isEmpty(String src){
        if(src==null){
            return true;
        }else if(src.trim().equals("")){
            return true;
        }else{
            return false;
        }
    }
}
