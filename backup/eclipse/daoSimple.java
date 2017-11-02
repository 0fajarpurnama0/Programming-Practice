package dao; // Data Access Object Pattern or DAO pattern is used to separate low level data accessing API or operations from high level business services.
import java.util.*; // Java.util package contains the collections framework, legacy collection classes, event model, date and time facilities, internationalization, and miscellaneous utility classes. (* is a wild card, here calls all package starting with java.util)
import java.sql.*; // Provides the API for accessing and processing data stored in a data source (usually a relational database) using the JavaTM programming language.

/**
 * Very simple sample class for data access object
 * @author nakano@cc.kumamoto-u.ac.jp
 * @version 20140617
 */
public class DaoSimple { // Creates a public class DaoSimple.
	// these three parameters are set at the external file sys.properties / これらの3変数は、外部ファイル sys.properties で決まる
	private String dbDriver = null; // Initialize database driver variable.
	private String dbUri = null; // Initialize database uri variable.
	private Properties dbProps = null; // Initialize database properties variable.

	/**
	 * Constructor
	 * read parameters for db access from external file
	 */
	public DaoSimple() { // The try and catch is used to deal with exceptions (i.e. wrong user or password input)
		try { // Try the following:
			ResourceBundle bundle = ResourceBundle.getBundle("sys"); // set config file as "src/sys.property" / 設定ファイルは"src/sys.property"
			// get following parameters from above file / 上記ファイルから以下のパラメータを読み込む
			dbDriver = bundle.getString("driver"); // From this resource bundle gets the strings from "driver" key.
			dbUri = bundle.getString("uri"); // From this resource bundle gets the strings from "uri" key.
			dbProps = new Properties(); // Creating an object dbProps from the constructor Properties().
			dbProps.put("user", bundle.getString("user")); // On dbProps put the key "user" from "user" string on sys.property.
			dbProps.put("password", bundle.getString("password")); // On dbProps put the key "password" from "password" on sys.property.
			dbProps.put("characterEncoding", "UTF8"); // need for multibyte chars, set the key as UTF8. / 日本語等ではこれが必要
		} catch (MissingResourceException e) { // If above fails execute this MissingResourceException.
			e.printStackTrace(); // Prints the default error stream.
		}
	}
	
	/**
	 * getAll() method
	 * get all data from "comment" table
	 */
	public ArrayList<LinkedHashMap<String,Object>> getAll() { // Creates an ArrayList with link list hash map string object, using getAll() to retrieve an enumeration of the attributes in the attribute set.
		ArrayList<LinkedHashMap<String,Object>> ret = new ArrayList<LinkedHashMap<String,Object>>(); // Creates an object ret.
		String queryStr = "select * from comment order by last desc"; // Set queryStr variable as an sql command to query all from comment in order by last desc.
		Connection conn = null; // these three variables for db connection, connection variable / ここからの3変数はDB接続に使用
		Statement state = null; // Initialize statement variable.
		ResultSet rs = null; // Initialize result set variable.
		try {
			Class.forName(dbDriver).newInstance(); // Instantiation of mySQL jdbc driver, instance and object are the same. / mySQLのjdbcドライバのインスタンス化
			System.out.println("Class.forName(dbDriver).newInstance().toString()="+Class.forName(dbDriver).newInstance().toString()); // Print command.
			conn = DriverManager.getConnection(dbUri, dbProps); // From java.sql.DriverManager, connect and get uri and props of database.
			conn.setAutoCommit(true); // Prevents explicitly commit other transaction from java.
			state = conn.createStatement(); // Creates an interface that represents a SQL statement.
			rs = state.executeQuery(queryStr); // executing query / queryの実行
			ArrayList<String> key = new ArrayList<String>(); // Creates an object.
			// obtain column name / カラム名の取得
			for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
				key.add(rs.getMetaData().getColumnName(i)); // add column names to keys / カラム名のリストをキーに追加
			}
			// obtain query results / queryの結果を得る
			LinkedHashMap<String,Object> line; // for restoring 1 line (row) data / 1行分のデータ記憶用
			while (rs.next()) { // While there is a next row on the database table.
				line = new LinkedHashMap<String,Object>(); // Create a new object.
				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					line.put(key.get(i-1), rs.getObject(i)); // Put key and value to line.
				}
				ret.add(line); // Protected so only static method can create new object, add to line.
			}
			//for exception
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { // Close the connection.
			try {
				rs.close();
				state.close();
				conn.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		System.out.println("ret=" + ret.toString());
		return ret;
	}
	
	/**
	 * addLine() method
	 * add a line to "comment" table
	 */
	public LinkedHashMap<String,Object> addLine(LinkedHashMap<String,Object> line) {
		LinkedHashMap<String,Object> ret = new LinkedHashMap<String,Object>();
		Connection conn = null; // these two variables for db connection / ここからの2変数はDB接続に使用
		Statement state = null;
		try {
			Class.forName(dbDriver).newInstance(); // Instantiation of mySQL jdbc driver. / mySQLのjdbcドライバのインスタンス化
			conn = DriverManager.getConnection(dbUri, dbProps);
			conn.setAutoCommit(true);
			state = conn.createStatement();
			PreparedStatement pStr = null;
			String sStr = null;
			sStr = "insert into comment (name, text, ip, last) values (?, ?, ?, ?)"; // An sql statement to insert value into column.
			pStr = conn.prepareStatement(sStr);
			pStr.setString(1, line.get("name").toString()); // Set key "1" as name string.
			pStr.setString(2, line.get("text").toString()); // Set key "2" as text string.
			pStr.setString(3, line.get("ip").toString()); // Set key "3" as ip string.
			pStr.setTimestamp(4, java.sql.Timestamp.valueOf(line.get("last").toString())); // Set key "4" as time stamp.
			pStr.execute(); // Execute statement.
			ret.put("number of added lines", pStr.getUpdateCount());
			//for exception
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				state.close();
				conn.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return ret;
	}

	/**
	 * main method for check
	 * @param args
	 */
	public static void main(String[] args) {
		DaoSimple dao = new DaoSimple(); // new object
		LinkedHashMap<String,Object> line = new LinkedHashMap<String,Object>(); // new object
		line.put("name", "名前"); line.put("text", "文章よ"); line.put("ip", "133.95.45.1"); line.put("last", "2014-02-03 18:42:00");
		System.out.println("add = " + dao.addLine(line));
		ArrayList<LinkedHashMap<String,Object>>  all = dao.getAll();
		for(LinkedHashMap<String,Object> l : all) {
			for(String key : l.keySet()) {
				System.out.print(key+":"+l.get(key)+", ");
			}
			System.out.println("");
		}
	}
	
}
