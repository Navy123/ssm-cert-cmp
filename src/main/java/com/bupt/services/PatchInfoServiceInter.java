package com.bupt.services;

import com.bupt.entity.PatchInfoWithBLOBs;
import com.bupt.utils.PageModel;

/**
 * Created by hxg on 2017/9/8.
 */
public interface PatchInfoServiceInter {

    public PageModel selectByBaseIDPagination(Long baseId,Long pageNumber, int pageSize);

    public int savePatchInfo(PatchInfoWithBLOBs patchInfo);

    public int editPatchInfo(PatchInfoWithBLOBs patchInfo);

    public boolean deletePatchInfoes(String patchIds);

}
