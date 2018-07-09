<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>下拉框</title>
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
	    function fnSelect( combo ) {
	        var iIndex = combo.selectedIndex ;
	        oListText.selectedIndex    = iIndex ;
	        var olistText    = document.getElementById( "zt_text" ) ;
	        olistText.value    = oListText.value ;
	    }
	
	    function fnAdd() {
	    	if(fnRepeat()){
	    		window.parent.$.messager.alert('提示','value值有重复请修改！','info');
	    		return;
	    	}
	    	oListText=$('#zt_list');
	        var olistText    = $("#zt_addtext" ) ;
	        var olistValue    = $("#zt_addvalue" ) ;
	        fnAddComboOption( oListText, olistText.textbox('getValue'), olistValue.textbox('getValue') ) ;
	        $(oListText.children("option")).attr("selected",false);
	        $(oListText.children("option")[$('#zt_list').children("option").length-1]).attr('selected',true);
	        olistText.textbox('setValue','') ;
	        olistValue.textbox('setValue','') ;
	      
	    }
	
	    function fnModify() {
	    	oListText=$('#zt_list');
	        var iIndex = oListText.prop('selectedIndex') ;
	        if ( iIndex < 0 ) return ;
	        var olistText    = $('#zt_addtext') ;
	        var olistValue    = $('#zt_addvalue') ;
	        $(oListText.children('option')[iIndex]).val(olistValue.textbox('getValue'));
	        $(oListText.children('option')[iIndex]).text(olistText.textbox('getValue'));
	        olistText.textbox('setValue','') ;
	        olistValue.textbox('setValue','') ;
	    }
	
	    function fnMove( steps ) {
	    	oListText=$('#zt_list');
	        fnChangeOptionPosition( oListText, steps ) ;
	    }
	
	    function fnDelete() {
	    	oListText=$('#zt_list');
	        fnRemoveSelectedOptions( oListText ) ;
	    }
	
	    function fnSetSelectedValue() {
	    	oListText=$('#zt_list');
	        var iIndex = $("#zt_list").prop('selectedIndex');
	        if ( iIndex < 0 ) return ;
	        $("#zt_value").textbox("setValue",$(oListText.children('option')[ iIndex ]).val());
	       
	        
	    }
	
	    // Moves the selected option by a number of steps (also negative)
	    function fnChangeOptionPosition( combo, steps ) {
	        var iActualIndex = combo.prop('selectedIndex') ;
	        if ( iActualIndex < 0 ){
	            return ;
	        }
	        var iFinalIndex = iActualIndex + steps ;
	        if ( iFinalIndex < 0 ){
	            iFinalIndex = 0 ;
	        }
	        if ( iFinalIndex > ( combo.children('option').length - 1 ) ) {
	            iFinalIndex = combo.children('option').length - 1 ;
	        }
	        if ( iActualIndex == iFinalIndex ) {
	            return ;
	        }
	        if(iActualIndex>iFinalIndex){
	        	exchange(combo.children('option')[iActualIndex],combo.children('option')[iFinalIndex]); 
	        }else if(iActualIndex<iFinalIndex){
	        	exchange(combo.children('option')[iFinalIndex],combo.children('option')[iActualIndex]);
	        }
	         
	    }
	
	    // Remove all selected options from a SELECT object
	    function fnRemoveSelectedOptions( combo ) {
	        // Save the selected index
	        var iSelectedIndex = combo.prop('selectedIndex') ;
	        var oOptions = combo.children('option') ;
	     	// Remove all selected options
        	$("#zt_list").find("option:selected").remove();       
		    // Reset the selection based on the original selected index
	        if ( combo.children('option').length > 0 ) {
	            if ( iSelectedIndex >= combo.children('option').length ){
	            	iSelectedIndex = combo.children('option').length - 1 ;
	            } 
	            $(combo.children("option")[iSelectedIndex]).attr('selected',true);
	        }
	    }
	
	    // Add a new option to a SELECT object (combo or list)
	    function fnAddComboOption( combo, optionText, optionValue, documentObject, index ) {
	        var oOption ;
	        if ( documentObject ) {
	            oOption = documentObject.createElement("option") ;
	        } else {
	            oOption = document.createElement("option") ;
	        }
	        if ( index != null ) {
	            combo.children('option')[index].append($(oOption) ) ;
	        } else {
	            //combo.options.add( oOption ) ;
	            combo.append($(oOption));
	        }
	        oOption.innerHTML = optionText.length > 0 ? fnHTMLEncode( optionText ) : '&nbsp;' ;
	        oOption.value     = optionValue ;
	        return oOption ;
	    }
	
	    function fnHTMLEncode( text ) {
	        if ( !text ) {
	            return '' ;
	        }
	        text = text.replace( /&/g, '&amp;' ) ;
	        text = text.replace( /</g, '&lt;' ) ;
	        text = text.replace( />/g, '&gt;' ) ;
	        return text ;
	    }
	
	
	    function fnHTMLDecode( text ) {
	        if ( !text ) {
	            return '' ;
	        }
	        text = text.replace( /&gt;/g, '>' ) ;
	        text = text.replace( /&lt;/g, '<' ) ;
	        text = text.replace( /&amp;/g, '&' ) ;
	        return text ;
	    }
	
	    function fnSetAttribute( element, attName, attValue ) {
	        if ( attValue == null || attValue.length == 0 ){
	            element.removeAttribute( attName, 0 ) ;        
	        } else {
	            element.setAttribute( attName, attValue, 0 ) ;    
	        }
	    }
	    function exchange(a,b){
            var n = $(a).next();
            var p = $(b).prev();
            $(b).insertBefore(n);
            $(a).insertAfter(p);
            
        }; 
        function fnRepeat(){
        	var isExist=false;
	    	for(var i=0;i<$('#zt_list').children('option').length;i++){
        		if($($('#zt_list').children('option')[i]).val() == $('#zt_addvalue').textbox('getValue')){
        			isExist = true;
        			break;
        		}
        	}
	    	return isExist;
        }
    </script>
</head>
<body>
<div class="easyui-panel">
    <table cellpadding="5">
     <tr>
        <td>字段名称</td>
        <td colspan="2"><input type="text" id="name" class="easyui-textbox" style="width:100px" placeholder="必填项"></td>
       
    </tr>
    <tr>
        <td>字段标题  </td>
        <td colspan="2"><input type="text" id="title" class="easyui-textbox" style="width:100px" placeholder="必填项"></td>
    </tr>
     <tr>
        <td>流程变量</td>
        <td colspan="2"> <input id="fieldflow" type="checkbox"/> 流程变量</td>
       
    </tr>
    <tr>
         <td>宽 </td>
        <td colspan="2"><input id="zt_width" type="text" class="easyui-textbox" style="width:100px" value="150" /> px</td>
    </tr>
    <tr>
         <td>高</td>
       	 <td colspan="2"><input id="zt_size" type="text" class="easyui-textbox" style="width:100px" value="1"/> 行</td>
    </tr>
    
    <tr>
        <td>初始选定</td>
        <td colspan="2"> 
        	<input type="text" class="easyui-textbox" id="zt_value"  style="width :100px;" readonly="readonly">
        </td>
    </tr>
    <tr>
        <td >
              列表值
        </td>
        <td >
            <select id="zt_list"  multiple="multiple" style="width:100px;height:150px;"></select><br>
        </td>
        <td>    
            	<a id="btn" href="#" title="上移" onclick="fnMove(-1);" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a><br>
           		<a id="btn" href="#" title="下移" onclick="fnMove(1);" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a><br>
           		<a id="btn" href="#" title="设为初始化时选定值" onclick="fnSetSelectedValue();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a><br>
           		<a id="btn" href="#" title="删除" onclick="fnDelete();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a><br>
        </td>
    </tr>
    <tr>
    <td>设置值</td>
        <td >          	              
                <input type="text" style="width:100px" placeholder="value值..." class="easyui-textbox" id="zt_addvalue">
                <input type="text" style="width:100px" placeholder="text值..." class="easyui-textbox" id="zt_addtext">
        </td>
        <td>
        	<a href="#" onclick="fnAdd();" class="easyui-linkbutton" iconCls="icon-add"></a>
            <a href="#" onclick="fnModify();" class="easyui-linkbutton" iconCls="icon-edit"></a>
        </td>
    </tr>
    </table>
	</div>
	<script type="text/javascript">
		var oNode = null,oListText='',thePlugins = 'select';
		
		 function oncancel () {
		    if( UE.plugins[thePlugins].editdom ) {
		        delete UE.plugins[thePlugins].editdom;
		    }
		};
		function onok (){
		   
		    var gSize = $('#zt_size').textbox('getValue') ;
		    if ( gSize == null || isNaN( gSize ) || gSize < 1 ) {
		        gSize = '' ;
		    }
		     var gWidth=$('#zt_width').textbox('getValue');
		   
	        $(oNode).attr('title', $('#title').textbox('getValue')); 
	        $(oNode).attr('name',$('#name').textbox('getValue'));
	        $(oNode).attr('size',gSize);
	        if ( $G('fieldflow').checked ) {
	            $(oNode).attr('fieldflow',1);
	        } else {
	        	$(oNode).attr('fieldflow',0);
	        }
	        if( gWidth != '' ) {
				oNode.style.width = gWidth + 'px';
				$(oNode).attr('zt_width',gWidth );
			}
	        // Remove all options.
	        $(oNode).empty();
	        
	        for ( var i = 0 ; i < $('#zt_list').children('option').length ; i++ ) {
	            var sValue    = $($('#zt_list').children('option')[i]).val() ;
	            var sText    = $($('#zt_list').children('option')[i]).text() ;
	            if ( sText.length == 0 ) {
	                sText = sText ;
	                sValue = sValue;
	            }
	            var oOption = fnAddComboOption( $(oNode), sText, sValue ) ;
	            if ( sValue == $('#zt_value').textbox('getValue') ) {
	                fnSetAttribute( oOption, 'selected', 'selected' ) ;
	               // oOption.attr('selected' , true) ;
	            }
	        }
	        delete UE.plugins[thePlugins].editdom; 
		};
		$(document).ready(function(){
			
			oListText = $('#zt_list');    
		    if( UE.plugins[thePlugins].editdom ){
		        oNode = UE.plugins[thePlugins].editdom;
		        var gTitle=$(oNode).attr('title');
		        var gName=$(oNode).attr('name');
		        var gFlow=$(oNode).attr('fieldflow');
		        var gWidth=$(oNode).attr('zt_width');
		        var gSize=$(oNode).attr('size');
		        var gValue=oNode.value;
		        gTitle = gTitle==null ? '' : gTitle;
		        gName = gName==null ? '' : gName;
		        $('#zt_value').textbox('setValue',gValue);
		        $('#title').textbox('setValue',gTitle);
		        $('#zt_size').textbox('setValue',gSize);
		        $('#zt_width').textbox('setValue',gWidth);
		        $('#name').textbox('setValue',gName);
		        if (gFlow == '1')
		        {
		            $('#fieldflow').attr('checked',  true);
		        }
		        for ( var i = 0 ; i < $(oNode).children("option").length ;i++ ) {
		            var sText    = $($(oNode).children("option")[i]).text() ;
		            var sValue    = $($(oNode).children("option")[i]).val() ;
		            fnAddComboOption( oListText, sText, sValue ) ;
		        }
		    }
			$(".easyui-textbox").each(function(index,tb){
				if($(tb).attr("id") != "zt_text"){
				    $(tb).textbox({
				    	onChange:function(newValue,oldValue){
				    		onok();
				    	}
				    });
				}
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