package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class FetchData {

	private static Connection connection = null;

	/** Uses JNDI and Datasource (preferred style). */
	public static Connection getJNDIConnection() {
		String DATASOURCE_CONTEXT = "java:comp/env/jdbc/tutorial_learnit";

		try {
			Context initialContext = new InitialContext();

			DataSource datasource = (DataSource) initialContext.lookup(DATASOURCE_CONTEXT);
			if (datasource != null) {
				connection = datasource.getConnection();
			} else {
				log("Failed to lookup datasource.");
			}
		} catch (NamingException ex) {
			log("Cannot get connection: " + ex);
		} catch (SQLException ex) {
			log("Cannot get connection: " + ex);
		}
		return connection;
	}

	private static void log(Object aObject) {
		System.out.println(aObject);
	}

	public static ArrayList<Content> getAllContent(String sh) {
		connection = FetchData.getJNDIConnection();
		ArrayList<Content> contentList = new ArrayList<Content>();
		try {

			String sql = "SELECT tutorial_content, tutorial_subheading FROM learnit_content WHERE tutorial_subheading = ?";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, sh);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Content content = new Content();
				content.settutorialContent(rs.getString("tutorial_content"));
				content.settutorialName(rs.getString("tutorial_subheading"));
				contentList.add(content);
			}
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return contentList;
	}
}
