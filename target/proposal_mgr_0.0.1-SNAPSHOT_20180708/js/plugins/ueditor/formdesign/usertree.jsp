<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<%
 String bizid=request.getParameter("listbizid");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户控件</title>
    <script type="text/javascript" src="../dialogs/internal_form.js"></script>
    <script type="text/javascript" src="<%=contextPath %>/js/custom/jquery.propertygrid.js"></script>
    <script type="text/javascript">
    	var bizid = parent.$('#bizid').val();
    	if('<%=bizid %>' != 'null'){
    		bizid='<%=bizid %>';
    	}    	
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
    			        
    			        edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_id,field:'value'});
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
         	{"name":"根节点ID","id":"zt_rootid","value":"","group":"业务对象属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}},
         	{"name":"是否必填","id":"zt_required","value":"false","group":"业务对象属性","editor":{
         		"type":"checkbox",
         		"options":{
         			"on":true,
         			"off":false
         		}
         	}},
         	{"name":"是否多选","id":"zt_singleselect","value":"true","group":"独立属性","editor":{
         		"type":"checkbox",
         		"options":{
         			"on":true,
         			"off":false
         		}
         	}},
         	{"name":"名称字段","id":"zt_namefield","value":"","group":"独立属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}},
         	{"name":"标识字段","id":"zt_idfield","value":"","group":"独立属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}},
         	{"name":"按钮形式","id":"isbutton","value":"false","group":"独立属性","editor":{
         		"type":"checkbox",
         		"options":{
         			"on":true,
         			"off":false
         		}
         	}},
         	{"name":"对齐方式","id":"style_textalign","value":"left","group":"共用属性","editor":{
         		"type":"combobox",
         		"options":{
         			"editable":false,
         			"panelHeight":'auto',
         			"valueField": 'key',
         	        "textField": 'value',
         	       	"data": [{
         				key: 'left',
         				value: '左对齐'
         			},{
         				key: 'center',
         				value: '居中'
         			},{
         				key: 'right',
         				value: '右对齐'
         			}],
         			"onSelect":function(rec){
         				onok();
         			}
         		}
         	}},
         	{"name":"宽度","id":"style_width","value":"","group":"共用属性","editor":{
         		"type":"numberbox",
         		"options":{
         			min:0,
         			max:1000
         		}
         	}},
         	{"name":"高度","id":"style_height","value":"","group":"共用属性","editor":{
         		"type":"numberbox",
         		"options":{
         			min:0,
         			max:1000
         		}
         	}},
         	{"name":"字体大小","id":"style_fontsize","value":"","group":"共用属性","editor":{
         		"type":"numberbox",
         		"options":{
         			min:0,
         			max:50
         		}
         	}},
         	{"name":"是否可见","id":"zt_visiable","value":"true","group":"共用属性","editor":{
         		"type":"checkbox",
         		"options":{
         			"on":true,
         			"off":false
         		}
         	}},
         	{"name":"允许编辑","id":"zt_editable","value":"true","group":"共用属性","editor":{
         		"type":"checkbox",
         		"options":{
         			"on":true,
         			"off":false
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
	    });
    </script>
</head>
<body style="margin:0;padding:0;" >

	<table id="dg" style="width:255px"></table>

	<script type="text/javascript">
	
		var oNode = null,thePlugins = 'usertree';
	
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
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_rootid,field:'value'});
	        $(oNode).prop('zt_rootid',$(ed.target).textbox('getValue'));
	       
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_required,field:'value'});
	        $(oNode).attr('zt_required',$(ed.target).prop('checked'));
	       
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_singleselect,field:'value'});
	        $(oNode).attr('zt_singleselect',$(ed.target).prop('checked'));

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_namefield,field:'value'});
	        $(oNode).attr('zt_namefield',$(ed.target).textbox('getValue'));

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_idfield,field:'value'});
	        $(oNode).attr('zt_idfield',$(ed.target).textbox('getValue'));

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.isbutton,field:'value'});
	        $(oNode).attr('isbutton',$(ed.target).prop('checked'));

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.style_textalign,field:'value'});
	        $(oNode).attr('style_textalign',$(ed.target).combobox('getValue'));
	        oNode.style.textAlign = $(ed.target).combobox('getValue');
	
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.style_width,field:'value'});
	        $(oNode).attr('style_width',$(ed.target).numberbox('getValue'));
	        if($(ed.target).numberbox('getValue') != ''){
	        	oNode.style.width = $(ed.target).numberbox('getValue')+"px";
	        }
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.style_height,field:'value'});
	        $(oNode).attr('style_height',$(ed.target).numberbox('getValue'));
	        if($(ed.target).numberbox('getValue') != ''){
	        	oNode.style.height = $(ed.target).numberbox('getValue')+"px";
	        }
	
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.style_fontsize,field:'value'});
	        $(oNode).attr('style_fontsize',$(ed.target).numberbox('getValue'));
	        if($(ed.target).numberbox('getValue') != ''){
	        	oNode.style.fontSize = $(ed.target).numberbox('getValue')+"px";
	        }
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_visiable,field:'value'});
	        $(oNode).attr('zt_visiable',$(ed.target).prop('checked'));

	       
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_editable,field:'value'});
	        if($(ed.target).prop('checked')){
	        	$(oNode).removeAttr('readonly');
	        }else{
	        	$(oNode).prop('readonly',true);
	        }
	        $(oNode).attr('zt_editable',$(ed.target).prop('checked'));
	        
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
		    		
		    		var gRootID = $(oNode).prop('zt_rootid');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_rootid,field:'value'});
		    		$(ed.target).textbox('setValue', gRootID);

		    		var gSingleSelect = $(oNode).attr('zt_singleselect');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_singleselect,field:'value'});
		    		if(gSingleSelect && gSingleSelect != ""){
		    			$(ed.target).prop('checked',gSingleSelect == 'true');
		    		}
		    	
		    		var gNameFiled = $(oNode).attr('zt_namefield');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_namefield,field:'value'});
		    		$(ed.target).textbox('setValue', gNameFiled);

		    		var gIdFiled = $(oNode).attr('zt_idfield');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_idfield,field:'value'});
		    		$(ed.target).textbox('setValue', gIdFiled);
		    		
		    		var gIsBtn = $(oNode).attr('isbutton');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.isbutton,field:'value'});
		    		if(gIsBtn && gIsBtn != ""){
		    			$(ed.target).prop('checked',gIsBtn == 'true');
		    		}
		    		
		    		var gRequired = $(oNode).attr('zt_required');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_required,field:'value'});
		    		if(gRequired && gRequired != ""){
		    			$(ed.target).prop('checked',gRequired == 'true');
		    		}
		    		
		    		var gText_align = $(oNode).attr('style_textalign');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.style_textalign,field:'value'});
		    		if(gText_align && gText_align != ""){
		    			$(ed.target).combobox('setValue', gText_align);
		    		}
		
		    		var gWidth = $(oNode).attr('style_width');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.style_width,field:'value'});
		    		if(gWidth != ""){
		    			$(ed.target).numberbox('setValue', gWidth);
		    		}
		    		
		    		var gHeight = $(oNode).attr('style_height');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.style_height,field:'value'});
		    		if(gHeight && gHeight != ""){
			    		$(ed.target).numberbox('setValue', gHeight);		    			
		    		}
		    		
		    		var gFont_size = $(oNode).attr('style_fontsize');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.style_fontsize,field:'value'});
		    		if(gFont_size && gFont_size != ""){
		    			$(ed.target).numberbox('setValue', gFont_size);
		    		}
		    		
		    		var gVisiable = $(oNode).attr('zt_visiable');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_visiable,field:'value'});
		    		if(gVisiable && gVisiable != ""){
		    			$(ed.target).prop('checked',gVisiable == 'true');
		    		}
		
		    		var gEditable = $(oNode).attr('zt_editable');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_editable,field:'value'});
		    		if(gEditable && gEditable != ""){
		    			$(ed.target).attr('checked',gEditable == 'true');
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
		
		$(document).ready(function(){
			init();
		});    
	</script>
</body>
</html>