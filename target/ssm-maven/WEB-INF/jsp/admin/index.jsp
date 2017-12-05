<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commons/tag.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>漏洞库管理</title>
    <%@ include file="../commons/head.jsp"%>
    <style scoped="scoped">
        .tt-inner{
            display:inline-block;
            line-height:12px;
            padding-top:5px;
        }
        .tt-inner img{
            border:0;
        }
    </style>
</head>
<body id="admin-box" class="easyui-layout">

    <div data-options="region:'north'" style="height:60px">
        <div style="text-align: center">
            <h2>漏洞库管理</h2>
        </div>
    </div>
    <div data-options="region:'west',iconCls:'icon-blank',split:true" title="导航菜单" style="width:200px;">
        <div class="easyui-accordion">
            <div title="漏洞库"
                 data-options="selected:true,iconCls:'icon-edit'"
                 style="padding: 10px">
                <a
                        href="javascript:openTab(' 漏洞库管理','baseInfo','icon-tip')"
                        class="easyui-linkbutton"
                        data-options="plain:true,iconCls:'icon-ok'"
                        style="width: 150px;"> 漏洞库管理</a>
            </div>
        </div>
    </div>
    <div data-options="region:'center',iconCls:'icon-blank'">
        <div class="easyui-tabs" fit="true" border="false" id="content-tabs">

        </div>
    </div>
    <div id="form-plugin" hidden="hidden">
        <div class="easyui-layout more-info code-info">
            <div style="margin-bottom:20px">
                <input name="codeInfo.codePosition" style="width:96%" data-options="label:'源码位置:',required:true">
            </div>
            <div style="margin-bottom:20px">
                <input name="codeInfo.codeSection" style="width:96%;height:60px" data-options="label:'漏洞代码描述:',multiline:true">
            </div>
        </div>
        <div class="easyui-layout more-info frame-info">
            <div style="margin-bottom:20px">
                <input name="frameInfo.frameName" style="width:48%" data-options="label:'框架名:',required:true">
                <input name="frameInfo.frameType" style="width:48%" data-options="label:'框架类型:',required:true">
            </div>
            <div style="margin-bottom:20px">
                <input name="frameInfo.frameLanguage" style="width:96%" data-options="label:'框架语言:',required:true">
            </div>
        </div>
        <div class="easyui-layout more-info lib-info">
            <div style="margin-bottom:20px">
                <input name="libInfo.libName" style="width:48%" data-options="label:'lib库名称:',required:true">
                <input name="libInfo.libVersion" style="width:48%" data-options="label:'lib库版本号:',required:true">
            </div>
            <div style="margin-bottom:20px">
                <input name="libInfo.description" style="width:96%;height:60px" data-options="label:'lib库描述:',multiline:true">
            </div>
        </div>
    </div>
    <div id="add-flaw-dialog"  style="width:60%;height:80%;max-width:100%; max-height:100%;padding:1px">
        <div fit="true" class="easyui-tabs" data-options="tabWidth:100,tabHeight:60" border="false" id="add-flaw-content-tabs">
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/modem.png'/><br>漏洞基本信息</span>"  style="padding:10px;display:none;">
                <form id="form-add-flaw-base" class="easyui-form" method="post">
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.cveId" style="width:48%" data-options="label:'CVE-ID:',required:true">
                        <select class="easyui-combobox" name="baseInfo.dangerLevel" style="width:48%" data-options="label:'漏洞等级:',required:true">
                            <option value="low">低危漏洞</option>
                            <option value="middle">中危漏洞</option>
                            <option value="high">高危漏洞</option>
                        </select>
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-datebox" name="baseInfo.publishTime" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'漏洞发布时间:',required:true">
                        <input class="easyui-datebox" name="baseInfo.modifiedTime" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'漏洞修改时间:',required:true">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.reference" style="width:96%" data-options="label:'漏洞引用参考:',required:true">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.description" style="width:96%;height:60px" data-options="label:'漏洞描述:',multiline:true">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.solutionOpinion" style="width:96%;height:60px" data-options="label:'漏洞改进意见:',multiline:true">
                    </div>

                </form>
            </div>
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/scanner.png'/><br>漏洞具体信息</span>" style="padding:10px;display:none;">
                漏洞类型：
                <input type="checkbox"  name="ck" ><span class='tt-inner'>源码漏洞</span>
                <input type="checkbox" name="ck" ><span class='tt-inner'>框架漏洞</span>
                <input type="checkbox" name="ck" ><span class='tt-inner'>lib漏洞</span>
                    <%--<select id="add-bugType-select" class="easyui-combobox" name="baseInfo.bugType" style="width:98%" data-options="label:'漏洞类型:',required:true">
                        <option name="bugType" value="code">源码漏洞</option>
                        <option name="bugType"  value="frame">框架漏洞</option>
                        <option name="bugType" value="lib">lib漏洞</option>
                        <option name="bugType" value="other">其它漏洞</option>
                    </select>--%>
                </form>
            </div>
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/scanner.png'/><br>源码漏洞信息</span>" style="padding:10px;display:none;">
                <form id="form-add-flaw-code" class="easyui-form" method="post">
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="codeInfo.codePosition" style="width:96%" data-options="label:'源码位置:',required:false">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="codeInfo.codeSection" style="width:96%;height:60px" data-options="label:'漏洞代码描述:',multiline:true">
                    </div>
                        <%--<select id="add-bugType-select" class="easyui-combobox" name="baseInfo.bugType" style="width:98%" data-options="label:'漏洞类型:',required:true">
                            <option name="bugType" value="code">源码漏洞</option>
                            <option name="bugType"  value="frame">框架漏洞</option>
                            <option name="bugType" value="lib">lib漏洞</option>
                            <option name="bugType" value="other">其它漏洞</option>
                        </select>--%>
                </form>
            </div>
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/scanner.png'/><br>框架漏洞信息</span>" style="padding:10px;display:none;">
                <form id="form-add-flaw-frame" class="easyui-form" method="post">
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="frameInfo.frameName" style="width:48%" data-options="label:'框架名:',required:false">
                        <input class="easyui-textbox" name="frameInfo.frameType" style="width:48%" data-options="label:'框架类型:',required:false">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="frameInfo.frameLanguage" style="width:96%" data-options="label:'框架语言:',required:false">
                    </div>
                </form>
            </div>
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/scanner.png'/><br>lib漏洞信息</span>" style="padding:10px;display:none;">
                <form id="form-add-flaw-lib" class="easyui-form" method="post">
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="libInfo.libName" style="width:48%" data-options="label:'lib库名称:',required:false">
                        <input class="easyui-textbox" name="libInfo.libVersion" style="width:48%" data-options="label:'lib库版本号:',required:false">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="libInfo.description" style="width:96%;height:60px" data-options="label:'lib库描述:',multiline:true">
                    </div>
                </form>
            </div>
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/tablet.png'/><br>漏洞影响产品</span>" style="padding:10px;display:none;">
                <form id="form-add-flaw-affectedProduct" class="easyui-form" method="post">
                    <div class="easyui-layout affected-Product">
                        <div style="margin-bottom:20px">
                            <input class="easyui-tagbox"  id="add-affected-product-os" name="affectedProduct.affectedOs" style="width:100%;" data-options="label:'受影响的系统:'">
                        </div>
                        <div style="margin-bottom:20px">
                            <input class="easyui-tagbox" id="add-affected-product-soft" name="affectedProduct.affectedSoft" style="width:100%;" data-options="label:'受影响的软件:'">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="edit-flaw-dialog"  style="width:60%;height:80%;max-width:100%; max-height:100%;padding:1px">
        <div fit="true" class="easyui-tabs" data-options="tabWidth:100,tabHeight:60" border="false" id="edit-flaw-content-tabs">
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/modem.png'/><br>漏洞基本信息</span>"  style="padding:10px;display:none;">
                <form id="form-edit-flaw-base" class="easyui-form" method="post">
                    <div style="margin-bottom:20px">
                        <input type="hidden" name="baseInfo.id">
                        <input class="easyui-textbox" name="baseInfo.cveId" style="width:48%" data-options="label:'CVE-ID:',required:true">
                        <select class="easyui-combobox" name="baseInfo.dangerLevel" style="width:48%" data-options="label:'漏洞等级:',required:true">
                            <option value="low">低危漏洞</option>
                            <option value="middle">中危漏洞</option>
                            <option value="high">高危漏洞</option>
                        </select>
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-datebox" name="baseInfo.publishTime" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'漏洞发布时间:',required:true">
                        <input class="easyui-datebox" name="baseInfo.modifiedTime" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'漏洞修改时间:',required:true">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.reference" style="width:96%" data-options="label:'漏洞引用参考:',required:true">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.description" style="width:96%;height:60px" data-options="label:'漏洞描述:',multiline:true">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.solutionOpinion" style="width:96%;height:60px" data-options="label:'漏洞改进意见:',multiline:true">
                    </div>

                </form>
            </div>
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/scanner.png'/><br>漏洞详细信息</span>"  style="padding:10px;display:none;">
                <form id="form-edit-flaw-detail" class="easyui-form" method="post">
                    <div style="margin-bottom:20px">
                        <select id="edit-bugType-select" class="easyui-combobox" name="baseInfo.bugType" style="width:98%" data-options="label:'漏洞类型:',required:true">
                            <option name="bugType" value="code">源码漏洞</option>
                            <option name="bugType"  value="frame">框架漏洞</option>
                            <option name="bugType" value="lib">lib漏洞</option>
                            <option name="bugType" value="other">其它漏洞</option>
                        </select>
                        <input type="hidden" name="codeInfo.id">
                        <input type="hidden" name="frameInfo.id">
                        <input type="hidden" name="libInfo.id">
                    </div>
                </form>
            </div>
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/tablet.png'/><br>漏洞影响产品</span>" style="padding:10px;display:none;">
                <form id="form-edit-flaw-affectedProduct" class="easyui-form" method="post">
                    <div class="easyui-layout affected-Product">
                        <div style="margin-bottom:20px">
                            <input type="hidden" name="affectedProduct.id">
                            <input class="easyui-tagbox" id="edit-affected-product-os" name="affectedProduct.affectedOs" style="width:100%;" data-options="label:'受影响的系统:'">
                        </div>
                        <div style="margin-bottom:20px">
                            <input class="easyui-tagbox" id="edit-affected-product-soft"  name="affectedProduct.affectedSoft" style="width:100%;" data-options="label:'受影响的软件:'">
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
    <div id="view-flaw-dialog"  style="width:60%;height:80%;max-width:100%; max-height:100%;padding:1px">
        <div fit="true" class="easyui-tabs" data-options="tabWidth:100,tabHeight:60" border="false" id="view-flaw-content-tabs">
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/modem.png'/><br>漏洞基本信息</span>"  style="padding:10px;display:none;">
                <form id="form-view-flaw-base" class="easyui-form" method="post">
                    <div style="margin-bottom:20px">
                        <input type="hidden" name="baseInfo.id">
                        <input class="easyui-textbox" name="baseInfo.cveId" style="width:48%" data-options="label:'CVE-ID:',required:true">
                        <select class="easyui-combobox" name="baseInfo.dangerLevel" style="width:48%" data-options="label:'漏洞等级:',required:true">
                            <option value="low">低危漏洞</option>
                            <option value="middle">中危漏洞</option>
                            <option value="high">高危漏洞</option>
                        </select>
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-datebox" name="baseInfo.publishTime" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'漏洞发布时间:',required:true">
                        <input class="easyui-datebox" name="baseInfo.modifiedTime" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'漏洞修改时间:',required:true">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.reference" style="width:96%" data-options="label:'漏洞引用参考:',required:true">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.description" style="width:96%;height:60px" data-options="label:'漏洞描述:',multiline:true">
                    </div>
                    <div style="margin-bottom:20px">
                        <input class="easyui-textbox" name="baseInfo.solutionOpinion" style="width:96%;height:60px" data-options="label:'漏洞改进意见:',multiline:true">
                    </div>

                </form>
            </div>
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/scanner.png'/><br>漏洞详细信息</span>"  style="padding:10px;display:none;">
                <form id="form-view-flaw-detail" class="easyui-form" method="post">
                    <div style="margin-bottom:20px">
                        <select id="view-bugType-select" class="easyui-combobox" name="baseInfo.bugType" style="width:98%" data-options="label:'漏洞类型:',required:true">
                            <option name="bugType" value="code">源码漏洞</option>
                            <option name="bugType"  value="frame">框架漏洞</option>
                            <option name="bugType" value="lib">lib漏洞</option>
                            <option name="bugType" value="other">其它漏洞</option>
                        </select>
                    </div>
                    <div class="easyui-layout more-info code-info">
                        <div style="margin-bottom:20px">
                            <input type="hidden" name="codeInfo.id">
                            <input class="easyui-textbox" name="codeInfo.codePosition" style="width:96%" data-options="label:'源码位置:',required:true">
                        </div>
                        <div style="margin-bottom:20px">
                            <input class="easyui-textbox" name="codeInfo.codeSection" style="width:96%;height:60px" data-options="label:'漏洞代码描述:',multiline:true">
                        </div>
                    </div>
                    <div class="easyui-layout more-info frame-info">
                        <div style="margin-bottom:20px">
                            <input type="hidden" name="frameInfo.id">
                            <input class="easyui-textbox" name="frameInfo.frameName" style="width:48%" data-options="label:'框架名:',required:true">
                            <input class="easyui-textbox" name="frameInfo.frameType" style="width:48%" data-options="label:'框架类型:',required:true">
                        </div>
                        <div style="margin-bottom:20px">
                            <input class="easyui-textbox" name="frameInfo.frameLanguage" style="width:96%" data-options="label:'框架语言:',required:true">
                        </div>
                    </div>
                    <div class="easyui-layout more-info lib-info">
                        <div style="margin-bottom:20px">
                            <input type="hidden" name="libInfo.id">
                            <input class="easyui-textbox" name="libInfo.libName" style="width:48%" data-options="label:'lib库名称:',required:true">
                            <input class="easyui-textbox" name="libInfo.libVersion" style="width:48%" data-options="label:'lib库版本号:',required:true">
                        </div>
                        <div style="margin-bottom:20px">
                            <input class="easyui-textbox" name="libInfo.description" style="width:96%;height:60px" data-options="label:'lib库描述:',multiline:true">
                        </div>
                    </div>
                </form>
            </div>
            <div title="<span class='tt-inner'><img src='${ctx}/assets/images/tablet.png'/><br>漏洞影响产品</span>" style="padding:10px;display:none;">
                <form id="form-view-flaw-affectedProduct" class="easyui-form" method="post">
                    <div class="easyui-layout affected-Product">
                        <div style="margin-bottom:20px">
                            <input type="hidden" name="affectedProduct.id">
                            <input class="easyui-tagbox" id="view-affected-product-os" name="affectedProduct.affectedOs" style="width:100%;" data-options="label:'受影响的系统:'">
                        </div>
                        <div style="margin-bottom:20px">
                            <input class="easyui-tagbox" id="view-affected-product-soft"  name="affectedProduct.affectedSoft" style="width:100%;" data-options="label:'受影响的软件:'">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="create-patch-dialog"  style="width:60%;height:60%;max-width:80%; max-height:80%;padding:10px">
        <form id="form-add-patch-base" class="easyui-form" method="post">
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" readonly name="baseId" style="width:48%" data-options="label:'所属漏洞ID:',required:true" editable="false">
                <input class="easyui-textbox" readonly name="cveId" style="width:48%" data-options="label:'CVE-ID:',required:true" editable="false">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-datebox" name="gmtCreate" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'补丁发布时间:',required:true">
                <input class="easyui-datebox" name="gmtModified" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'补丁修改时间:',required:true">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="reference" style="width:96%" data-options="label:'漏洞poc链接:',required:false">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="description" style="width:96%;height:60px" data-options="label:'补丁描述:',multiline:true">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" name="patchCode" style="width:96%;height:60px" data-options="label:'验证信息:',multiline:true">
            </div>
        </form>
    </div>
    <div id="edit-patch-dialog"  style="width:60%;height:60%;max-width:80%; max-height:80%;padding:10px">
        <form id="form-edit-patch-base" class="easyui-form" method="post">
            <div style="margin-bottom:20px">
                <input type="hidden" name="id">
                <input class="easyui-textbox" readonly name="baseId" style="width:48%" data-options="label:'所属漏洞ID:',required:true" editable="false">
                <input class="easyui-textbox" readonly name="cveId" style="width:48%" data-options="label:'CVE-ID:',required:true" editable="false">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-datebox" name="gmtCreate" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'补丁发布时间:',required:true">
                <input class="easyui-datebox" name="gmtModified" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'补丁修改时间:',required:true">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="reference" style="width:96%" data-options="label:'漏洞poc链接:',required:false">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="description" style="width:96%;height:60px" data-options="label:'补丁描述:',multiline:true">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" name="patchCode" style="width:96%;height:60px" data-options="label:'验证信息:',multiline:true">
            </div>
        </form>
    </div>
    <div id="view-patch-dialog"  style="width:60%;height:60%;max-width:80%; max-height:80%;padding:10px">
        <form id="form-view-patch-base" class="easyui-form" method="post">
            <div style="margin-bottom:20px">
                <input type="hidden" name="id">
                <input class="easyui-textbox" readonly name="baseId" style="width:48%" data-options="label:'所属漏洞ID:',required:true" editable="false">
                <input class="easyui-textbox" readonly name="cveId" style="width:48%" data-options="label:'CVE-ID:',required:true" editable="false">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-datebox" name="gmtCreate" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'补丁发布时间:',required:true" editable="false">
                <input class="easyui-datebox" name="gmtModified" style="width:48%" data-options="formatter:myformatter,parser:myparser,label:'补丁修改时间:',required:true" editable="false">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="reference" style="width:96%" data-options="label:'漏洞poc链接:',required:false" editable="false">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="description" style="width:96%;height:60px" data-options="label:'补丁描述:',multiline:true" editable="false">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" name="patchCode" style="width:96%;height:60px" data-options="label:'验证信息:',multiline:true" editable="false">
            </div>
        </form>
    </div>
</body>
<script type="text/javascript">
    var baseID;
    var flag_new_tag_dataList=0;

    $(function () {
        $("#admin-box").layout({
            fit:true
        })

        $("#add-flaw-dialog").dialog({
            closed: true,
        })

        $("#edit-flaw-dialog").dialog({
            closed: true,
        })

        $("#view-flaw-dialog").dialog({
            closed: true,
        })

        $("#create-patch-dialog").dialog({
            closed: true,
        })

        $("#edit-patch-dialog").dialog({
            closed: true,
        })

        $("#view-patch-dialog").dialog({
            closed: true,
        })
    })

    function submitAddFlawForm() {
        var base = $("#form-add-flaw-base").serialize();
        var code = $("#form-add-flaw-code").serialize();
        var frame = $("#form-add-flaw-frame").serialize();
        var lib = $("#form-add-flaw-lib").serialize();
        var affectedProduct = $("#form-add-flaw-affectedProduct").serialize();
        var newData=base+"&"+code+"&"+frame +"&"+ lib +"&"+affectedProduct;
        $.ajax({
            type: 'POST',
            url: "addFlawItemSubmit",
            data: newData,
            success: function (data) {
                if(data=="success"){
                    closeDialog("#add-flaw-dialog");
                    $.messager.show({
                        title:'添加漏洞',
                        msg:'漏洞添加成功',
                        timeout:2000,
                        showType:'slide'
                    });
                    $("#list_data_baseInfo").datagrid("reload"); //添加成功后 刷新页面
                }
            },
        });
    }
    function formatTag(tagText){
        if(tagText!=null){
            tagText = tagText.replace("，",",");
            tagText = tagText.split(",");
        }else {
            tagText = "";
        }
        return tagText;
    }

    function myformatter(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    }
    function myparser(s){
        if (!s) return new Date();
        else return new Date(s);
    }

    function fillData(data,type) {
        $("#form-"+type+"-flaw-base").form('load',{
            'baseInfo.id':data.baseInfo.id,
            'baseInfo.cveId':data.baseInfo.cveId,
            'baseInfo.publishTime':data.baseInfo.publishTime,
            'baseInfo.modifiedTime':data.baseInfo.modifiedTime,
            'baseInfo.dangerLevel':data.baseInfo.dangerLevel,
            'baseInfo.reference':data.baseInfo.reference,
            'baseInfo.description':data.baseInfo.description,
            'baseInfo.solutionOpinion':data.baseInfo.solutionOpinion,
        });
        $("#form-"+type+"-flaw-detail").form('load',{
            'baseInfo.bugType':data.baseInfo.bugType,
        });
        $("#form-"+type+"-flaw-detail>."+data.baseInfo.bugType+"-info").css("display","block");
        if(data.baseInfo.bugType=='code'){
            $("#form-"+type+"-flaw-detail").form('load',{
                'codeInfo.id':data.codeInfo.id,
                'codeInfo.codePosition':data.codeInfo.codePosition,
                'codeInfo.codeSection':data.codeInfo.codeSection,
                'codeInfo.influence':data.codeInfo.influence,
            });
        }
        else if(data.baseInfo.bugType=='frame'){
            $("#form-"+type+"-flaw-detail").form('load',{
                'frameInfo.id':data.frameInfo.id,
                'frameInfo.frameName':data.frameInfo.frameName,
                'frameInfo.frameType':data.frameInfo.frameType,
                'frameInfo.frameLanguage':data.frameInfo.frameLanguage,
                'frameInfo.influence':data.frameInfo.influence,
            });
        }
        else if(data.baseInfo.bugType=='lib'){
            $("#form-"+type+"-flaw-detail").form('load',{
                'libInfo.id':data.libInfo.id,
                'libInfo.libName':data.libInfo.libName,
                'libInfo.libVersion':data.libInfo.libVersion,
                'libInfo.description':data.libInfo.description,
            });
        }
        else if(data.baseInfo.bugType=='other'){
        }
        if(data.affectedProduct!=null){
            os = data.affectedProduct.affectedOs;
            soft = data.affectedProduct.affectedSoft;
            os = formatTag(os);
            soft = formatTag(soft);
            if(os!=null){
                $("#"+type+"-affected-product-os").tagbox({
                    value: os
                })
            }
            if(soft!=null) {
                $("#"+type+"-affected-product-soft").tagbox({
                    value: soft
                })
            }
            $("#form-"+type+"-flaw-affectedProduct").form('load',{
                'affectedProduct.id':data.affectedProduct.id,
            });
        }
    }

    function openTab(title, url, icon) {
        if ($("#content-tabs").tabs("exists", title)) {
            $("#content-tabs").tabs("close", title);
            addTab(title, url, icon);
            $("#content-tabs").tabs("select", title);
        } else {
            addTab(title, url, icon);
        }
    }
    function addTab(title,url,icon) {
        $("#content-tabs").tabs("add", {
            title: title,
            closable: true,
            iconCls:icon,
            tools: [
                {
                    iconCls: 'icon-mini-refresh',
                    handler: function (e) {
                        var tab = $('#content-tabs').tabs('getSelected');
                        tab.panel('refresh');
                    }
                }
            ],
            href:url
        });
    }

    function closeDialog(dialogID) {
        $(dialogID).dialog({
            closed: true
        })
    }

    function clearPatchFormData() {
        $("#form-add-patch-base").form("clear");
        $("#form-edit-patch-base").form("clear");
        $("#form-view-patch-base").form("clear");
    }
    function clearFlawFormData() {
        $("#form-add-flaw-base").form("clear");
        $("#form-add-flaw-detail").form("clear");
        $("#form-add-flaw-affectedProduct").form("clear");
        $("#form-edit-flaw-base").form("clear");
        $("#form-edit-flaw-detail").form("clear");
        $("#form-edit-flaw-affectedProduct").form("clear");
        flag_new_tag_dataList = 0;
    }
</script>
</html>
