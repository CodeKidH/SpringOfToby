<%@include file="include.jsp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">


function makeGreen(a) {
	
	var node = document.createElement("pre");
    var text = document.getElementById(a);
    text.removeAttribute("style")
    var iframe = document.getElementsByTagName('iframe')[0];
    var doc = iframe.contentWindow.document;
    
    node.appendChild(text);
    doc.body.appendChild(node);
    
  }
</script>
</head>
<body>


<table border="1">
	<colgroup>
		<col width="600"/>
		<col width="600"/>
	</colgroup>
	<tr>
		<td valign="top">
			<h2 style="color:">1.STUDPID DAO</h2>
				<input type="button" onclick="makeGreen('a1')" value="User">
				<input type="button" onclick="makeGreen('a2')" value="UserDao">
			<H2 style="color:">2.Let's separate concerns</H2>
				<input type="button" onclick="makeGreen('b1')" value="User">
				<input type="button" onclick="makeGreen('b2')" value="UserDao">
		</td>
		<td valign="top">
		   <iframe name="ifrm" id="ifrm" width="1500" height="800" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes"></iframe>
		</td>
	</tr>
</table>


<div id="a1" style="display: none" onclick="makeGreen()">

public class User {
	
	String id;
	
	String name;
	String password;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
</div>
<div id="a2" style="display: none">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("com.mysql.jdbc.Driver"); -mysql
		Class.forName("oracle.jdbc.driver.OracleDriver");------------------------> first concerns
		//Connection c = DriverManager.getConnection("jdbc:mysql://localhost/spring","spring","book");
		
		Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into users(id,name,password) values(?,?,?)"); --------->second concerns
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close(); ---------------------------> third concerns
		c.close();
	}
	
	public User get(String id)throws ClassNotFoundException, SQLException{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps = c.prepareStatement("select * from users where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		User user = new User();
		user.setId(rs.getString("id"));
		user.setName(rs.getString("name"));
		user.setPassword("password");
		
		rs.close();
		ps.close();
		c.close();
		
		return user;
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException{
		UserDao dao = new UserDao();
		
		User user = new User();
		user.setId("white");
		user.setName("jh");
		user.setPassword("1111");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}
</div>

<div id="b1" style="display: none" onclick="makeGreen()">

public class User {
	
	String id;
	
	String name;
	String password;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
</div>
<div id="b2" style="display: none">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = getConnection();
		
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	public User get(String id)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		User user = new User();
		user.setId(rs.getString("id"));
		user.setName(rs.getString("name"));
		user.setPassword("password");
		
		rs.close();
		ps.close();
		c.close();
		
		return user;
	}
	========================================================================================
	private Connection getConnection() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
	=========================================Refactory=======================================
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException{
		UserDao dao = new UserDao();
		
		User user = new User();
		user.setId("wh");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}
</div>
</body>
</html>