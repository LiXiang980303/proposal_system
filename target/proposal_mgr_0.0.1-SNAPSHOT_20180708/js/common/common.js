/**
 * Created by dynamicniu on 2018/4/1.
 */
function getRootPath() {
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPath = curPath.substring(0, pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    return (localhostPath + projectName);
}

function getContextPath() {
    var path = window.document.location.href;
    var path_name = window.document.location.pathname;
    var pos = path.indexOf(path_name);
    return path.substring(0, pos);
}

function getRequestPath() {
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPath = curPath.substring(0, pos);

    return localhostPath;
}

function isEmpty(str) {
    if (str == null || str == '') {
        return true;
    }
    return false;
}