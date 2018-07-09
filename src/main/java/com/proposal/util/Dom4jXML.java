package com.proposal.util;

/**
 * Created by niu_ben on 2016/12/21.
 */

import java.util.*;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.tree.DefaultElement;

public class Dom4jXML {

    private static List<Map> list = new ArrayList<Map>();

    private static Map<String, String> map = new HashMap<String, String>();

    public static List<Map> parseXML(String xmlStr, Element temp_root) throws DocumentException {

        Element root;

        if (!"".equals(xmlStr) && xmlStr != null) {
            Document doc = DocumentHelper.parseText(xmlStr);
            root = doc.getRootElement();
        } else {
            root = temp_root;
        }

        if (root != null) {

            Map<String, String> map = new HashMap<String, String>();

            String name = root.getName();
            System.out.println("[currRoot] is " + root.getName());

            String Text = root.getTextTrim();

            if (!"".equals(Text)) {
                map.put("Text", Text);
                System.out.println("【text】 is ==" + root.getTextTrim());
            }

            List<Attribute> attrlist = root.attributes();
            System.out.println(attrlist.size());
            for (int i = 0; i < attrlist.size(); i++) {
                Attribute aa = attrlist.get(i);
                System.out.println("【" + aa.getName() + "】 is " + aa.getValue());
                map.put(aa.getName(), aa.getValue());
            }

            list.add(map);

            if (!"member".equals(name)) {
                try {
                    List list = root.content();
                    if (list.size() > 0) {
                        Element newRoot = (Element) list.get(0);
                        parseXML(null, newRoot);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                /**

                 List<DefaultElement> list = root.content();
                 if (list.size() > 0) {
                 DefaultElement deElement = list.get(0);
                 parseXML(null, list.get(0));
                 }

                 */

            }

        }

        return list;

    }


    public static Map<String, String> parseXML_MAP(String xmlStr, Element temp_root) throws DocumentException {

        Element root;

        if (!"".equals(xmlStr) && xmlStr != null) {
            Document doc = DocumentHelper.parseText(xmlStr);
            root = doc.getRootElement();
        } else {
            root = temp_root;
        }

        if (root != null) {

            Map<String, String> map = new HashMap<String, String>();

            String name = root.getName();

            System.out.println("getName====" + root.getName());

            String Text = root.getTextTrim();

            if (!"".equals(Text)) {
                map.put("Text", Text);
                System.out.println("text====" + root.getTextTrim());
            }

            List<Attribute> attrlist = root.attributes();
            for (int i = 0; i < attrlist.size(); i++) {
                Attribute aa = attrlist.get(i);
                System.out.println(aa.getName() + "-***--"
                        + aa.getValue());
                map.put(aa.getName(), aa.getValue());
            }

            list.add(map);

            if (!"member".equals(name)) {
                List<DefaultElement> list = root.content();
                if (list.size() > 0) {
                    parseXML(null, list.get(0));
                }

            }

        }

        return map;

    }

    public static void main(String[] args) {

        String xmlStr = "<dept-root DeptName=\"0\" DeptId=\"00\" ><dept-1 DeptName=\"1\" DeptId=\"11\" ><dept-2 DeptName=\"2\" DeptId=\"22\" ><dep-3 DepName=\"333\" DeptId=\"3333\"/></dept-2></dept-1></dept-root>";

        //xmlStr = "<dept-root DeptName=\"0\" DeptId=\"00\" ><dept-1 DeptName=\"1\" DeptId=\"11\" ><dept-2 DeptName=\"2\" DeptId=\"22\" ><member UserId=\"new\"  extend_prop1=\"\" extend_prop2=\"\">张三</member></dept-2></dept-1></dept-root>";

        //xmlStr ="<dept-root DeptId=\"005\" DeptName=\"北京市委\"><dept-1 DeptId=\"00501\" DeptName=\"测试部门1\"><member CertNo=\"029110010001230008\" LoginName=\"0001\" Roles=\"NA\" UserId=\"005001\" UserName=\"测试人员\">测试人员</member></dept-1></dept-root>";

        xmlStr = "<dept-root DeptId=\"005\" DeptName=\"北京市委\"><dept1 DeptId=\"00501\" DeptName=\"测试部门1\"><member CertNo=\"029110010001230008\" LoginName=\"？′éè？？\" Roles=\"33\" UserId=\"0050101\" UserName=\"测试人员\">测试人员</member><member CertNo=\"123456\" LoginName=\"？′éè？？\" Roles=\"NA\" UserId=\"0050102\" UserName=\"TEST1\">TEST1</member><dept2 DeptId=\"0501\" DeptName=\"1111\"/></dept1></dept-root>";

        String xmlStr_1 = "<dept-root DeptId=\"beijing\" DeptName=\"北京市\">"
                + "<dept-1 DeptId=\"201010000008\" DeptName=\"北京市委\">"
                + "<dept-2 DeptId=\"201010000010\" DeptName=\"市委办公厅\">"
                + "<dept-3 DeptId=\"201010000070\" DeptName=\"机要局\">"
                + "<dept-4 DeptId=\"201010003147\" DeptName=\"信息化运维2\">"
                + "<member CertNo=\"020110010003108002\" LoginName=\"201010003108\" Order=\"2\" Roles=\"33\" UserId=\"201010003108\" UserName=\"测试用人员1\">测试用人员1</member>"
                + "</dept-4></dept-3></dept-2></dept-1>"
                + "</dept-root>";

        try {
            //List list =Dom4jXML.parseXML2(xmlStr, null);
            //System.out.println(list.size());

            List list = Dom4jXML.parseXML(xmlStr_1, null);
            System.out.println(list.size());


        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }

    private static void xmlTest(String xml) {
        try {
            Document doc = new SAXReader().read(xml);
            Element root = doc.getRootElement();
            Element foo;
            for (Iterator t = root.elementIterator("VALUE"); t.hasNext(); ) {
                foo = (Element) t.next();
                System.out.println(":" + foo.elementText("NO"));
                System.out.println(":" + foo.elementText("NO"));
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }

    }


}