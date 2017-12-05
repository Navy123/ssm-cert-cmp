<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../../commons/tag.jsp"%>
<table id="list_data_baseInfo" cellspacing="0" cellpadding="0">
</table>
<script>

    $(function () {
        $('#list_data_baseInfo').datagrid({
            title:"漏洞库列表",
            iconCls:'icon-edit',//图标
            width: 900,
            height: 'auto',
            nowrap: false,
            striped: true,
            border: true,
            fix:true,
            collapsible:false,//是否可折叠的
            fit: true,//自动大小
            url:"baseInfoAjax",
            idField:'id',//Id标识，如果不设置会对后面的getSelections的值有影响。
            singleSelect:false,//是否单选
            pageSize: 15,//每页显示的记录条数，默认为10
            pageList: [15,20,30],//可以设置每页记录条数的列表
            pagination:true,//分页控件
            rownumbers:true,//行号
            fitColumns:true,//自动使列适应表格宽度以防止出现水平滚动。
            columns:[[
                {field:'id',title:'ID',width:30},
                {field:'cveId',title:'CVE-ID',width:50},
                {field:'gmtCreate',title:'创建时间',
                    formatter:function(value,row,index){
                        var unixTimestamp = new Date(value);
                        return unixTimestamp.toLocaleString();
                    },width:60
                },
                {field:'gmtModified',title:'更新时间',
                    formatter:function(value,row,index){
                        var unixTimestamp = new Date(value);
                        return unixTimestamp.toLocaleString();
                    },width:60
                },
                {field:'bugType',title:'漏洞类型',
                    formatter: function(value, row, index){
                        var tmp = "";
                        if(value.indexOf('lib'))
                            tmp += "lib库漏洞 ";
                        if(value.indexOf('code'))
                            tmp += "源码漏洞 ";
                        if(value.indexOf('frame'))
                            tmp += "框架漏洞 ";
                            return value;
                    },width:60
                },
                {field:'publishTime',title:'漏洞发布时间',
                    formatter:function(value,row,index){
                        var unixTimestamp = new Date(value);
                        return unixTimestamp.toLocaleDateString();
                    },width:40
                },
                {field:'modifiedTime',title:'漏洞修改时间',
                    formatter:function(value,row,index){
                        var unixTimestamp = new Date(value);
                        return unixTimestamp.toLocaleDateString();
                    },width:40
                },
                {field:'dangerLevel',title:'危险级别',
                    formatter: function(value, row, index){
                        if(value=='low')
                            return "低危漏洞";
                        if(value=='medium')
                            return "中危漏洞";
                        if(value=='high')
                            return "高危漏洞";
                        else
                            return "未知级别漏洞";
                    },width:30
                },
                {field:'isExistPatch',title:'补丁',
                    formatter: function(value, row, index){
                        if(value==1)
                            return "存在";
                        else
                            return "不存在";
                    },width:30
                },
                {field:'isExistProductList',title:'受影响产品',
                    formatter: function(value, row, index){
                        if(value==1)
                            return "存在";
                        else
                            return "不存在";
                    },width:30
                }
            ]],
            frozenColumns:[[
                {field:'ck',checkbox:true}
            ]],
            toolbar: [{
                text: '查看',
                iconCls: 'icon-tip',
                handler: function() {
                    openDialogFlaw("view-flaw-dialog","view");
                }
            }, '-', {
                text: '添加',
                iconCls: 'icon-add',
                handler: function() {
                    openDialogFlaw("add-flaw-dialog","add");
                }
            }, '-', {
                text: '修改',
                iconCls: 'icon-edit',
                handler: function() {
                    openDialogFlaw("edit-flaw-dialog","edit");registFlawPatchTab("edit");
                }
            }, '-',{
                text: '删除',
                iconCls: 'icon-remove',
                handler: function(){
                    submitDelFlawForm();
                }
            }]
        });

        $("#add-bugType-select").combobox({
            onChange:function (newValue,oldValue) {
                $("#form-add-flaw-detail>."+oldValue+"-info").remove();
                $("#form-add-flaw-detail").append($("#form-plugin>."+newValue+"-info").prop('outerHTML'));
                $("#form-add-flaw-detail>."+newValue+"-info").layout().css("display","block");
                $("#form-add-flaw-detail>."+newValue+"-info input").each(function () {
                    $(this).textbox();
                })
            }
        })

        $("#edit-bugType-select").combobox({
            onChange:function (newValue,oldValue) {
                $("#form-edit-flaw-detail>."+oldValue+"-info").remove();
                $("#form-edit-flaw-detail").append($("#form-plugin>."+newValue+"-info").prop('outerHTML'));
                $("#form-edit-flaw-detail>."+newValue+"-info").css("display","block");
                $("#form-edit-flaw-detail>."+newValue+"-info input").each(function () {
                    $(this).textbox();
                })
            }
        })

        $("#view-bugType-select").combobox({
            onChange:function (newValue,oldValue) {
                $("#form-view-flaw-detail>."+oldValue+"-info").css("display", "none");
                $("#form-view-flaw-detail>."+newValue+"-info").css("display","block");
                $("#view-flaw-content-tabs").tabs('select',0);
                $("#view-flaw-content-tabs").tabs('select',1);
            }
        })

        $(".more-info").css("display", "none");
    })


    function submitEditFlawForm() {
        var base = $("#form-edit-flaw-base").serialize();
        var detail = $("#form-edit-flaw-detail").serialize();
        var affectedProduct = $("#form-edit-flaw-affectedProduct").serialize();
        var newData=base+"&"+detail+"&"+affectedProduct;
        $.ajax({
            type: 'POST',
            url: "editFlawItemSubmit",
            data: newData,
            success: function (data) {
                if(data=="success"){
                    $.messager.show({
                        title:'修改漏洞',
                        msg:'漏洞修改成功',
                        timeout:2000,
                        showType:'slide'
                    });
                    $("#list_data_baseInfo").datagrid("reload"); //编辑成功后 刷新页面
                }
            },
        });
        closeDialog("#edit-flaw-dialog");
        clearFlawFormData();
        removeFlawPatchTab("edit");
    }
    function submitDelFlawForm() {
        //获取选中行的数据,返回的是数组
        //获取选中行的数据
        var selectRows = $("#list_data_baseInfo").datagrid("getSelections");
        //如果没有选中行的话，提示信息
        if (selectRows.length < 1) {
            $.messager.alert("提示消息", "请至少选择一条要删除的记录！", 'info');
            return;
        }
        //如果选中行了，则要进行判断
        $.messager.confirm("确认消息", "确定要删除所选的（"+selectRows.length+"）条记录吗？", function (deleteOk) {
            //如果为真的话
            if (deleteOk) {
                //定义变量值
                var deleteIds = "";
                //拼接字符串，这里也可以使用数组，作用一样
                for (var i = 0; i < selectRows.length; i++) {
                    deleteIds += selectRows[i].id + ",";
                }
                //循环切割
                deleteIds = deleteIds.substr(0, deleteIds.length - 1);
                $.ajax({
                    type: "POST",
                    url:"deleteFlawItemSubmit",
                    data: {
                        'flawIds':deleteIds,
                    },
                    success:function (data) {
                        if(data=="success"){
                            $.messager.alert('提示', '删除成功！','info');
                            $("#list_data_baseInfo").datagrid("reload"); //删除成功后 刷新页面
                            $('#list_data_baseInfo').datagrid('clearSelections');//清空选中项计数
                        }else{
                            $.messager.alert('提示信息', '删除失败，请联系管理员！', 'warning');
                        }
                    }
                });
            }
        });
    }

    function removeFlawPatchTab(type) {
        if($("#"+type+"-flaw-content-tabs").tabs('exists', 3)) {
            $("#"+type+"-flaw-content-tabs").tabs('close', 3);
        }
    }
    function registFlawPatchTab(type) {
        if ($("#"+type+"-flaw-content-tabs").tabs("exists", 3)) {
        }
        else {
            $("#"+type+"-flaw-content-tabs").tabs('add', {
                title: "<span class='tt-inner'><img src='${ctx}/assets/images/pda.png'/><br>漏洞补丁列表</span>",
                closable: false,
                tools: [
                    {
                        iconCls: 'icon-mini-refresh',
                        handler: function (e) {
                            var tab = $("#"+type+"-flaw-content-tabs").tabs('getSelected');
                            tab.panel('refresh');
                        }
                    }
                ],
            })
        }

        $("#"+type+"-flaw-content-tabs").tabs({
            border: false,
            onSelect: function (title, index) {
                if (title.indexOf('漏洞补丁列表') >= 0) {
                    if (flag_new_tag_dataList == 0) {
                        flag_new_tag_dataList++;
                        var tab = $("#"+type+"-flaw-content-tabs").tabs('getSelected');
                        $("#"+type+"-flaw-content-tabs").tabs("update", {
                            tab: tab,
                            options: {
                                href: "PatchInfo/" + baseID
                            }
                        });
                    } else {

                    }
                }
            }
        });
    }

    function openDialogFlaw(id,type) {
        var row = $('#list_data_baseInfo').datagrid('getSelected');
        var rows = $('#list_data_baseInfo').datagrid('getChecked');

        if(type=="add"){
            $("#"+id).dialog({
                title: '添加漏洞',
                collapsible:true,
                minimizable:true,
                maximizable:true,
                resizable:true,
                width:800,
                height:450,
                closed: false,
                cache: false,
                modal: true,
                iconCls: 'icon-save',
                buttons: [{
                    text:'确认',
                    iconCls:'icon-ok',
                    handler:function(){
                        if($("#form-add-flaw-base").form('validate')&&$("#form-add-flaw-detail").form('validate')&&$("#form-add-flaw-affectedProduct").form('validate')){
                            submitAddFlawForm();
                        }else {
                            $.messager.alert('提示','请按要求填写完表单！','info');
                        }
                    }
                },{
                    text:'取消',
                    iconCls:'icon-cancel',
                    handler:function(){
                        closeDialog("#add-flaw-dialog");
                        clearFlawFormData();
                    }
                }],
                iconCls:'icon-save',
                onResize:function(){
                    $(this).dialog('center');
                },onClose: function () {
                    closeDialog("#add-flaw-dialog");
                    clearFlawFormData();
                }
            });
            $("#form-add-flaw-base").form("clear");
            $("#form-add-flaw-detail").form("clear");
            $('#add-flaw-content-tabs').tabs('select',0);

        }
        else if(type=='edit'){
            if(rows!=null&&rows.length==1){
                baseID = row['id'];
                registFlawPatchTab(type);
                $.ajax({
                    type: "GET",
                    url: "flawItem/"+baseID,
                    dataType: "json",
                    success:function (data) {
                        $("#"+id).dialog({
                            title: '修改漏洞',
                            collapsible:true,
                            minimizable:true,
                            maximizable:true,
                            resizable:true,
                            width:800,
                            height:450,
                            closed: false,
                            cache: false,
                            modal: true,
                            iconCls: 'icon-save',
                            buttons: [{
                                text:'确认',
                                iconCls:'icon-ok',
                                handler:function(){
                                    if($("#form-edit-flaw-base").form('validate')&&$("#form-edit-flaw-detail").form('validate')&&$("#form-edit-flaw-affectedProduct").form('validate')){
                                        submitEditFlawForm();
                                    }else {
                                        $.messager.alert('提示','请按要求填写完表单！','info');
                                    }
                                }
                            },{
                                text:'取消',
                                iconCls:'icon-cancel',
                                handler:function(){
                                    closeDialog("#edit-flaw-dialog");
                                    clearFlawFormData();
                                    removeFlawPatchTab("edit");
                                }
                            }],
                            iconCls:'icon-save',
                            onResize:function(){
                                $(this).dialog('center');
                            },
                            onClose: function () {
                                closeDialog("#edit-flaw-dialog");
                                clearFlawFormData();
                                removeFlawPatchTab("edit");
                            }
                        });
                        fillData(data,'edit');
                        $('#edit-flaw-content-tabs').tabs('select',0);
                        $("#edit-flaw-dialog .easyui-textbox").each(function () {
                            $(this).textbox('textbox').attr('readonly',false);
                        })
                        $("#edit-flaw-dialog .easyui-combobox").each(function () {
                            $(this).combobox('readonly',false)
                        })
                        $("#edit-flaw-dialog .easyui-tagbox").each(function () {
                            $(this).tagbox('readonly', false);
                        })
                    }
                })
            }else{
                $.messager.alert('提示','请先选择一条记录！','info');
            }
        }
        else if(type=='view'){
            if(rows!=null&&rows.length==1){
                baseID = row['id'];
                registFlawPatchTab(type);
                $.ajax({
                    type: "GET",
                    url: "flawItem/"+baseID,
                    dataType: "json",
                    success:function (data) {
                        $("#"+id).dialog({
                            title: '查看漏洞',
                            collapsible:true,
                            minimizable:true,
                            maximizable:true,
                            resizable:true,
                            width:800,
                            height:450,
                            closed: false,
                            cache: false,
                            modal: true,
                            iconCls: 'icon-save',
                            onResize:function(){
                                $(this).dialog('center');
                            },
                            onClose: function () {
                                closeDialog("#view-flaw-dialog");
                                clearFlawFormData();
                                removeFlawPatchTab("view");
                            }
                        });
                        fillData(data,'view');
                        $('#view-flaw-content-tabs').tabs('select',0);
                        $("#view-flaw-dialog .easyui-textbox").each(function () {
                            $(this).textbox('textbox').attr('readonly',true);
                        })
                        $("#view-flaw-dialog .easyui-combobox").each(function () {
                            $(this).combobox('readonly',true)
                        })
                        $("#view-flaw-dialog .easyui-tagbox").each(function () {
                            $(this).tagbox('readonly', true);
                        })
                    }
                })
            }else{
                $.messager.alert('提示','请先选择一条记录！','info');
            }
        }
    }

</script>