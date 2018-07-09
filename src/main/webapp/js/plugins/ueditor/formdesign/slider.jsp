<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<%
 String bizid=request.getParameter("listbizid");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>滑块</title>
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

    			        var edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_id,field:'value'});
    			        $(edobj.target).textbox('setValue',rec.columnname);
    			        
    		            if(rec.hasinitvalue){
    		            	edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
    		            	$(edobj.target).textbox('setValue',rec.initvalue);
    		            }else{
    		            	edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
    		            	$(edobj.target).textbox('setValue','');
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
         	
         	{"name":"默认值","id":"zt_initvalue","value":"","group":"业务对象属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}},
         	{"name":"显示类型","id":"zt_mode","value":"h","group":"独立属性","editor":{
         		"type":"combobox",
         		"options":{
         			"editable":false,
         			"panelHeight":'auto',
         			"valueField": 'key',
         	        "textField": 'value',
         	       	"data": [{
         				key: 'h',
         				value: '水平'
         			},{
         				key: 'V',
         				value: '垂直'
         			}],
         			"onSelect":function(rec){
         				onok();
         			}
         		}
         	}},
         	
         	{"name":"最小值","id":"zt_min","value":"","group":"独立属性","editor":{
         		"type":"numberbox",
         		"options":{
         			min:0,
         			max:1000
         		}
         	}},
         	{"name":"最大值","id":"zt_max","value":"","group":"独立属性","editor":{
         		"type":"numberbox",
         		"options":{
         			min:0,
         			max:1000
         		}
         	}},
         	{"name":"不长值","id":"zt_step","value":"","group":"独立属性","editor":{
         		"type":"numberbox",
         		"options":{
         			min:0,
         			max:1000
         		}
         	}},
         	{"name":"值信息","id":"zt_showtip","value":"true","group":"独立属性","editor":{
         		"type":"checkbox",
         		"options":{
         			"on":true,
         			"off":false
         		}
         	}},
         	{"name":"显示标签","id":"zt_rule","value":"","group":"独立属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,1000]},
         			multiline:true,
         			height:50
         		}
         	}},
         	{"name":"格式化","id":"zt_tipformatter","value":"","group":"独立属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,1000]},
         			multiline:true,
         			height:50
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
         	
         	{"name":"禁用","id":"zt_disabled","value":"true","group":"共用属性","editor":{
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
	
		var oNode = null,thePlugins = 'slider';
	
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

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_min,field:'value'});
	        $(oNode).attr('zt_min',$(ed.target).numberbox('getValue'));

	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_max,field:'value'});
	        $(oNode).attr('zt_max',$(ed.target).numberbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_step,field:'value'});
	        $(oNode).attr('zt_step',$(ed.target).numberbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_showtip,field:'value'});
	        $(oNode).attr('zt_showtip',$(ed.target).prop('checked'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_rule,field:'value'});
	        $(oNode).attr('zt_rule',$(ed.target).textbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
	        $(oNode).attr('value',$(ed.target).textbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_mode,field:'value'});
	        $(oNode).attr('zt_mode',$(ed.target).combobox('getValue'));
	
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_tipformatter,field:'value'});
	        $(oNode).attr('zt_tipformatter',$(ed.target).textbox('getValue'));
	
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
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_disabled,field:'value'});
	        /*if($(ed.target).prop('checked')){
	        	$(oNode).removeAttr('readonly');
	        }else{
	        	$(oNode).prop('readonly',true);
	        }*/
	        $(oNode).attr('zt_disabled',$(ed.target).prop('checked'));
	        
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

		    		var gMax = $(oNode).attr('zt_max');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_max,field:'value'});
		    		$(ed.target).numberbox('setValue', gMax);

		    		var gMin = $(oNode).attr('zt_min');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_min,field:'value'});
		    		$(ed.target).numberbox('setValue', gMin);
		    		
		    		var gStep = $(oNode).attr('zt_step');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_step,field:'value'});
		    		$(ed.target).numberbox('setValue', gStep);
		    		
		    		var gShowTip = $(oNode).attr('zt_showtip');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_showtip,field:'value'});
		    		if(gShowTip && gShowTip != ""){
		    			$(ed.target).attr('checked',gShowTip == 'true');
		    		}
		    		
		    		var gRule = $(oNode).attr('zt_rule');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_rule,field:'value'});
		    		$(ed.target).textbox('setValue', gRule);
		    		
		    		var gValue = $(oNode).attr('value');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_initvalue,field:'value'});
		    		$(ed.target).textbox('setValue',gValue);
		    		
		    		var gMode = $(oNode).attr('zt_mode');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_mode,field:'value'});
		    		if(gMode && gMode != ""){
		    			$(ed.target).combobox('setValue', gMode);
		    		}
		    		
		    		var gTipFormatter = $(oNode).attr('zt_tipformatter');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_tipformatter,field:'value'});
		    		$(ed.target).textbox('setValue', gTipFormatter);
		    		
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
		    		
		    		var gDisabled = $(oNode).attr('zt_disabled');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_disabled,field:'value'});
		    		if(gDisabled && gDisabled != ""){
		    			$(ed.target).attr('checked',gDisabled == 'true');
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