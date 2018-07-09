<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/head.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>单选框</title>
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
		
		
		//checkboxs
		function isIE()
		{
		    if(window.attachEvent){   
		        return true;
		    }
		    return false;
		}
		//moveRow在IE支持而在火狐里不支持！以下是扩展火狐下的moveRow
		if (!isIE()) {
		    function getTRNode(nowTR, sibling) {
		        while (nowTR = nowTR[sibling]) if (nowTR.tagName == 'TR') break;
		        return nowTR;
		    }
		    if (typeof Element != 'undefined') {
		        Element.prototype.moveRow = function(sourceRowIndex, targetRowIndex) //执行扩展操作
		        {
		            if (!/^(table|tbody|tfoot|thead)$/i.test(this.tagName) || sourceRowIndex === targetRowIndex) return false;
		            var pNode = this;
		            if (this.tagName == 'TABLE') pNode = this.getElementsByTagName('tbody')[0]; //firefox会自动加上tbody标签，所以需要取tbody，直接table.insertBefore会error
		            var sourceRow = pNode.rows[sourceRowIndex],
		            targetRow = pNode.rows[targetRowIndex];
		            if (sourceRow == null || targetRow == null) return false;
		            var targetRowNextRow = sourceRowIndex > targetRowIndex ? false: getTRNode(targetRow, 'nextSibling');
		            if (targetRowNextRow === false) pNode.insertBefore(sourceRow, targetRow); //后面行移动到前面，直接insertBefore即可
		            else { //移动到当前行的后面位置，则需要判断要移动到的行的后面是否还有行，有则insertBefore，否则appendChild
		                if (targetRowNextRow == null) pNode.appendChild(sourceRow);
		                else pNode.insertBefore(sourceRow, targetRowNextRow);
		            }
		        }
		    }
		}
		
		/*删除tr*/
		function fnDeleteRow(obj)
		{
		    var oTable = document.getElementById("options_table");
		    while(obj.tagName !='TR')
		    {
		        obj = obj.parentNode;
		    }
		    oTable.deleteRow(obj.rowIndex);
		}
		/*上移*/
		function fnMoveUp(obj)
		{
		    var oTable = document.getElementById("options_table");
		    while(obj.tagName !='TR')
		    {
		        obj = obj.parentNode;
		    }
		    var minRowIndex = 1;
		    var curRowIndex = obj.rowIndex;
		    if(curRowIndex-1>=minRowIndex)
		    {
		        oTable.moveRow(curRowIndex,curRowIndex-1); 
		    }
		    
		}
		/*下移*/
		function fnMoveDown(obj)
		{
		    var oTable = document.getElementById("options_table");
		    while(obj.tagName !='TR')
		    {
		        obj = obj.parentNode;
		    }
		    var maxRowIndex = oTable.rows.length;
		    var curRowIndex = obj.rowIndex;
		    if(curRowIndex+1<maxRowIndex)
		    {
		        oTable.moveRow(curRowIndex,curRowIndex+1); 
		    }
		}
		
		/*生成tr*/
		function fnAddComboTr(gName,obj)
		{
		    var oTable = document.getElementById('options_table');
		    var new_tr_node= oTable.insertRow(oTable.rows.length);
		    var new_td_node0 = new_tr_node.insertCell(0),new_td_node1 = new_tr_node.insertCell(1),new_td_node2 = new_tr_node.insertCell(2);
		
		    var sChecked = '';
		    if(obj.checked) sChecked = 'checked="checked"';
		    if(!obj.name) obj.name = '';
		    if(!obj.value) obj.value = '';
		    new_td_node0.innerHTML = '<td><input type="radio" '+sChecked+' name="'+gName+'"></td>';
		    new_td_node1.innerHTML = '<td><input type="text" class="easyui-textbox" style="width:100px"  value="'+obj.value+'" name="'+gName+'" placeholder="选项值"></td>';
		    new_td_node2.innerHTML ='<td><a title="上移"  href="javascript:void(0);" onclick="fnMoveUp(this)">上移</a>&nbsp;<a title="下移"  href="javascript:void(0);" onclick="fnMoveDown(this)">下移</a>&nbsp;<a title="删除"  href="javascript:void(0);" onclick="fnDeleteRow(this)">删除</a>&nbsp;</td>';
		    return true;
		}
		function fnAdd() {
		    var dName = $G('hidname').value;
		    if(!dName) dName = 'NEWFIELD';
		    fnAddComboTr(dName,{
		        "checked":false,
		        "name":'NEWFIELD',
		        "value":''
		    });
		}
		/*组合checkbox*/
		function fnParseOptions(gName,gChecked)
		{
		    var oTable = document.getElementById('options_table');
		    var nTr = oTable.getElementsByTagName('tr'),trLength = nTr.length,html="";
		    for(var i=0;i<trLength;i++)
		    {
		        var inputs = nTr[i].getElementsByTagName('input');
		
		        if(inputs.length>0)
		        {
		            if(!inputs[1].value) continue;
		            var sChecked = '';
		            if(inputs[0].checked){
		            	sChecked = 'checked="checked"';
		            } 
		            html += '<input name="'+gName+'" value="'+inputs[1].value+'" '+sChecked+' type="radio"/>'+inputs[1].value;
		          //竖排
		            if(gChecked=='orgchecked1'){
		            	html+='<br/>';
		            }
		                
		        }
		    }
		    return html;
		
		}
    </script>
</head>
<body>
<div class="easyui-panel">
    <input id="hidname"  type="hidden"/>
    <table cellpadding="5">
     <tr>
        <td><span>字段名称</span></td>
        <td><input type="text" id="fieldname" class="easyui-textbox" style="width:100px" placeholder="必填项"></td>
        
    </tr>
    <tr>
        <td><span>字段标题</span></td>
        <td><input type="text" id="orgname" class="easyui-textbox" style="width:100px" placeholder="必填项"></td>
    </tr>
     <tr>
        <td>流程变量 </td>
        <td><label class="checkbox inline"><input id="fieldflow" type="checkbox"/> 流程变量</label></td>
        
    </tr>
    <tr>
        <td>排列方式</td>
        <td>
            <label class="radio" title="选项一 选项二"><input id="orgchecked0" checked="checked" name="checked" type="radio"> 横排 </label>
            <label class="radio" title="选项一&#10;选项二"><input id="orgchecked1" name="checked" type="radio" > 竖排 </label>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <table class="table table-hover table-condensed" id="options_table">
                <tr>
                    <td>选中</td>
                    <td>选项值</td>
                    <td>操作</td>
                </tr>
                <!--tr>
                    <td><input type="checkbox" checked="checked"></td>
                    <td><input type="text" value="选项一"></td>
                    <td>
                        <div class="btn-group">
                            <a title="上移" class="btn btn-small btn-info" href="#"><i class="icon-white icon-arrow-up"></i></a>
                            <a title="下移" class="btn btn-small btn-info" href="#"><i class="icon-white icon-arrow-down"></i></a>
                            <a title="删除" class="btn btn-small btn-default"><i class="icon-ban-circle"></i></a>
                        </div>
                    </td>
                </tr-->

            </table>
            <a title="添加选项" class="btn btn-primary" onclick="fnAdd();">添加选项</a>
        </td>
    </tr>


    </table>
</div>
<script type="text/javascript">
	var oNode = null,thePlugins = 'radios';
	
	function oncancel() {
	    if( UE.plugins[thePlugins].editdom ) {
	        delete UE.plugins[thePlugins].editdom;
	    }
	};
	function onok  (){
	    var gTitle=$('#orgname').textbox('getValue');
	    var gName=$('#fieldname').textbox('getValue');
	    var gChecked = 'orgchecked0';
	    var gFlow = '0';
	    if ($G('orgchecked1').checked) gChecked = 'orgchecked1';
	    if ($G('fieldflow').checked ) gFlow = '1';
        //var gName=$(oNode).attr('name');
        $(oNode).attr('title',gTitle);
        $(oNode).attr('orgchecked',gChecked);
        $(oNode).attr('fieldname',gName);
        $(oNode).attr('fieldflow',gFlow);
        //$(oNode).empty();
        $(oNode).html(fnParseOptions(gName,gChecked));
        delete UE.plugins[thePlugins].editdom; 
        return true;
	 };	
	$(document).ready(function(){
		if( UE.plugins[thePlugins].editdom ){
	        oNode = UE.plugins[thePlugins].editdom;
	        var gTitle=$(oNode).attr('title');
	        var gName=$(oNode).attr('name');
	        var gFlow=$(oNode).attr('fieldflow');
	        $('#orgname').textbox('setValue',gTitle);
	        $('#fieldname').textbox('setValue',$(oNode).attr('fieldname'));
	        if (gFlow == '1')
	        {
	            $('#fieldflow').attr('checked', true);
	        }
	        $('#hidname').val(gName);
	        var checked = $(oNode).attr('orgchecked');
	        if(checked=='orgchecked1') {
	        	$('#orgchecked1').attr('checked', true);
	        }else{
	        	$('#orgchecked0').attr('checked',true);
	        }
	        var inputTags = oNode.getElementsByTagName('input');
	        var length = inputTags.length;
	        var aInputs = [];
	        for(var i=0;i<length;i++)
	        {
	            //testEle.setAttribute("test","aaa"); // 自定义属性 设置  
	            //testEle.attributes["test"].nodeValue; // 获得 
	            if(inputTags[i].type =='radio')
	                fnAddComboTr(gName,inputTags[i]);
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