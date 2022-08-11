package com.mukwano;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class DBOperations {
    //dbConnection
    static Connection connection(){
        Connection connection = null;
        try {
            Class.forName("org.sqlite.JDBC");
            String dbPath = DBOperations.class.getProtectionDomain().getCodeSource().getLocation().getPath();
            dbPath = dbPath.substring(0,dbPath.indexOf("MukwanoIndustries"))+"MukwanoIndustries/database.sqlite";

            connection =  DriverManager.getConnection("jdbc:sqlite:"+dbPath);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    //select
    public static List<HashMap<String, String>> select(String query){
        List<HashMap<String, String>> data = new ArrayList<>();
        try {
            Connection connection = connection();
            ResultSet resultSet = connection.createStatement().executeQuery(query);
            ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
            int colLength = resultSetMetaData.getColumnCount();

            while (resultSet.next()){
                HashMap<String, String> map = new HashMap<>();
                for(int i=1; i<=colLength; i++){
                    map.put(resultSetMetaData.getColumnName(i), resultSet.getString(i));
                }
                data.add(map);
            }

            connection.close();
        } catch (SQLException e) {
            HashMap<String, String> map = new HashMap<>();
            map.put("error", e.getMessage());
            data.add(map);
        }
        return data;
    }

    private static HashMap<String, String> executeQuery(String query) {
        HashMap<String, String> returnMessage = new HashMap<>();
        try {
            Connection connection = connection();
            int exec = connection.createStatement().executeUpdate(query);
            returnMessage.put("success",""+exec);
            connection.close();
        } catch (SQLException e) {
            returnMessage.put("error",e.getMessage());
        }
        return returnMessage;
    }

    //insert
    public static HashMap<String, String> insert(String query) {
        return executeQuery(query);
    }

    //update
    public static HashMap<String, String> update(String query){
        return executeQuery(query);
    }
}
