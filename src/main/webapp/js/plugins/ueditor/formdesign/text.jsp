<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<%
 String bizid=request.getParameter("listbizid");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>文本框</title>
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

    			    	var edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_maxdatalength,field:'value'});
    			        $(edobj.target).numberbox('setValue',rec.datalength);
    			        
    			        edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_id,field:'value'});
    			        $(edobj.target).textbox('setValue',rec.columnname);
    			        
    		            if(rec.hasinitvalue){
    		            	edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
    		            	$(edobj.target).textbox('setValue',rec.initvalue);
    		            }else{
    		            	edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
    		            	$(edobj.target).textbox('setValue','');
    		            }
    		            if(rec.allownull){
    		            	edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_required,field:'value'});
    		            	$(edobj.target).prop('checked',false); 
    		            }else{
    		            	edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_required,field:'value'});
    		            	$(edobj.target).prop('checked',true);
    		            }
    		        }
         		}
         	}},
         	{"name":"ID","id":"zt_id","value":"","group":"业务对象属性","editor":{
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
         	{"name":"默认值","id":"zt_initvalue","value":"","group":"业务对象属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}},
         	{"name":"编辑类型","id":"zt_edittype","value":"text","group":"独立属性","editor":{
         		"type":"combobox",
         		"options":{
         			"editable":false,
         			"panelHeight":'auto',
         			"valueField": 'key',
         	        "textField": 'value',
         	       	"data": [{
         				key: 'text',
         				value: '文本'
         			},{
         				key: 'password',
         				value: '密码'
         			},{
         				key: 'date',
         				value: '日期'
         			},{
         				key: 'int',
         				value: '整数'
         			},{
         				key: 'float',
         				value: '浮点'
         			}],
         			"onSelect":function(rec){
         				onok();
         			}
         		}
         	}},
         	{"name":"多行文本","id":"zt_multiline","value":"false","group":"独立属性","editor":{
         		"type":"checkbox",
         		"options":{
         			"on":true,
         			"off":false
         		}
         	}},
         	{"name":"占位文字","id":"zt_placeholder","value":"","group":"独立属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,100]}
         		}
         	}},
         	{"name":"检测类型","id":"zt_validtype","value":"text","group":"独立属性","editor":{
         		"type":"combobox",
         		"options":{
         			"editable":true,
         			"panelHeight":'auto',
         			"valueField": 'key',
         	        "textField": 'value',
         	       	"data": [{
         				key: 'text',
         				value: '文本'
         			},{
         				key: 'email',
         				value: '邮箱'
         			},{
         				key: 'mobile',
         				value: '手机号'
         			},{
         				key: 'idcard',
         				value: '身份证号'
         			}],
         			"onSelect":function(rec){
         				onok();
         			}
         		}
         	}},
         	{"name":"最小数据长度","id":"zt_mindatalength","value":"","group":"独立属性","editor":{
         		"type":"numberbox",
         		"options":{
         			min:0,
         			max:2000
         		}
         	}},
         	{"name":"最大数据长度","id":"zt_maxdatalength","value":"","group":"独立属性","editor":{
         		"type":"numberbox",
         		"options":{
         			min:0,
         			max:2000
         		}
         	}},
         	{"name":"最小值","id":"zt_minvalue","value":"","group":"独立属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[0,50]}
         		}
         	}},
         	{"name":"最大值","id":"zt_maxvalue","value":"","group":"独立属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[0,50]}
         		}
         	}},
         	{"name":"数据精度","id":"zt_precision","value":"0","group":"独立属性","editor":{
         		"type":"numberbox",
         		"options":{
         			min:0,
         			max:10
         		}
         	}},
         	{"name":"格式化","id":"zt_formatter","value":"","group":"独立属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,100]}
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
	
		var oNode = null,thePlugins = 'text';
	
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
	       
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_mindatalength,field:'value'});
	        $(oNode).attr('zt_mindatalength',$(ed.target).numberbox('getValue'));

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_maxdatalength,field:'value'});
	        $(oNode).attr('maxlength',$(ed.target).numberbox('getValue'));
	        $(oNode).attr('zt_maxdatalength',$(ed.target).numberbox('getValue'));

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_minvalue,field:'value'});
	        $(oNode).attr('zt_minvalue',$(ed.target).textbox('getValue'));

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_maxvalue,field:'value'});
	        $(oNode).attr('zt_maxvalue',$(ed.target).textbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_precision,field:'value'});
	        $(oNode).attr('zt_precision',$(ed.target).numberbox('getValue'));
	
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_required,field:'value'});
	        $(oNode).attr('zt_required',$(ed.target).prop('checked'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
	        $(oNode).attr('value',$(ed.target).textbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_edittype,field:'value'});
	        if("password" == $(ed.target).combobox('getValue')){
	        	$(oNode).prop('type','password');
	        }else{
	        	$(oNode).prop('type','text');
	        }
	        $(oNode).attr('zt_edittype',$(ed.target).combobox('getValue'));
	
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_placeholder,field:'value'});
	        $(oNode).attr('placeholder',$(ed.target).textbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_validtype,field:'value'});
	        $(oNode).attr('zt_validtype',$(ed.target).combobox('getValue'));
	
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_formatter,field:'value'});
	        $(oNode).attr('zt_formatter',$(ed.target).textbox('getValue'));
	
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

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_multiline,field:'value'});
	        $(oNode).attr('zt_multiline',$(ed.target).prop('checked'));
	        
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

		    		var gMinDatalength = $(oNode).attr('zt_mindatalength');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_mindatalength,field:'value'});
		    		if(gMinDatalength && gMinDatalength != ""){
		    			$(ed.target).numberbox('setValue', gMinDatalength);
		    		}
		    		
		    		var gMaxDatalength = $(oNode).attr('zt_maxdatalength');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_maxdatalength,field:'value'});
		    		if(gMaxDatalength && gMaxDatalength != ""){
		    			$(ed.target).numberbox('setValue', gMaxDatalength);
		    		}
		    		
		    		var gMaxValue = $(oNode).attr('zt_maxvalue');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_maxvalue,field:'value'});
		    		$(ed.target).textbox('setValue', gMaxValue);

		    		var gMinValue = $(oNode).attr('zt_minvalue');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_minvalue,field:'value'});
		    		$(ed.target).textbox('setValue', gMinValue);
		    		
		    		var gPrecision = $(oNode).attr('zt_precision');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_precision,field:'value'});
		    		if(gPrecision && gPrecision != ""){
		    			$(ed.target).numberbox('setValue', gPrecision);
		    		}
		    		
		    		var gRequired = $(oNode).attr('zt_required');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_required,field:'value'});
		    		if(gRequired && gRequired != ""){
		    			$(ed.target).prop('checked',gRequired == 'true');
		    		}
		    		
		    		var gValue = $(oNode).attr('value');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
		    		$(ed.target).textbox('setValue',gValue);
		    		
		    		var gEdittype = $(oNode).attr('zt_edittype');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_edittype,field:'value'});
		    		if(gEdittype && gEdittype != ""){
		    			$(ed.target).combobox('setValue', gEdittype);
		    		}
		    		
		    		var gPlaceholder = $(oNode).attr('placeholder');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_placeholder,field:'value'});
		    		$(ed.target).textbox('setValue', gPlaceholder);
		
		    		var gValidtype = $(oNode).attr('zt_validtype');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_validtype,field:'value'});
		    		if(gValidtype && gValidtype != ""){
		    			$(ed.target).combobox('setValue', gValidtype);
		    		}
		    		
		    		var gFormatter = $(oNode).attr('zt_formatter');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_formatter,field:'value'});
		    		$(ed.target).textbox('setValue', gFormatter);
		    		
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

		    		var gMultiline = $(oNode).attr('zt_multiline');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_multiline,field:'value'});
		    		if(gMultiline && gMultiline != ""){
		    			$(ed.target).prop('checked',gMultiline == 'true');
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