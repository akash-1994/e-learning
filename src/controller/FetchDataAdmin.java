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

public class FetchDataAdmin {

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

	public static ArrayList<ContentAdmin> getAllContent(String tn) {
		connection = FetchDataAdmin.getJNDIConnection();
		ArrayList<ContentAdmin> contentList = new ArrayList<ContentAdmin>();
		try {

			String sql = "SELECT tutorial_subheading  FROM learnit_content WHERE tutorial_name = ?";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, tn);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				ContentAdmin contentAdmin = new ContentAdmin();
				contentAdmin.settutorialSubheading(rs.getString("tutorial_subheading"));
				contentList.add(contentAdmin);
			}
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return contentList;
	}

	public static ArrayList<ContentAdmin> getAllContentEdit(String stn) {
		connection = FetchDataAdmin.getJNDIConnection();
		ArrayList<ContentAdmin> contentList = new ArrayList<ContentAdmin>();
		try {

			String sql = "SELECT tutorial_content  FROM learnit_content WHERE tutorial_subheading = ?";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, stn);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				ContentAdmin contentAdmin = new ContentAdmin();
				contentAdmin.setTutContent(rs.getString("tutorial_content"));
				contentList.add(contentAdmin);
			}
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return contentList;
	}

}
