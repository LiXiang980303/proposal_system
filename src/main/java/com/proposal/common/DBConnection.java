package com.proposal.common;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnection {
    private static DataSource ds = null;
    private static String dbType = "ORACLE";
    public final static String DBTYPE_ORACLE = "ORACLE";
    public final static String DBTYPE_MYSQL = "MYSQL";
    public final static String DBTYPE_SQLSERVER = "MSSQLSERVER";
    public final static String DBTYPE_SYBASE = "SYBASE";
    public final static String DBTYPE_DB2 = "DB2";

    private static void initDateSource() {
        if (ds == null) {
            AbstractApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
            ds = (DataSource) context.getBean("dataSource");
            context.close();
        }
    }

    private DBConnection() {

    }

    public static String getDBType() {
        return dbType;
    }

    public static void setDBType(String type) {
        if (type != null)
            dbType = type.toUpperCase();
    }

    public static Connection getConnection() throws SQLException {
        try {
            initDateSource();
            Connection conn = ds.getConnection();
            return conn;
        } catch (Exception e) {
            throw new SQLException(e.getMessage());
        }
    }

    public static String getDateFromDate(String exp) {
        if (exp == null)
            return null;
        if (dbType != null && dbType.equalsIgnoreCase(DBTYPE_SYBASE)) {
            if (exp.trim().length() <= 10 && exp.trim().length() >= 8)
                exp += " 00:00:00";
            return "convert(DATETIME,'" + exp + "')";
        }
        if (dbType != null && dbType.equalsIgnoreCase(DBTYPE_DB2)) {
            if (exp.trim().length() <= 10 && exp.trim().length() >= 8)
                exp += " 00:00:00";
            return "TIMESTAMP('" + exp + "')";
        }
        if (dbType != null && dbType.equalsIgnoreCase(DBTYPE_SQLSERVER)) {
            if (exp.trim().length() <= 10 && exp.trim().length() >= 8)
                exp += " 00:00:00";
            return "CAST('" + exp + "' AS DATETIME)";
        }
        if (dbType != null && dbType.equalsIgnoreCase(DBTYPE_MYSQL)) {
            if (exp.trim().length() <= 10 && exp.trim().length() >= 8)
                exp += " 00:00:00";
            return " '" + exp + "' ";
        }
        if (exp.indexOf(".") > 0)
            exp = exp.substring(0, exp.indexOf("."));
        return "TO_DATE('" + exp + "','YYYY-MM-DD HH24-MI-SS')";
    }

    public static String getUpperCase(String str, boolean bDataBaseField) {
        if (bDataBaseField)
            return " Upper(" + str + ")";
        else
            return " Upper('" + str + "')";
    }

    public static void main(String[] args) throws SQLException {

//        Dao dao = new NutDao(ds);
//        dao.create(Attachment.class, false);

        /**
        DriverManagerDataSource ds = new DriverManagerDataSource();
        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/hdqw?characterEncoding=utf-8");
        ds.setUsername("root");
        ds.setPassword("root");
        Dao dao = new NutDao(ds);

        List<Department> deptList = new ArrayList<Department>();
        deptList = dao.query(Department.class, null);
        System.out.println(deptList.size());

        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setJdbcUrl("jdbc:mysql://localhost:3306/hdqw?characterEncoding=utf-8");
        ds.setUsername("root");
        ds.setPassword("root");
         */

        Connection conn = getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "select * FROM jc_meeting_info";

        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
        while (rs != null && rs.next()) {
            System.out.println("xxxxxxx");
        }
    }

}
