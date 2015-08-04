<html>
<body>
<h1>Chapter1</h1>
<h2>STUDPID DAO</h2>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre>
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
<pre>
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("com.mysql.jdbc.Driver"); -mysql
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:mysql://localhost/spring","spring","book");
		
		Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into users(id,name,password) values(?,?,?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
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
	
</body>
</html>

