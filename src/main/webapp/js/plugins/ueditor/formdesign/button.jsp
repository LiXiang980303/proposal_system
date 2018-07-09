<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>按钮</title>
    <script type="text/javascript" src="../dialogs/internal_form.js"></script>
    <script type="text/javascript">

		function createElement(type, name)
		{     
		    var element = null;     
		    try {        
		        element = document.createElement('<'+type+' name="'+name+'">');     
		    } catch (e) {}   
		    if(element==null) {     
		        element = document.createElement(type);     
		        element.name = name;     
		    } 
		    return element;     
		}
    </script>
</head>
<body>
<div class="easyui-panel">
    <table cellpadding="5">
      <tr>
        <td>类型 </td>
        <td>
             <select id="zt_type" class="easyui-combobox">
                <option value="button">button</option>
                <option value="reset">reset</option>
                <option value="submit">submit</option>
            </select>   
        </td>
        
    </tr> 
     <tr>
        <td>名称</td>
        <td><input type="text" class="easyui-textbox" type="text" style="width:120px" id="zt_name" placeholder="必填项"></td>
    </tr>
   <!--   <tr>
        <td>禁用</td>
        <td> 
        	<label class="checkbox inline"><input id="zt_disabled" type="checkbox"/> 禁用 </label>
        	
        </td>
    </tr>
     -->
   
    
    <tr>
        <td>宽度 </td>
        <td>
            <input id="zt_width" type="text" class="easyui-textbox" type="text" style="width:120px" value="150" class="input-small span1" placeholder="auto"/>px
        </td>
    </tr>
    <tr>
    	<td>高度 </td>
        <td>
            
            <input id="zt_height" type="text" class="easyui-textbox" type="text" style="width:120px" value="" class="input-small span1" placeholder="auto"/>px
            
        </td>
    </tr>
   <!-- 
    <tr>
       
         <td>隐藏 </td>
        <td>
            <label class="checkbox inline"><input id="zt_hide" type="checkbox"/> 隐藏 </label>
        </td>
    </tr>
     <tr>
       
         <td><span>只读</span> </td>
        <td>
            <label class="checkbox inline"><input id="zt_readonly" type="checkbox"/> 只读 </label>
        </td>
    </tr>
	 -->
    </table>
</div>
<script type="text/javascript">
	var oNode = null,thePlugins = 'button';
	function oncancel  () {
	    if( UE.plugins[thePlugins].editdom ) {
	        delete UE.plugins[thePlugins].editdom;
	    }
	};
	function onok (){
	    var gType=$('#zt_type').textbox('getValue');
	    var gName=$('#zt_name').textbox('getValue');
	    var gWidth=$('#zt_width').textbox('getValue');
	    var gHeight=$('#zt_height').textbox('getValue');
        $(oNode).attr('name',gName);
        //$(oNode).attr('type',gType);
         /* if( $G('zt_hide').checked ) {
            $(oNode).attr('zt_hide', 1);
        } else {
            $(oNode).attr('zt_hide', 0);
        }
      if ( $G('zt_disabled').checked ) {
        	$(oNode).attr('disabled',true);
            //$(oNode).attr('multiline',true);
        }else{
        	$(oNode).removeAttr('disabled',true);
        	//oNode.removeAttribute('multiline');
        }
        if( $G('zt_readonly').checked ) {
            $(oNode).attr('readonly', 'readonly');
        } else{
        	$(oNode).removeAttr('readonly','readonly');
        }
        */
        
        if( gWidth != '' ) {
            oNode.style.width = gWidth+ 'px';
            $(oNode).attr('zt_width',gWidth );
        }else{
            oNode.style.width = '';
            $(oNode).attr('zt_width', '');
        }
        if( gHeight != '' ) {
            oNode.style.height = gHeight+ 'px';
            $(oNode).attr('zt_height',gHeight );
        }else{
            oNode.style.height = '';
            $(oNode).attr('zt_height', '');
        }
       
        delete UE.plugins[thePlugins].editdom;
	    
	};
	$(document).ready(function(){
		if( UE.plugins[thePlugins].editdom ){
	        oNode = UE.plugins[thePlugins].editdom;
			var gName=$(oNode).attr('name');
			var gType=$(oNode).attr('type');
			var gDisabled=$(oNode).attr('disabled');
			var gHidden=$(oNode).attr('zt_hide');
			var gWidth=$(oNode).attr('zt_width');
			var gHeight=$(oNode).attr('zt_height');
			var gReadonly=$(oNode).attr('readonly');
	        gName = gName==null ? '' : gName;
	        $('#zt_name').textbox('setValue',gName);
	        $G('zt_type').value = gType;
	       /* if (gDisabled == 'true')
	        {
	            $G('zt_disabled').checked = true;
	        }
	        if (gHidden == '1')
	        {
	            $G('zt_hide').checked = true;
	        }
	        if (gReadonly == 'readonly')
	        {
	            $G('zt_readonly').checked = true;
	        }*/
	        $('#zt_width').textbox ('setValue',gWidth) ;
	        $('#zt_height').textbox ('setValue',gHeight) ;
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