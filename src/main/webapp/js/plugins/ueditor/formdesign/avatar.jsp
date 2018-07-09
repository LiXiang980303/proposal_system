<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<%
 String bizid=request.getParameter("listbizid");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>头像</title>
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
	
		var oNode = null,thePlugins = 'avatar';
	
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