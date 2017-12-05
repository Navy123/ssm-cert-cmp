package com.bupt.controller.admin;

import com.bupt.entity.*;
import com.bupt.pojo.FlawItem;
import com.bupt.services.*;
import com.bupt.utils.EasyDataGrid;
import com.bupt.utils.PageModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by hxg on 2017/9/8.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private FlawItemServiceInter flawItemService;
    @Autowired
    private BaseInfoServiceInter baseInfoService;
    @Autowired
    private CodeInfoServiceInter codeInfoService;
    @Autowired
    private FrameInfoServiceInter frameInfoService;
    @Autowired
    private LibInfoServiceInter libInfoService;
    @Autowired
    private AffectedProductServiceInter affectedProductService;
    @Autowired
    private PatchInfoServiceInter patchInfoService;

    /**
     * 日期转换
     * @param binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }

    /**
     * 后台首页
     * @return
     */
    @RequestMapping("/index")
    public String index(){
        return "admin/index";
    }

    /**
     * 漏洞基准列表页面
     * @return
     */
    @RequestMapping("/baseInfo")
    public String baseInfo(){
        return "admin/sheet/baseInfo";
    }

    /**
     * 漏洞基准列表页面分页查询-Ajax数据加载
     * @param page 页码
     * @param rows 页面大小
     * @return
     */
    @RequestMapping("/baseInfoAjax")
    @ResponseBody
    public EasyDataGrid baseInfoAjax(@RequestParam("page") long page,@RequestParam("rows") int rows){
        EasyDataGrid dataGrid = new EasyDataGrid();
        PageModel pageModel = baseInfoService.selectByPagination(page,rows);
        dataGrid.setTotal(pageModel.getTotalRecords());
        dataGrid.setRows(pageModel.getDatas());
        return dataGrid;
    }

    /**
     * 加载单条漏洞信息数据
     * @param id 漏洞ID
     * @return 漏洞数据信息
     */
    @RequestMapping("/flawItem/{id}")
    @ResponseBody
    public FlawItem flawItem(@PathVariable("id") long id){
        FlawItem flawItem = new FlawItem();
        BaseInfoWithBLOBs baseInfo = baseInfoService.selectByPrimaryKey(id);
        //CodeInfo codeInfo = codeInfoService.selectByBaseInfoID(id);
        //FrameInfo frameInfo = frameInfoService.selectByBaseInfoID(id);
        //LibInfo libInfo = libInfoService.selectByBaseInfoID(id);
        //AffectedProductWithBLOBs affectedProduct = affectedProductService.selectByBaseInfoID(id);
        flawItem.setBaseInfo(baseInfo);
        //flawItem.setCodeInfo(codeInfo);
        //flawItem.setFrameInfo(frameInfo);
        //flawItem.setLibInfo(libInfo);
        //flawItem.setAffectedProduct(affectedProduct);
        return flawItem;
    }

    /**
     * 添加一条漏洞信息数据
     * @param flawItem 从前台封装过来的漏洞实体类
     * @return
     */
    @RequestMapping(value="/addFlawItemSubmit",method= RequestMethod.POST)
    @ResponseBody
    public String addFlawItem(FlawItem flawItem){
        flawItemService.saveFlawItem(flawItem);
        return "success";
    }

    /**
     * 编辑一条漏洞信息数据
     * @param flawItem 从前台封装过来的修改后的漏洞实体类
     * @return
     */
    @RequestMapping(value="/editFlawItemSubmit",method= RequestMethod.POST)
    @ResponseBody
    public String editFlawItem(FlawItem flawItem){
        flawItemService.editFlawItem(flawItem);
        return "success";
    }

    /**
     * 删除一条漏洞信息数据
     * @param flawIds 从前台传过来的漏洞ID号
     * @return
     */
    @RequestMapping(value="/deleteFlawItemSubmit",method= RequestMethod.POST)
    @ResponseBody
    public String deleteFlawItemSubmit(@RequestParam("flawIds") String flawIds){
        flawItemService.deleteFlawItems(flawIds);
        return "success";
    }

    /**
     * 添加一条补丁信息
     * @param patchInfo  从前台封装过来的补丁实体类
     * @return
     */
    @RequestMapping(value="/addPatchInfoSubmit",method= RequestMethod.POST)
    @ResponseBody
    public String addPatchInfoSubmit(PatchInfoWithBLOBs patchInfo){
        patchInfoService.savePatchInfo(patchInfo);
        return "success";
    }

    /**
     * 编辑一条补丁信息
     * @param patchInfo 从前台封装过来的修改后的补丁实体类
     * @return
     */
    @RequestMapping(value="/editPatchInfoSubmit",method= RequestMethod.POST)
    @ResponseBody
    public String editPatchInfoSubmit(PatchInfoWithBLOBs patchInfo){
        patchInfoService.editPatchInfo(patchInfo);
        return "success";
    }

    /**
     * 删除一条补丁信息
     * @param patchIds 从前台传过来的补丁ID
     * @return
     */
    @RequestMapping(value="/deletePatchesSubmit",method= RequestMethod.POST)
    @ResponseBody
    public String deletePatchesSubmit(@RequestParam("patchIds") String patchIds){
        patchInfoService.deletePatchInfoes(patchIds);
        return "success";
    }

    /**
     * 加载受某漏洞影响的产品数据页面
     * @param baseID 漏洞ID
     * @param model
     * @return
     */
    @RequestMapping("/AffectedProduct/{baseID}")
    public String affectedProduct(@PathVariable("baseID") long baseID, Model model){
        AffectedProduct affectedProduct = affectedProductService.selectByBaseInfoID(baseID);
        model.addAttribute("affectedProduct",affectedProduct);
        return "admin/sheet/affectedProduct";
    }

    /**
     * 漏洞的补丁页面
     * @param baseId 漏洞ID
     * @param model
     * @returng
     */
    @RequestMapping("/PatchInfo/{baseId}")
    public String patchInfo(@PathVariable("baseId") long baseId, Model model){
        model.addAttribute("baseId",baseId);
        return "admin/sheet/patchInfo";
    }

    /**
     * 分页加载某漏洞的所有补丁列表--Ajax加载数据
     * @param baseId 漏洞ID
     * @param page 页码
     * @param rows 页面大小
     * @return
     */
    @RequestMapping("/PatchInfoAjax/{baseId}")
    @ResponseBody
    public EasyDataGrid patchInfoAjax(@PathVariable("baseId") long baseId,@RequestParam("page") long page,@RequestParam("rows") int rows){
        EasyDataGrid dataGrid = new EasyDataGrid();
        PageModel pageModel = patchInfoService.selectByBaseIDPagination(baseId,page,rows);
        dataGrid.setTotal(pageModel.getTotalRecords());
        dataGrid.setRows(pageModel.getDatas());
        return dataGrid;
    }
}