<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>复选框</title>
    <script type="text/javascript" src="../dialogs/internal_form.js"></script>
    <script type="text/javascript" src="<%=contextPath %>/js/custom/jquery.propertygrid.js"></script>
    <script type="text/javascript">
    	var bizid = parent.$('#bizid').val();
	    var prop = {"rows":[
            {"name":"字段名称","id":"zt_columnname","value":"","group":"业务对象属性","editor":{
         		"type":"combobox",
         		"options":{
         		    "url":'<%=request.getContextPath() %>/bizobj.do?method=listbizfield&bizid='+bizid,
         		    "valueField":'columnname',
         		    "textField":'displayname',
         		    "panelHeight":'auto',
         		    "editable":false,
    			    onSelect: function(rec){
    			        var edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_id,field:'value'});
    			        $(edobj.target).textbox('setValue',rec.columnname);
    		        }
         		}
         	}},
         	{"name":"ID","id":"zt_id","value":"","group":"业务对象属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}},
         	{"name":"默认值","id":"zt_initvalue","value":"","group":"业务对象属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}}
		]};
	    
	    var proploaded = false;
	    var propmap;
	    $(document).ready(function(){
	    	
	    	$("#dg").propertygrid({
                data:prop,
                method: 'get',
                showGroup: true,
                scrollbarSize: 0,
                border:false,
                columns:[[
        			{field:'name',title:'属性',width:60},
        			{field:'value',title:'值',width:100}
    			]],onLoadSuccess:function(data){
    				var str = "";
					var rowlength = data.rows.length;
					for(var i=0;i<rowlength;i++){
						$('#dg').propertygrid('beginEdit',i);//开启编辑
						if(i>0){
							str += ",";
						}
						str += "\""+data.rows[i].id+"\":"+i;
					}
					propmap = jQuery.parseJSON("{"+str+"}");
					proploaded = true;
    			}
	    	});

			$('#tt').datagrid({
				width:'100%',
				singleSelect:false,
				toolbar:'#tb',
				singleSelect:true,
				columns:[[
					{field:'ck',checkbox:true},
					{field:'text',title:'文本',width:105,editor:{   
							type: 'textbox',
							options:{
								required:true,
								validType:{length:[1,50]}
							}
						} 
					},
					{field:'value',title:'值',width:105,editor:{   
							type: 'textbox',
							options:{
								required:true,
								validType:{length:[1,50]}
							}
						}
					}
				]],
				onClickCell:function(index, field){
				},
				onCheck:function(index,row){
					curindex = index;
				},
				onUncheck:function(index,row){
					curindex = index;
				}
				,onLoadSuccess:function(data){
				}
			});
	    	
	    });
    </script>
</head>
<body style="margin:0;padding:0;" >

	<table id="dg" style="width:255px"></table>
	<table id="tt"></table>
	<div id="tb" style="padding:2px 5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="addItem()" />添加</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="activeItem()" />生效</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="delItem()">删除</a>
		<a href="#" class="easyui-linkbutton" onclick="moveup()" />上</a>
        <a href="#" class="easyui-linkbutton" onclick="movedown()">下</a>
   	</div>
	<script type="text/javascript">
	
		var lastindex;
		var curindex;
		var nextindex;
		
		var oNode = null,thePlugins = 'checkboxs';
	
		function oncancel () {
		    if( UE.plugins[thePlugins].editdom ) {
		        delete UE.plugins[thePlugins].editdom;
		    }
		}
		
		function onok (){
			
			var ed;
	
			ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_id,field:'value'});
	        $(oNode).prop('id',$(ed.target).textbox('getValue'));

			ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_columnname,field:'value'});
	        $(oNode).attr('name',$(ed.target).combobox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
	        $(oNode).attr('value',$(ed.target).textbox('getValue'));
	        
	        delete UE.plugins[thePlugins].editdom;
		    
		};
		
		function init(){
			
			if(proploaded){
				
			    if( UE.plugins[thePlugins].editdom ){
			        oNode = UE.plugins[thePlugins].editdom;
		    		var ed;
		    		
		    		var gID = $(oNode).prop('id');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_id,field:'value'});
		    		$(ed.target).textbox('setValue', gID);

		    		var gName = $(oNode).attr('name');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_columnname,field:'value'});
		    		$(ed.target).combobox('setValue', gName);

		    		var gValue = $(oNode).attr('value');
			        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
			        if(gValue && gValue != ""){
		    			$(ed.target).textbox('setValue', gValue);
		    		}
		    		var chks = $(oNode).find("input");
		    		for(var i=0;i<chks.length;i++){
		    			if(oNode.childNodes[2*i+1].nodeType == 3){
		    				addNewItem(oNode.childNodes[2*i+1].nodeValue,$(chks[i]).val());
		    			}
		    		}
		    		
		    		activeOK();
			    };
			}else{
				windwo.setTimeout(init,200);
			}
		}
		
		
		function activeOK(){
			var rows = $('#dg').propertygrid('getRows');
			for(var i=0;i<rows.length;i++){
				var ed = $('#dg').propertygrid('getEditor',{index:i,field:'value'});
				
				if(ed.type == "textbox"){
				    $(ed.target).textbox({
				    	onChange:function(newValue,oldValue){
				    		onok();
				    	}
				    });
				}else if(ed.type == "numberbox"){
				    $(ed.target).numberbox({
				    	onChange:function(newValue,oldValue){
				    		onok();
				    	}
				    });
				}else if(ed.type == "checkbox"){
					$(ed.target).bind("click",function(){
						onok();
					});
				}
			}
		}
		
		function addNewItem(text,value){
			var index=$('#tt').datagrid('appendRow', {
				text: text,
				value: value
            }).datagrid('getRows').length-1;
			$('#tt').datagrid('beginEdit',index);
		}
		
		function addItem(){
			var index=$('#tt').datagrid('appendRow', {
				text: '',
				value: ''
            }).datagrid('getRows').length-1;
			$('#tt').datagrid('beginEdit',index);
		}
		
		function delItem(){
			var enums = $('#tt').datagrid('getChecked');
			for(var i=(enums.length-1);i>=0;i--){
				$('#tt').datagrid('deleteRow',$('#tt').datagrid('getRowIndex',enums[i]));
			}
		}
		
		function activeItem(){
			if(validEdit()){
				$(oNode).empty();
				
				var ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_columnname,field:'value'});
				
				var rows = $("#tt").datagrid('getRows');
				for(var i=0;i<rows.length;i++){
					var texted = $('#tt').datagrid('getEditor', {index:i,field:'text'});
					var valueed = $('#tt').datagrid('getEditor', {index:i,field:'value'});
					var opt = $("<input name='"+$(ed.target).combobox('getValue')+"' value='"+$(valueed.target).textbox('getValue')+"' type='checkbox' style='margin-right:2px' />");
					$(oNode).append(opt);
					$(oNode).append($(texted.target).textbox('getValue'));
				}
		        delete UE.plugins[thePlugins].editdom; 
			}
		}

		function validEdit(){
			var valid = true;
	       	var rows = $('#tt').datagrid('getRows');
	       	for ( var i = 0; i < rows.length; i++) {
	    	   	if(!$('#tt').datagrid('validateRow',i)){
	    		   valid = false;
	    		   break;
	    	   	}
	       	}
	       	return valid;
		}

		function endEdit(){
			var valid = true;
	       	var rows = $('#tt').datagrid('getRows');
	       	for ( var i = 0; i < rows.length; i++) {
	    	   	if(!$('#tt').datagrid('validateRow',i)){
	    		   valid = false;
	    		   break;
	    	   	}
	    	   	$('#tt').datagrid('endEdit', i);
	       	}
	       	return valid;
		}
  		
		var editIndex = undefined;
        function endEditing(){
            if (editIndex == undefined){
            	return true;
            }
            if ($('#tt').datagrid('validateRow', editIndex)){
                $('#tt').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }

      //上移
        function moveup(){
    		var row = $("#tt").datagrid('getSelected');
    		var index = $("#tt").datagrid('getRowIndex', row);
    		mysort(index, 'up', 'tt');
    	}
    	
    	//下移
    	function movedown(){
    		var row = $("#tt").datagrid('getSelected');
    		var index = $("#tt").datagrid('getRowIndex', row);
    		mysort(index, 'down', 'tt');
    	}
    	
    	function mysort(index,type,gridname){
    		if(validEdit()){
        		if ("up" == type){
        			if (index != 0){
        				var toup = getRow(index);
        				var todown = getRow(index-1);
        				$('#' + gridname).datagrid('endEdit', index);
        				$('#' + gridname).datagrid('deleteRow', index);
        				$('#' + gridname).datagrid('insertRow', {index:(index-1),row:toup});
        				$('#' + gridname).datagrid('beginEdit', index - 1);
        				$('#' + gridname).datagrid('checkRow', index - 1);
        			}
        		}else if ("down" == type){
        			var rows = $('#' + gridname).datagrid('getRows').length;
        			if (index != rows - 1){
        				var todown = getRow(index);
        				var toup = getRow(index+1);
        				$('#' + gridname).datagrid('endEdit', index+1);
        				$('#' + gridname).datagrid('deleteRow', index+1);
        				$('#' + gridname).datagrid('insertRow', {index:(index),row:toup});
        				$('#' + gridname).datagrid('beginEdit', index);
        				$('#' + gridname).datagrid('checkRow', index+1);
        			}
        		}
    		}
    	}
        
    	function getRow(index){
    		var rows = $('#tt').datagrid('getRows');
    		for(var i=0;i<rows.length;i++){
    			if(index == i){
    				return rows[i];
    			}
    		}
    	}
    	
		$(document).ready(function(){
			init(); 
		});    
	</script>
</body>
</html>