<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>文本框</title>
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
<body style="margin:0;padding:2px;">
	<div class="easyui-panel" data-options="border:true" >
	    <table cellpadding="5">
	     <tr>
	        <td>输入类型</td>
	        <td>
	             <select id="zt_type" class="easyui-combobox" data-options="width:80,editable:false,panelHeight:'auto'">
	                <option value="text">文本</option>
	                <option value="password">密码</option>
	                <option value="date">日期</option>
	                <option value="int">整数</option>
	                <option value="float">浮点</option>
	            </select>   
	        </td>
	        
	    </tr>
	     <tr>
	        <td>字段名称</td>
	        <td><input type="text"  class="easyui-combobox" data-options="editable:false,panelHeight:'auto'" style="width:120px" id="zt_name" ></td>
	    </tr>
	    <tr>
	    	<td>字段标题</td>
	        <td><input type="text"  class="easyui-textbox" style="width:120px" id="zt_title" placeholder="必填项"></td>
	    </tr>
	     <tr>
	        <td>默认值</td>
	        <td><input type="text"  class="easyui-textbox" style="width:120px" id="zt_value" placeholder="无则不填"></td> 
	    </tr>
	    <tr>
	        <td>占位文字</td>
	        <td><input type="text"  class="easyui-textbox" style="width:120px" id="zt_placeholder" placeholder="无则不填"></td> 
	    </tr>
	     <tr>
	        <td>是否多行</td>
	        <td> 
	        	<label class="checkbox inline"><input id="zt_multiline" type="checkbox"/> 多行 </label>
	        	
	        </td>
	    </tr>
	    <tr>
	        <td>是否必填</td>
	        <td> 
	        	<label class="checkbox inline"><input id="attr_required" type="checkbox"/> 必填</label>
	        	
	        </td>
	    </tr>
	    
	    <tr>
	        <td>检测类型 </td>
	        <td>
	             <select id="attr_validtype" class="easyui-combobox" data-options="width:100,panelHeight:'auto'">
	                <option value="email">邮箱地址</option>
	                <option value="mobile">手机号</option>
	                <option value="idcard">身份证号码</option>
	            </select>   
	        </td>
	        
	    </tr>
	    <tr>
	        <td>最大长度</td>
	        <td><input type="text"  class="easyui-numberbox" style="width:120px" id="zt_maxlength" placeholder="无则不填"></td> 
	    </tr>
	    <tr>
	        <td>对齐方式</td>
	        <td>
	            <select id="zt_align" class="easyui-combobox" data-options="width:80,editable:false,panelHeight:'auto'">
	                <option value="left" >左对齐</option>
	                <option value="center">居中对齐</option>
	                <option value="right">右对齐</option>
	            </select>
	        </td>
	    </tr>
	    <tr>
	        <td>宽度</td>
	        <td>
	            <input id="zt_width"  class="easyui-numberbox" type="text" style="width:120px" value="150"  placeholder="auto"/>&nbsp;PX
	            
	
	        </td>
	    </tr>
	    <tr>
	    	<td>高度</td>
	        <td>
	            
	            <input id="zt_height"  class="easyui-numberbox" type="text" style="width:120px" value=""  placeholder="auto"/>&nbsp;PX
	            
	        </td>
	    </tr>
	    <tr>
	    	<td>字体大小</td>
	        <td>
	            
	            <input id="zt_fontsize"  class="easyui-numberbox" type="text" style="width:120px"  value=""  placeholder="auto"/>&nbsp;PX
	        </td>
	    </tr>
	    <tr>
	       
	         <td>是否可见</td>
	        <td>
	            <label class="checkbox inline"><input id="attr_hide" type="checkbox"/>不可见</label>
	        </td>
	    </tr>
	     <tr>
	       
	         <td>只读 </td>
	        <td>
	            <label class="checkbox inline"><input id="zt_readonly" type="checkbox"/>只读 </label>
	        </td>
	    </tr>
	
	    </table>
	</div>
	<script type="text/javascript">
	var oNode = null,thePlugins = 'text';
	$(document).ready(function(){

	});

	function oncancel () {
	    if( UE.plugins[thePlugins].editdom ) {
	        delete UE.plugins[thePlugins].editdom;
	    }
	}
	
	function onok (){
	    var gValue = $('#zt_value').textbox('getValue');
	    var gTitle = $G('zt_title').value;
	    var gType = $('#zt_type').combobox('getValue');
	    var gName = $('#zt_name').combobox('getValue');
	    var gPlaceholder = $('#zt_placeholder').textbox('getValue');
	    var gMaxlength = $('#zt_maxlength').numberbox('getValue');
	    var gFontSize = $('#zt_fontsize').numberbox('getValue');
	    var gAlign = $('#zt_align').combobox('getValue');
	    var gWidth = $('#zt_width').numberbox('getValue');
	    var gHeight = $('#zt_height').numberbox('getValue');
	    var gValidtype = $('#attr_validtype').combobox('getValue');
	    
	  
    	$(oNode).attr('value', gValue);
        $(oNode).attr('title', gTitle);
        $(oNode).attr('name',gName);
        
        if(gType == "password"){
        	$(oNode).attr('type',gType);
        }else{
        	$(oNode).attr('type',"text");
        }
        $(oNode).attr('attr_inputtype',gType);
        
        $(oNode).attr('placeholder',gPlaceholder);
        $(oNode).attr('maxlength',gMaxlength);
        if( $G('attr_hide').checked ) {
            $(oNode).attr('attr_hide', 1);
        } else {
            $(oNode).attr('attr_hide', 0);
        }
        if ( $G('zt_multiline').checked ) {
        	$(oNode).attr('multiline',true);
        }else{
        	$(oNode).removeAttr('multiline',true);
        }
        if( $G('zt_readonly').checked ) {
            $(oNode).attr('readonly', 'readonly');
        } else{
        	$(oNode).removeAttr('readonly','readonly');
        }
        if( $G('attr_required').checked ) {
            $(oNode).attr('attr_required', true);
        } else{
        	$(oNode).removeAttr('attr_required');
        }
        if( gFontSize != '' ) {
            oNode.style.fontSize = gFontSize+ 'px';
            $(oNode).attr('zt_fontsize',gFontSize );
        }else{
            oNode.style.fontSize = '';
            $(oNode).attr('zt_fontsize', '');
        }
        if( gAlign != '' ) {
            oNode.style.textAlign = gAlign;
            $(oNode).attr('zt_align',gAlign );
        }else{
            $(oNode).attr('zt_align', '');
        }
        if( gWidth != '' ) {
            oNode.style.width = gWidth+ 'px';
            $(oNode).attr('zt_width',gWidth );
        }else{
            oNode.style.width = '150px';
            $(oNode).attr('zt_width', '');
        }
        if( gHeight != '' ) {
            oNode.style.height = gHeight+ 'px';
            $(oNode).attr('zt_height',gHeight );
        }else{
            oNode.style.height = '';
            $(oNode).attr('zt_height', '');
        }
        if( gValidtype != '' ) {
            $(oNode).attr('attr_validtype',gValidtype );
        }else{
            $(oNode).attr('attr_validtype', '');
        }
        delete UE.plugins[thePlugins].editdom;
	    
	};
	$(document).ready(function(){
		$('#zt_name').combobox({
		    url:contextPath+'/bizobj.do?method=listbizfield&bizid='+parent.$('#bizid').val(),
		    valueField:'columnname',
		    textField:'displayname',
		    onSelect: function(rec){
	            $('#zt_maxlength').numberbox('setValue',rec.datalength);
	            if(rec.hasinitvalue){
	            	 $('#zt_value').textbox('setValue',rec.initvalue);
	            }else{
	            	$('#zt_value').textbox('setValue','');
	            }
	            if(rec.allownull){
	            	$('#attr_required').prop('checked',false); 
	            }else{
	            	$('#attr_required').prop('checked',true);
	            	 
	            }
	           
	        }
		    
		});
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

		$(".easyui-numberbox").each(function(index,tb){
		    $(tb).numberbox({
		    	onChange:function(newValue,oldValue){
		    		onok();
		    	}
		    });
		});
		
		$(":checkbox").change(function(){
		    onok();
		});

	    if( UE.plugins[thePlugins].editdom ){
	        oNode = UE.plugins[thePlugins].editdom;
			var gValue = $(oNode).attr('value');	
			var gName=$(oNode).attr('name');
			var gPlaceholder=$(oNode).attr('placeholder');
			var gTitle=$(oNode).attr('title');
			var gType = $(oNode).attr('attr_inputtype');
			var gMultiline=$(oNode).attr('multiline');
			var gMaxlength=$(oNode).attr('maxlength');
			var gHidden=$(oNode).attr('attr_hide');
			var gFontSize=$(oNode).attr('zt_fontsize');
			var gAlign=$(oNode).attr('zt_align');
			var gWidth=$(oNode).attr('zt_width');
			var gHeight=$(oNode).attr('zt_height');
			var gValidtype=$(oNode).attr('attr_validtype');
			var gReadonly=$(oNode).attr('readonly');
			var gRequired=$(oNode).attr('attr_required');
			gValue = gValue==null ? '' : gValue;
	        gTitle = gTitle==null ? '' : gTitle;
	        gName = gName==null ? '' : gName;
			$('#zt_value').textbox('setValue',gValue);
			$('#zt_name').combobox('setValue',gName);
			$('#zt_title').textbox('setValue',gTitle);
			$('#zt_placeholder').textbox('setValue',gPlaceholder);
	        $('#zt_type').combobox('setValue',gType);
	        $('#zt_maxlength').numberbox('setValue',gMaxlength);
	        if (gMultiline == 'true') {
	            $('#zt_multiline').attr('checked',true);
	        }
	        if (gHidden == '1') {
	            $('#attr_hide').attr('checked',true);
	        }
	        if (gReadonly == 'readonly') {
	           $('#zt_readonly').attr('checked',true);
	        }
	        if (gRequired == 'true') {
		           $('#attr_required').attr('checked',true);
		        }
	        $('#zt_fontsize').textbox('setValue',gFontSize);
	        $('#zt_width').numberbox('setValue',gWidth);
	        $('#zt_height').numberbox('setValue',gHeight);
	        $("#zt_align").combobox('setValue',gAlign);
	        $("#attr_validtype").combobox('setValue',gValidtype);
	    };
	});    
	</script>
</body>
</html>