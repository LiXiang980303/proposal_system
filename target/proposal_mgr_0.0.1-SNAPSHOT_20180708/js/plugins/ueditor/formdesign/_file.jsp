<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>文件上传</title>
    <script type="text/javascript" src="../dialogs/internal_form.js"></script>
</head>
<body>
	<div class="easyui-panel">
    <table cellpadding="5">
     <tr>
        <td>字段名称</td>
        <td><input type="text" class="easyui-textbox" type="text" style="width:120px" id="zt_name" placeholder="必填项"></td>
    </tr>
    <tr>
        <td>多文件</td>
        <td> 
        	<label class="checkbox inline"><input id="zt_multiple" type="checkbox"/> 多个 </label>
        </td>
    </tr>
    <tr>
        <td>大小 </td>
        <td>
            <input id="zt_size" type="text" class="easyui-textbox" type="text" style="width:120px" value="150"  placeholder="auto"/>
        </td>
    </tr>
    </table>
</div>
<script type="text/javascript">
var oNode = null,thePlugins = 'file';
	function oncancel  () {
	    if( UE.plugins[thePlugins].editdom ) {
	        delete UE.plugins[thePlugins].editdom;
	    }
	};
	function onok (){
	    var gName=$('#zt_name').textbox('getValue');
	    var gSize=$('#zt_size').textbox('getValue');
        $(oNode).attr('name',gName);
        if( gSize != '' ) {
            $(oNode).attr('size',gSize );
        }else{
            $(oNode).attr('size', '');
        }
        if( $G('zt_multiple').checked ) {
            $(oNode).attr('multiple', 'multiple');
        } else{
        	$(oNode).removeAttr('multiple');
        }
       
        delete UE.plugins[thePlugins].editdom;
	};
	$(document).ready(function(){
		if( UE.plugins[thePlugins].editdom ){
	        oNode = UE.plugins[thePlugins].editdom;
			var gName=$(oNode).attr('name');
			var gSize=$(oNode).attr('size');
			var gMultiple=$(oNode).attr('multiple');
	        gName = gName==null ? '' : gName;
	        $('#zt_name').textbox('setValue',gName);
	        $('#zt_size').textbox ('setValue',gSize) ;
	        if (gMultiple == 'multiple')
	        {
	            $G('zt_multiple').checked = true;
	        }
	    }
		
		$(".easyui-textbox").each(function(index,tb){
		    $(tb).textbox({
		    	onChange:function(newValue,oldValue){
		    		onok();
		    	}
		    });
		});
		$(".easyui-combobox").each(function(index,tb){
		    $(tb).combobox({
		    	onChange:function(newValue,oldValue){
		    		onok();
		    	}
		    });
		});
		
		$(":checkbox").change(function(){
		    onok();
		});
		$("a").click(function(){
		    onok();
		});
	});
</script>
</body>
</html>