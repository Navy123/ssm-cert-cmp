<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<table id="list-flaw-patch-data" cellspacing="0" cellpadding="0">
</table>
<script>
    $(function () {
        $('#list-flaw-patch-data').datagrid({
            iconCls:'icon-more',//图标
            width: 900,
            height: 'auto',
            loadMsg: '数据加载中,请稍候...',
            nowrap: true,
            striped: true,
            border: true,
            collapsible:false,//是否可折叠的
            fit: true,//自动大小
            url:"PatchInfoAjax/${baseId}",
            singleSelect:false,//是否单选
            pageSize: 10,//每页显示的记录条数，默认为10
            pageList: [10,15,20],//可以设置每页记录条数的列表
            pagination:true,//分页控件
            rownumbers:true,//行号
            fitColumns:true,//自动使列适应表格宽度以防止出现水平滚动。
            columns:[[
                {field:'id',title:'ID',width:20},
                {field:'baseId',title:'漏洞号',width:30},
                {field:'cveId',title:'CVE-ID',width:60},
                {field:'gmtCreate',title:'创建时间',
                    formatter:function(value,row,index){
                        var unixTimestamp = new Date(value);
                        return unixTimestamp.toLocaleString();
                    },width:70
                },
                {field:'gmtModified',title:'更新时间',
                    formatter:function(value,row,index){
                        var unixTimestamp = new Date(value);
                        return unixTimestamp.toLocaleString();
                    },width:70
                },
                {field:'description',title:'补丁描述',width:30,formatter: function(value,row,index){
                    value = modifiValue(value);
                    return '<span title='+value+'>'+value+'</span>';
                }},
                {field:'patchCode',title:'漏洞验证信息',width:50,formatter: function(value,row,index){
                    value = modifiValue(value);
                    return '<span title='+value+'>'+value+'</span>';
                }},
                {field:'reference',title:'漏洞poc链接',width:50,formatter: function(value,row,index){
                    value = modifiValue(value);
                    return '<span title='+value+'>'+value+'</span>';
                }}
            ]],
            frozenColumns:[[
                {field:'ck',checkbox:true}
            ]],
            toolbar: [{
                text:'查看',
                iconCls:'icon-tip',
                handler:function(){
                    showViewPatchDialog();
                }
            },'-',{
                text:'添加',
                iconCls:'icon-add',
                handler:function(){
                    showAddPatchDialog();
                }
            },'-',{
                text:'修改',
                iconCls:'icon-edit',
                handler:function(){
                    showEditPatchDialog();
                }
            },'-',{
                text:'删除',
                iconCls:'icon-remove',
                handler:function () {
                    submitDelPatchForm();
                }
            }]
        });
    })
    function showAddPatchDialog() {
        var row = $('#list_data_baseInfo').datagrid('getSelected');
        $("#form-add-patch-base").form('load',{
            'baseId':row['id'],
            'cveId':row['cveId']
        });
        $("#create-patch-dialog").dialog({
            title: '添加补丁',
            collapsible: true,
            minimizable: true,
            maximizable: true,
            resizable: true,
            closed: false,
            cache: false,
            modal: true,
            width: 600,
            height: 380,
            iconCls: 'icon-save',
            buttons: [{
                text: '确认',
                iconCls: 'icon-ok',
                handler: function () {
                    if($("#form-add-patch-base").form('validate')){
                        submitAddPatchForm();
                    }else {
                        $.messager.alert('提示','请按要求填写完表单！','info');
                    }
                }
            }, {
                text: '取消',
                iconCls:'icon-cancel',
                handler: function () {
                    closeDialog("#create-patch-dialog");
                    clearPatchFormData();
                }
            }],
            iconCls: 'icon-save',
            onResize: function () {
                $(this).dialog('center');
            }, onClose: function () {
                closeDialog("#create-patch-dialog");
                clearPatchFormData();
            }
        });
    }
    function showEditPatchDialog() {
        var row = $('#list-flaw-patch-data').datagrid('getSelected');
        var rows = $('#list-flaw-patch-data').datagrid('getChecked');
        if(rows!=null&&rows.length==1){
            $("#form-edit-patch-base").form('load',row);
            $("#edit-patch-dialog").dialog({
                title: '修改补丁',
                collapsible: true,
                minimizable: true,
                maximizable: true,
                resizable: true,
                closed: false,
                cache: false,
                modal: true,
                width: 600,
                height: 380,
                iconCls: 'icon-save',
                buttons: [{
                    text: '确认',
                    iconCls: 'icon-ok',
                    handler: function () {
                        if($("#form-edit-patch-base").form('validate')){
                            submitEditPatchForm();
                        }else {
                            $.messager.alert('提示','请按要求填写完表单！','info');
                        }
                    }
                }, {
                    text: '取消',
                    iconCls:'icon-cancel',
                    handler: function () {
                        closeDialog("#edit-patch-dialog");
                        clearPatchFormData();
                    }
                }],
                iconCls: 'icon-save',
                onResize: function () {
                    $(this).dialog('center');
                }, onClose: function () {
                    closeDialog("#edit-patch-dialog");
                    clearPatchFormData();
                }
            });
        }else{
            $.messager.alert('提示','请先选择一条记录！','info');
        }
    }
    function showViewPatchDialog(){
        var row = $('#list-flaw-patch-data').datagrid('getSelected');
        var rows = $('#list-flaw-patch-data').datagrid('getChecked');
        if(rows!=null&&rows.length==1){
            $("#form-view-patch-base").form('load',row);
            $("#view-patch-dialog").dialog({
                title: '查看补丁',
                collapsible: true,
                minimizable: true,
                maximizable: true,
                resizable: true,
                closed: false,
                cache: false,
                modal: true,
                width: 600,
                height: 380,
                iconCls: 'icon-save',
                onResize: function () {
                    $(this).dialog('center');
                }, onClose: function () {
                    closeDialog("#view-patch-dialog");
                    clearPatchFormData();
                }
            });
        }else{
            $.messager.alert('提示','请先选择一条记录！','info');
        }
    }
    function submitEditPatchForm(){
        var data = $("#form-edit-patch-base").serialize();
        $.ajax({
            type: 'POST',
            url: "editPatchInfoSubmit",
            data: data,
            success: function (data) {
                if(data=="success"){
                    closeDialog("#edit-patch-dialog");
                    $.messager.show({
                        title:'修改补丁',
                        msg:'补丁修改成功',
                        timeout:2000,
                        showType:'slide'
                    });
                    $("#list-flaw-patch-data").datagrid("reload"); //删除成功后 刷新页面
                }
            },
        });
    }
    function submitAddPatchForm() {
        var data = $("#form-add-patch-base").serialize();
        $.ajax({
            type: 'POST',
            url: "addPatchInfoSubmit",
            data: data,
            success: function (data) {
                if(data=="success"){
                    closeDialog("#create-patch-dialog");
                    $.messager.show({
                        title:'添加补丁',
                        msg:'补丁添加成功',
                        timeout:2000,
                        showType:'slide'
                    });
                    $("#list-flaw-patch-data").datagrid("reload"); //删除成功后 刷新页面
                }
            },
        });
    }
    function submitDelPatchForm() {
        //获取选中行的数据,返回的是数组
        //获取选中行的数据
        var selectRows = $("#list-flaw-patch-data").datagrid("getSelections");
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
                    url:"deletePatchesSubmit",
                    data: {
                        'patchIds':deleteIds,
                    },
                    success:function (data) {
                        if(data=="success"){
                            $.messager.alert('提示', '删除成功！','info');
                            $("#list-flaw-patch-data").datagrid("reload"); //删除成功后 刷新页面
                            $('#list-flaw-patch-data').datagrid('clearSelections');//清空选中项计数
                        }else{
                            $.messager.alert('提示信息', '删除失败，请联系管理员！', 'warning');
                        }
                    }
                });
            }
        });
    }
    function modifiValue(value) {
        if(value!=null&&value!=undefined){
            value = value.replace(/[\r\n]/g, "");
        }else {
            value=""
        }
        return value;
    }
</script>