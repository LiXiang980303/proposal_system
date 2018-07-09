package com.proposal;

import com.proposal.util.Dom4jXML;
import com.proposal.util.XmlUtils;
import org.dom4j.DocumentException;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by dynam on 2017/1/5.
 */
public class XmlUtilsTest {
    private XmlUtils xmlUtils = new XmlUtils();

    private Dom4jXML dom4jXML = new Dom4jXML();

    @Test
    public void testXmlUtils() {
        String str = "";

        str = "<dept-root DeptId=\"201010006162\" DeptName=\"海淀区\">" +
                "<dept-1 DeptId=\"201010008652\" DeptName=\"政府系统\">" +
                "<dept-2 DeptId=\"201010006262\" DeptName=\"审计局\"/>" +
                "</dept-1></dept-root>";

        str = "<dept-root DeptId=\"201010006162\" DeptName=\"海淀区\">"
                + "<dept-1 DeptId=\"201010008652\" DeptName=\"政府系统\">"
                + "<dept-2 DeptId=\"201010006262\" DeptName=\"审计局\">"
                + "<dept-3 DeptId=\"201010000070\" DeptName=\"机要局\">"
                + "<member CertNo=\"020110010003108002\" LoginName=\"201010003108\" Order=\"2\" Roles=\"33\" UserId=\"201010003108\" UserName=\"测试用人员1\">测试用人员1</member>"
                + "<dept-4 DeptId=\"201010003147\" DeptName=\"信息化运维2\">"
                + "<member CertNo=\"020110010003108002\" LoginName=\"201010003108\" Order=\"2\" Roles=\"33\" UserId=\"201010003108\" UserName=\"测试用人员1\">测试用人员1</member>"
                + "<member CertNo=\"020110010003108002\" LoginName=\"201010003108\" Order=\"2\" Roles=\"33\" UserId=\"201010003108\" UserName=\"测试用人员1\">测试用人员1</member>"
                + "</dept-4></dept-3></dept-2></dept-1>"
                + "</dept-root>";





    }

    @Test
    public void testDom4jXML() {
        String str = "";

        str = "<dept-root DeptId=\"201010006162\" DeptName=\"海淀区\">" +
                "<dept-1 DeptId=\"201010008652\" DeptName=\"政府系统\">" +
                "<dept-2 DeptId=\"201010006262\" DeptName=\"审计局1\"/>" +
                "</dept-1></dept-root>";

        str = "<dept-root DeptId=\"beijing\" DeptName=\"北京市\">"
                + "<dept-1 DeptId=\"201010000008\" DeptName=\"北京市委\">"
                + "<dept-2 DeptId=\"201010000010\" DeptName=\"市委办公厅\">"
                + "<dept-3 DeptId=\"201010000070\" DeptName=\"机要局\">"
                + "<dept-4 DeptId=\"201010003147\" DeptName=\"信息化运维2\">"
                + "<member CertNo=\"020110010003108002\" LoginName=\"201010003108\" Order=\"2\" Roles=\"33\" UserId=\"201010003108\" UserName=\"测试用人员1\">测试用人员1</member>"
                + "</dept-4></dept-3></dept-2></dept-1>"
                + "</dept-root>";

        List list = new ArrayList();
        try {
            list = dom4jXML.parseXML(str, null);
            System.out.println(list.size());
        } catch (DocumentException e) {
            e.printStackTrace();
        }


    }

    @Test
    public void test() {

        String str = "<dept-root DeptId=\"201010006162\" DeptName=\"海淀区\">"
                + "<dept-1 DeptId=\"201010008652\" DeptName=\"政府系统\">"
                + "<dept-2 DeptId=\"201010006262\" DeptName=\"审计局\">"
                + "<dept-3 DeptId=\"201010000070\" DeptName=\"机要局\">"
                + "<member CertNo=\"020110010003108002\" LoginName=\"201010003108\" Order=\"2\" Roles=\"33\" UserId=\"201010003108\" UserName=\"测试用人员1\">测试用人员1</member>"
                + "<dept-4 DeptId=\"201010003147\" DeptName=\"信息化运维2\">"
                + "<member CertNo=\"020110010003108002\" LoginName=\"201010003108\" Order=\"2\" Roles=\"33\" UserId=\"201010003108\" UserName=\"测试用人员1\">测试用人员1</member>"
                + "<member CertNo=\"020110010003108002\" LoginName=\"201010003108\" Order=\"2\" Roles=\"33\" UserId=\"201010003108\" UserName=\"测试用人员1\">测试用人员1</member>"
                + "</dept-4></dept-3></dept-2></dept-1>"
                + "</dept-root>";
        List list = new ArrayList();

        list = xmlUtils.parseSynData(str);


    }

}
