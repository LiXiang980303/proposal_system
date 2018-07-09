<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>明细表控件</title>
    <script type="text/javascript" src="../dialogs/internal_form.js"></script>
    <script type="text/javascript" src="<%=contextPath %>/js/custom/jquery.propertygrid.js"></script>
    <script type="text/javascript">
    	var bizid = parent.$('#bizid').val();
	    var prop = {"rows":[
            {"name":"明细表","id":"zt_listbizid","value":"","group":"业务对象属性","editor":{
         		"type":"combobox",
         		"options":{
         		    "url":'<%=request.getContextPath() %>/formdesigner.do?method=getonetomanytable&bizid='+bizid,
         		    "valueField":'bizid',
         		    "textField":'bizname',
         		    "panelHeight":'auto',
         		    "editable":false,
    			    onSelect: function(rec){
    			    	edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_id,field:'value'});
     			        $(edobj.target).textbox('setValue',rec.tablename);
     			        edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_linkname,field:'value'});
    			        $(edobj.target).textbox('setValue',rec.properties.linkname);
    			        edobj = $('#dg').propertygrid('getEditor',{index:propmap.zt_idfield,field:'value'});
    			        $(edobj.target).textbox('setValue',rec.idfield);
    			       
    			        /*
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
    		            }*/
    		        }
         		}
         	}},
         	
         	{"name":"ID","id":"zt_id","value":"","group":"业务对象属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}},
         	{"name":"关联名称","id":"zt_linkname","value":"","group":"业务对象属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}},
         	{"name":"主键","id":"zt_idfield","value":"","group":"业务对象属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,50]}
         		}
         	}},
         	{"name":"排序字段","id":"zt_sortname","value":"","group":"业务对象属性","editor":{
         		"type":"textbox",
         		"options":{
         			validType:{length:[1,100]}
         		}
         	}},
         	{"name":"排序方式","id":"zt_sortorder","value":"","group":"业务对象属性","editor":{
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
	
		var oNode = null,thePlugins = 'listformctrl';
	
		function oncancel () {
		    if( UE.plugins[thePlugins].editdom ) {
		        delete UE.plugins[thePlugins].editdom;
		    }
		}
		
		function onok (){
			
			var ed;
	
			ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_id,field:'value'});
	        $(oNode).prop('id',$(ed.target).textbox('getValue'));
	        //$(oNode).prop('name',$(ed.target).textbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_linkname,field:'value'});
	        $(oNode).attr('linkname',$(ed.target).textbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_sortname,field:'value'});
	        $(oNode).attr('zt_sortname',$(ed.target).textbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_sortorder,field:'value'});
	        $(oNode).attr('zt_sortorder',$(ed.target).textbox('getValue'));
	        
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_idfield,field:'value'});
	        $(oNode).attr('zt_idfield',$(ed.target).textbox('getValue'));

			ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_listbizid,field:'value'});
			$(oNode).attr('listbizid',$(ed.target).combobox('getValue'));
	        
	    
	        ed = $('#dg').propertygrid('getEditor',{index:propmap.style_textalign,field:'value'});
	        $(oNode).attr('style_textalign',$(ed.target).combobox('getValue'));
	        oNode.style.textAlign = $(ed.target).combobox('getValue');
	
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
		    		
		    		var gLinkName = $(oNode).attr('linkname');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_linkname,field:'value'});
		    		$(ed.target).textbox('setValue', gLinkName);
		    		
		    		var gSortName = $(oNode).attr('zt_sortname');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_sortname,field:'value'});
		    		$(ed.target).textbox('setValue', gSortName);
		    		
		    		var gSortOrder = $(oNode).attr('zt_sortorder');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_sortorder,field:'value'});
		    		$(ed.target).textbox('setValue', gSortOrder);
		    		
		    		var gIdField = $(oNode).attr('zt_idfield');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_idfield,field:'value'});
		    		$(ed.target).textbox('setValue', gIdField);

		    		var gName = $(oNode).attr('listbizid');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.zt_listbizid,field:'value'});
		    		$(ed.target).combobox('setValue', gName);

		    		
		    		
		    		var gText_align = $(oNode).attr('style_textalign');
		    		ed = $('#dg').propertygrid('getEditor',{index:propmap.style_textalign,field:'value'});
		    		if(gText_align && gText_align != ""){
		    			$(ed.target).combobox('setValue', gText_align);
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