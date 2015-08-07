<%@include file="include.jsp"%>
<html>
<body style="background:#041303">
<h1 style="color:#FCF9F9">Chapter1 - Object and DI</h1>
<h2 style="color:#FCF9F9">1.STUDPID DAO</h2>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
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
</pre>
</div>

<br>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>userdao</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
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
</pre>
</div>


<!-- <a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';"href="javascript:void(0)">open</a><div style="DISPLAY: none">contents<a onclick="this.parentNode.style.display='none';" href="javascript:void(0)">close</a></div> -->
<H2 style="color:#FCF9F9">2.Let's separate concerns</H2>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>userdao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
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
</font>
</pre>
</div>

<H2 style="color:#FCF9F9">3.extends DAO by using extends</H2>
<H3 style="color:#FCF9F9">< Factory Pattern, Template Method Pattern ></H3>
<H3 style="color:#FCF9F9">< IOC ></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>userdao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
====================================
we use a template method pattern or factory pattern
===================================

package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public abstract class UserDao { ---------------------------->>abstract
	
	
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
=====================================================================================	
	public abstract Connection getConnection() throws ClassNotFoundException, SQLException;
======================================================================================
	
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException{
		UserDao dao = new DUserDao(); ----------->>>
		
		User user = new User();
		user.setId("asd");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}

</pre>
</div>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[NUserDao]':'[NUserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>NUserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class NUserDao extends UserDao{
	public Connection getConnection()throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}

</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DUserDao]':'[DUserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DUserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DUserDao extends UserDao{
	public Connection getConnection()throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}

</pre>
</div>

<H2 style="color:#FCF9F9">4.extends DAO by using Class</H2>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	
	============================================================
	private SimpleConnectionMaker simpleConnectionMaker;
	
	public UserDao(){
		simpleConnectionMaker = new SimpleConnectionMaker();
	}
	===============================================================
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = simpleConnectionMaker.getConnection(); ---->>>>>>>>>>>>change
		
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
		Connection c = simpleConnectionMaker.getConnection();
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
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException{
		UserDao dao = new UserDao();
		
		User user = new User();
		user.setId("asd");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}


</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[SimpleConnectionMaker]':'[SimpleConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>SimpleConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SimpleConnectionMaker {
	public Connection getConnection() throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}
</font>
</pre>
</div>

<H2 style="color:#FCF9F9">5.extends DAO by using Interface</H2>
<H3 style="color:#FCF9F9">< DI ></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	=========================================================
	private ConnectionMaker connectionMaker;
	
	public UserDao(){
		connectionMaker = new DConnectionMaker(); ----->> issue : the company that use this class have to change
	}
	========================================================
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = connectionMaker.makeConnection();
		
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
		Connection c = connectionMaker.makeConnection();
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
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException{
		UserDao dao = new UserDao();
		
		User user = new User();
		user.setId("as11d");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[interface ConnectionMaker]':'[interface ConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>interface ConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionMaker {
	public Connection makeConnection() throws ClassNotFoundException, SQLException;
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DConnectionMaker]':'[DConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DConnectionMaker implements ConnectionMaker{
	public Connection makeConnection() throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}


</font>
</pre>
</div>

<H2 style="color:#FCF9F9">6.Make a Client and Client can choose a DBConnection</H2>
<H3 style="color:#FCF9F9">< Strategy Pattern ></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	
	private ConnectionMaker connectionMaker;
	
	public UserDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = connectionMaker.makeConnection();
		
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
		Connection c = connectionMaker.makeConnection();
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
	====================================================
	Remove a main method
	====================================================
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.SQLException;

public class UserDaoTest {
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		
		ConnectionMaker connectionMaker = new DConnectionMaker();
		
		UserDao dao = new UserDao(connectionMaker);
		
		User user = new User();
		user.setId("as11d");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[ConnectionMaker]':'[ConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>ConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionMaker {
	public Connection makeConnection() throws ClassNotFoundException, SQLException;
}
</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DConnectionMaker]':'[DConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DConnectionMaker implements ConnectionMaker{
	public Connection makeConnection() throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}

</font>
</pre>
</div>


<H2 style="color:#FCF9F9">7.Use a Factory</H2>
<H3 style="color:#FCF9F9">< Factory is a Class or method that return a object we need ></H3>
<H3 style="color:#FCF9F9">< IOC ></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	
	private ConnectionMaker connectionMaker;
	
	public UserDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = connectionMaker.makeConnection();
		
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
		Connection c = connectionMaker.makeConnection();
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
	====================================================
	Remove a main method
	====================================================
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.SQLException;

public class UserDaoTest {
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		
		UserDao dao = new DaoFactory().userDao(); ------>change
		
		User user = new User();
		user.setId("as11d");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[ConnectionMaker]':'[ConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>ConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionMaker {
	public Connection makeConnection() throws ClassNotFoundException, SQLException;
}
</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DConnectionMaker]':'[DConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DConnectionMaker implements ConnectionMaker{
	public Connection makeConnection() throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DaoFactory]':'[DaoFactory]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DaoFactory</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class DaoFactory {
	public UserDao userDao(){
		ConnectionMaker connectionMaker = new DConnectionMaker(); ----------->choose a connection
		UserDao userDao =new UserDao(connectionMaker);
		return userDao;
	}
}

</font>
</pre>
</div>

<H2 style="color:#FCF9F9">8.Improve a Factory</H2>
<H3 style="color:#FCF9F9"></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	
	private ConnectionMaker connectionMaker;
	
	public UserDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = connectionMaker.makeConnection();
		
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
		Connection c = connectionMaker.makeConnection();
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
	====================================================
	Remove a main method
	====================================================
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.SQLException;

public class UserDaoTest {
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		
		UserDao dao = new DaoFactory().userDao(); ------>change
		
		User user = new User();
		user.setId("as11d");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[ConnectionMaker]':'[ConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>ConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionMaker {
	public Connection makeConnection() throws ClassNotFoundException, SQLException;
}
</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DConnectionMaker]':'[DConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DConnectionMaker implements ConnectionMaker{
	public Connection makeConnection() throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DaoFactory]':'[DaoFactory]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DaoFactory</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class DaoFactory {
	public UserDao userDao(){
	===================================================================	
	/*	ConnectionMaker connectionMaker = new DConnectionMaker();
		UserDao userDao =new UserDao(connectionMaker);*/
		
		return new UserDao(new DConnectionMaker());
	}
	 
	public AccountDao accountDao(){
		return new AccountDao(new DConnectionMaker());
	}
	==================================================================
	v
	v Improve
	v
	v
	
public class DaoFactory {

	public UserDao userDao(){
		return new UserDao(connectionMaker());
	}
	
	public AccountDao accountDao(){
		return new AccountDao(connectionMaker());
	}
	
	public ConnectionMaker connectionMaker(){
		return new DConnectionMaker();
	}
	
}

</font>
</pre>
</div>


<H2 style="color:#FCF9F9">9.Change the factory from normal to SPRING </H2>
<H3 style="color:#FCF9F9">< START SPRING ></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	
	private ConnectionMaker connectionMaker;
	
	public UserDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = connectionMaker.makeConnection();
		
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
		Connection c = connectionMaker.makeConnection();
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
	====================================================
	Remove a main method
	====================================================
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.SQLException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class UserDaoTest {
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		
		===================================================================================
		ApplicationContext context = new AnnotationConfigApplicationContext(DaoFactory.class);
		UserDao dao = context.getBean("userDao",UserDao.class);
		===================================================================================
		User user = new User();
		user.setId("as11");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[ConnectionMaker]':'[ConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>ConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionMaker {
	public Connection makeConnection() throws ClassNotFoundException, SQLException;
}
</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DConnectionMaker]':'[DConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DConnectionMaker implements ConnectionMaker{
	public Connection makeConnection() throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DaoFactory]':'[DaoFactory]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DaoFactory</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;
===============================
This is a config file, like a xml file 
================================
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration  ----------->>>ADD
public class DaoFactory {
	
	@Bean  ----------->>>ADD
	public UserDao userDao(){
		
	/*	ConnectionMaker connectionMaker = new DConnectionMaker();
		UserDao userDao =new UserDao(connectionMaker);*/
		
		return new UserDao(connectionMaker());
	}
	
	@Bean   ----------->>>ADD
	public ConnectionMaker connectionMaker(){
		return new DConnectionMaker();
	}
	
}
	public ConnectionMaker connectionMaker(){
		return new DConnectionMaker();
	}
	
}

</font>
</pre>
</div>

<H2 style="color:#FCF9F9">10.Add a function of counting by using DI </H2>
<H3 style="color:#FCF9F9">< how to use DI in Spring ></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	
	private ConnectionMaker connectionMaker;
	
	public UserDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = connectionMaker.makeConnection();
		
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
		Connection c = connectionMaker.makeConnection();
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
	====================================================
	Remove a main method
	====================================================
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.SQLException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class UserDaoTest {
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		
		ApplicationContext context = new AnnotationConfigApplicationContext(DaoFactory.class);
		UserDao dao = context.getBean("userDao",UserDao.class);
		
		User user = new User();
		user.setId("asasda11");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
		
		=================================================================================================
		CountingConnectionMaker ccm = context.getBean("connectionMaker",CountingConnectionMaker.class);
		System.out.println("count"+ ccm.getCounter());
		=================================================================================================
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[ConnectionMaker]':'[ConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>ConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionMaker {
	public Connection makeConnection() throws ClassNotFoundException, SQLException;
}
</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DConnectionMaker]':'[DConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DConnectionMaker implements ConnectionMaker{
	public Connection makeConnection() throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DaoFactory]':'[DaoFactory]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DaoFactory</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DaoFactory {
	
	@Bean
	public UserDao userDao(){
		
	/*	ConnectionMaker connectionMaker = new DConnectionMaker();
		UserDao userDao =new UserDao(connectionMaker);*/
		
		return new UserDao(connectionMaker());
	}
	==============================================================================
	@Bean
	public ConnectionMaker realConnectionMaker(){
		return new DConnectionMaker();
	}
	
	@Bean
	public ConnectionMaker connectionMaker(){
		return new CountingConnectionMaker(realConnectionMaker());
	}
	==============================================================================
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[CountingConnectionMaker]':'[CountingConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>CountingConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public class CountingConnectionMaker implements ConnectionMaker{
	int counter = 0;
	
	private ConnectionMaker realConnectionMaker;
	
	public CountingConnectionMaker(ConnectionMaker realConnectionMaker){
		this.realConnectionMaker = realConnectionMaker;
	}
	
	public Connection makeConnection() throws ClassNotFoundException, SQLException{
		this.counter++;
		return realConnectionMaker.makeConnection();
	}
	
	public int getCounter(){
		return this.counter;
	}
}


</font>
</pre>
</div>

<H2 style="color:#FCF9F9">11.use a DI By using setterMethod </H2>
<H3 style="color:#FCF9F9">< setterMethod ></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	
	private ConnectionMaker connectionMaker;
	
	=============================================================================
	public void setConnectionMaker(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}
	=============================================================================
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = connectionMaker.makeConnection();
		
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
		Connection c = connectionMaker.makeConnection();
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
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.SQLException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class UserDaoTest {
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		
		ApplicationContext context = new AnnotationConfigApplicationContext(DaoFactory.class);
		UserDao dao = context.getBean("userDao",UserDao.class);
		
		User user = new User();
		user.setId("asasda11");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
		
		CountingConnectionMaker ccm = context.getBean("connectionMaker",CountingConnectionMaker.class);
		System.out.println("count"+ ccm.getCounter());
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[ConnectionMaker]':'[ConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>ConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionMaker {
	public Connection makeConnection() throws ClassNotFoundException, SQLException;
}
</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DConnectionMaker]':'[DConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DConnectionMaker implements ConnectionMaker{
	public Connection makeConnection() throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DaoFactory]':'[DaoFactory]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DaoFactory</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DaoFactory {
	
	@Bean
	public UserDao userDao(){
		=================================================
		UserDao userDao = new UserDao();
		userDao.setConnectionMaker(connectionMaker());
		return userDao;
		==================================================
	}
	@Bean
	public ConnectionMaker realConnectionMaker(){
		return new DConnectionMaker();
	}
	
	@Bean
	public ConnectionMaker connectionMaker(){
		return new CountingConnectionMaker(realConnectionMaker());
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[CountingConnectionMaker]':'[CountingConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>CountingConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public class CountingConnectionMaker implements ConnectionMaker{
	int counter = 0;
	
	private ConnectionMaker realConnectionMaker;
	
	public CountingConnectionMaker(ConnectionMaker realConnectionMaker){
		this.realConnectionMaker = realConnectionMaker;
	}
	
	public Connection makeConnection() throws ClassNotFoundException, SQLException{
		this.counter++;
		return realConnectionMaker.makeConnection();
	}
	
	public int getCounter(){
		return this.counter;
	}
}


</font>
</pre>
</div>

<H2 style="color:#FCF9F9">12.use a xml file instead of DaoFactory configuration </H2>
<H3 style="color:#FCF9F9">< configration of xml ></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDao {
	
	private ConnectionMaker connectionMaker;
	
	public void setConnectionMaker(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = connectionMaker.makeConnection();
		
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
		Connection c = connectionMaker.makeConnection();
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
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.SQLException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class UserDaoTest {
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
	
	
		==============================================================================================
		ApplicationContext context = new GenericXmlApplicationContext("/toby/applicationContext.xml");
		UserDao dao = context.getBean("userDao",UserDao.class);
		================================================================================================
		
		
		User user = new User();
		user.setId("as221");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
		
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[ConnectionMaker]':'[ConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>ConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.SQLException;

public interface ConnectionMaker {
	public Connection makeConnection() throws ClassNotFoundException, SQLException;
}
</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DConnectionMaker]':'[DConnectionMaker]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DConnectionMaker</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DConnectionMaker implements ConnectionMaker{
	public Connection makeConnection() throws ClassNotFoundException,SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id = "connectionMaker" class = "toby.DConnectionMaker"/>
	
	<bean id = "userDao" class="toby.UserDao">
		<property name="connectionMaker" ref="connectionMaker"/>
	</bean>
</beans>

</font>
</pre>
</div>

<H2 style="color:#FCF9F9">13.Change a DBConnection from java to xml, use a dataSource </H2>
<H3 style="color:#FCF9F9">< dataSource is interface fixed ></H3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;


public class UserDao {
	
	======================================================================
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	======================================================================
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = dataSource.getConnection();
		
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
		Connection c = dataSource.getConnection();
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
	
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.SQLException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class UserDaoTest {
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
	
	
		ApplicationContext context = new GenericXmlApplicationContext("/toby/applicationContext.xml");
		UserDao dao = context.getBean("userDao",UserDao.class);
		
		
		User user = new User();
		user.setId("as221");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
		
	}
}

</font>
</pre>
</div>



<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
</beans>
</font>
</pre>
</div>

</body>
</html>

