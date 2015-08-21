<%@include file="include.jsp"%>
<html>
<body style="background:#041303">
<h1 style="color:#FCF9F9">Chapter4 - Abstract Service</h1>


<h2 style="color:#FCF9F9">1.User level - apply a enum</h2>
<h3 style="color:#FCF9F9"># changed : User, UserDaoTest, Level</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	===========================================================================
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	
	
	public User(String id, String name, String password, Level level,
			int login, int recommend){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	===========================================================================
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


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoJdbc]':'[UserDaoJdbc]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoJdbc</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class UserDaoJdbc implements UserDao{
	
	private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
		
		this.jdbcTemplate.update("insert into dao(id,name,password)value(?,?,?)",user.getId(),user.getName(),user.getPassword());
	}
	public User get(String id)throws  SQLException{
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	public void deleteAll() throws SQLException{
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	
	
	public int getCount() throws SQLException{
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			return user;
		}
	};
	
	
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


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		===========================================================================
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0);
		this.user1 = new User("v","v","v",Level.SILVER,55,10);
		this.user2 = new User("z","z","z",Level.GOLD,100,40);
		===========================================================================
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		===========================================================================
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		assertThat(userget2.getName(), is(user2.getName()));
		assertThat(userget2.getPassword(),is(user2.getPassword()));
		===========================================================================
		
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		
		List<User> users0 =dao.getAll();
		assertThat(users0.size(), is(0));
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user3);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(1));
		checkSameUser(user1, users3.get(0));
		checkSameUser(user2, users3.get(2));
		
		
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[enum Level]':'[enum Level]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>enum Level</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public enum Level {
	
	BASIC(1), GOLD(3),SILVER(2);
	
	private final int value;
	
	Level(int value){
		this.value = value;
	}
	
	public int intValue(){
		return value;
	}
	
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao(I)]':'[UserDao(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">2.User level - modify UserDao</h2>
<h3 style="color:#FCF9F9"># changed : UserDao</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	
	
	public User(String id, String name, String password, Level level,
			int login, int recommend){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoJdbc]':'[UserDaoJdbc]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoJdbc</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;



public class UserDaoJdbc implements UserDao{
	
	private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend)value(?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			return user;
		}
	};
	
	
	
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


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0);
		this.user1 = new User("v","v","v",Level.SILVER,55,10);
		this.user2 = new User("z","z","z",Level.GOLD,100,40);
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		assertThat(userget2.getName(), is(user2.getName()));
		assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		
		List<User> users0 =dao.getAll();
		assertThat(users0.size(), is(0));
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user3);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(1));
		checkSameUser(user1, users3.get(0));
		checkSameUser(user2, users3.get(2));
		
		
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[enum Level]':'[enum Level]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>enum Level</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public enum Level {
	
	BASIC(1), GOLD(3),SILVER(2);
	
	private final int value;
	
	Level(int value){
		this.value = value;
	}
	
	public int intValue(){
		return value;
	}
	
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao(I)]':'[UserDao(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">3.User level - add a function of update()</h2>
<h3 style="color:#FCF9F9"># changed : UserDao, UserDaoTest, UserDaoJdbc</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	
	
	public User(String id, String name, String password, Level level,
			int login, int recommend){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoJdbc]':'[UserDaoJdbc]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoJdbc</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend)value(?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	=============================================================================================
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ? where id = ?", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),
				user.getId());
	}
	=============================================================================================
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			return user;
		}
	};
	
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


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0);
		this.user1 = new User("v","v","v",Level.SILVER,55,10);
		this.user2 = new User("z","z","z",Level.GOLD,100,40);
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		
		List<User> users0 =dao.getAll();
		assertThat(users0.size(), is(0));
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user3);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(1));
		checkSameUser(user1, users3.get(0));
		checkSameUser(user2, users3.get(2));
		
		
	}
	================================================
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
	}
	================================================
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}



</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[enum Level]':'[enum Level]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>enum Level</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public enum Level {
	
	BASIC(1), GOLD(3),SILVER(2);
	
	private final int value;
	
	Level(int value){
		this.value = value;
	}
	
	public int intValue(){
		return value;
	}
	
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao(I)]':'[UserDao(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}



</font>
</pre>
</div>


<h2 style="color:#FCF9F9">4.UserService.upgradeLevel() - add a UserService</h2>
<h3 style="color:#FCF9F9"># changed : applicationContext.xml, UserService, UserServiceTest</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	
	
	public User(String id, String name, String password, Level level,
			int login, int recommend){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoJdbc]':'[UserDaoJdbc]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoJdbc</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend)value(?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	=============================================================================================
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ? where id = ?", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),
				user.getId());
	}
	=============================================================================================
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			return user;
		}
	};
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
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
	===================================================
	<bean id ="userService" class="toby.UserService">
		<property name="userDao" ref="userDao"/>
	</bean>
	===================================================
	<bean id="userDao" class="toby.UserDaoJdbc">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>
</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0);
		this.user1 = new User("v","v","v",Level.SILVER,55,10);
		this.user2 = new User("z","z","z",Level.GOLD,100,40);
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		List<User> users0 =dao.getAll();
		assertThat(users0.size(), is(0));
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user3);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(1));
		checkSameUser(user1, users3.get(0));
		checkSameUser(user2, users3.get(2));
		
	}
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
	}
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[enum Level]':'[enum Level]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>enum Level</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public enum Level {
	
	BASIC(1), GOLD(3),SILVER(2);
	
	private final int value;
	
	Level(int value){
		this.value = value;
	}
	
	public int intValue(){
		return value;
	}
	
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao(I)]':'[UserDao(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserService]':'[UserService]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserService</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class UserService {
	
	UserDao userDao;
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserServiceTest]':'[UserServiceTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserServiceTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserService userService;
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">5.UserService.upgradeLevel() - add a function of update and test in userService </h2>
<h3 style="color:#FCF9F9"># changed : UserService, UserServiceTest</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	
	
	public User(String id, String name, String password, Level level,
			int login, int recommend){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoJdbc]':'[UserDaoJdbc]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoJdbc</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend)value(?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ? where id = ?", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			return user;
		}
	};
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
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
	
	<bean id ="userService" class="toby.UserService">
		<property name="userDao" ref="userDao"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDaoJdbc">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>
</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0);
		this.user1 = new User("v","v","v",Level.SILVER,55,10);
		this.user2 = new User("z","z","z",Level.GOLD,100,40);
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		List<User> users0 =dao.getAll();
		assertThat(users0.size(), is(0));
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user3);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(1));
		checkSameUser(user1, users3.get(0));
		checkSameUser(user2, users3.get(2));
		
	}
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
	}
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[enum Level]':'[enum Level]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>enum Level</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public enum Level {
	
	BASIC(1), GOLD(3),SILVER(2);
	
	private final int value;
	
	Level(int value){
		this.value = value;
	}
	
	public int intValue(){
		return value;
	}
	
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao(I)]':'[UserDao(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserService]':'[UserService]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserService</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public class UserService {
	
	UserDao userDao;
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	=============================================================================
	public void upgradeLevels(){
		List<User> users = userDao.getAll();
		for(User user : users){
			Boolean changed = null;
			if(user.getLevel() == Level.BASIC && user.getLogin() >= 50){
				user.setLevel(Level.SILVER);
				changed = true;
			}else if(user.getLevel() == Level.SILVER && user.getRecommend() >= 30){
				user.setLevel(Level.GOLD);
				changed = true;
			}else if(user.getLevel() == Level.GOLD){
				changed = false;
			}else{
				changed = false;
			}
			if(changed){
				userDao.update(user);
			}
		}
	}
=============================================================================
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserServiceTest]':'[UserServiceTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserServiceTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserDao userDao;
	
	List<User> users;
	=============================================================================
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, 49, 0),
							  new User("bb","bb","p2",Level.BASIC,50,0),
							  new User("cc","cc","p3",Level.SILVER,60,29),
							  new User("dd","dd","p4",Level.SILVER,60,30),
							  new User("ee","ee","p5",Level.GOLD,100,100)
							  );
	}
	=============================================================================
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	=============================================================================
	@Test
	public void upgradeLevels(){
		userDao.deleteAll();
		
		for(User user : users)userDao.add(user);
		
		userService.upgradeLevels();
		

		checkLevel(users.get(0), Level.BASIC);
		checkLevel(users.get(1), Level.SILVER);
		checkLevel(users.get(2), Level.SILVER);
		checkLevel(users.get(3), Level.GOLD);
		checkLevel(users.get(4), Level.GOLD);
		
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	=============================================================================
	
}

</font>
</pre>
</div>


<h2 style="color:#FCF9F9">6.UserService.add() - add a function of add and test in userService </h2>
<h3 style="color:#FCF9F9"># changed : UserService, UserServiceTest</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	
	
	public User(String id, String name, String password, Level level,
			int login, int recommend){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoJdbc]':'[UserDaoJdbc]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoJdbc</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend)value(?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ? where id = ?", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			return user;
		}
	};
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
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
	
	<bean id ="userService" class="toby.UserService">
		<property name="userDao" ref="userDao"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDaoJdbc">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>
</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0);
		this.user1 = new User("v","v","v",Level.SILVER,55,10);
		this.user2 = new User("z","z","z",Level.GOLD,100,40);
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		List<User> users0 =dao.getAll();
		assertThat(users0.size(), is(0));
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user3);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(1));
		checkSameUser(user1, users3.get(0));
		checkSameUser(user2, users3.get(2));
		
	}
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
	}
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[enum Level]':'[enum Level]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>enum Level</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public enum Level {
	
	BASIC(1), GOLD(3),SILVER(2);
	
	private final int value;
	
	Level(int value){
		this.value = value;
	}
	
	public int intValue(){
		return value;
	}
	
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao(I)]':'[UserDao(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserService]':'[UserService]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserService</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public class UserService {
	
	UserDao userDao;
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	public void upgradeLevels(){
		List<User> users = userDao.getAll();
		for(User user : users){
			Boolean changed = null;
			if(user.getLevel() == Level.BASIC && user.getLogin() >= 50){
				user.setLevel(Level.SILVER);
				changed = true;
			}else if(user.getLevel() == Level.SILVER && user.getRecommend() >= 30){
				user.setLevel(Level.GOLD);
				changed = true;
			}else if(user.getLevel() == Level.GOLD){
				changed = false;
			}else{
				changed = false;
			}
			if(changed){
				userDao.update(user);
			}
		}
	}
	=========================================================================
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
	=========================================================================
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserServiceTest]':'[UserServiceTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserServiceTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserDao userDao;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, 49, 0),
							  new User("bb","bb","p2",Level.BASIC,50,0),
							  new User("cc","cc","p3",Level.SILVER,60,29),
							  new User("dd","dd","p4",Level.SILVER,60,30),
							  new User("ee","ee","p5",Level.GOLD,100,100)
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels(){
		userDao.deleteAll();
		
		for(User user : users)userDao.add(user);
		
		userService.upgradeLevels();
		

		checkLevel(users.get(0), Level.BASIC);
		checkLevel(users.get(1), Level.SILVER);
		checkLevel(users.get(2), Level.SILVER);
		checkLevel(users.get(3), Level.GOLD);
		checkLevel(users.get(4), Level.GOLD);
		
	}
	========================================================================
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	========================================================================
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	
}


</font>
</pre>
</div>


<h2 style="color:#FCF9F9">7.UserService - Refatorying of upgradeLevels </h2>
<h3 style="color:#FCF9F9"># changed : UserService, User, Level</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	
	
	public User(String id, String name, String password, Level level,
			int login, int recommend){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	=======================================================================
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"은 업그레이드 불가능");
		}else{
			this.level = nextLevel;
		}
	}
	=======================================================================
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoJdbc]':'[UserDaoJdbc]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoJdbc</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend)value(?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ? where id = ?", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			return user;
		}
	};
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
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
	
	<bean id ="userService" class="toby.UserService">
		<property name="userDao" ref="userDao"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDaoJdbc">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>
</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0);
		this.user1 = new User("v","v","v",Level.SILVER,55,10);
		this.user2 = new User("z","z","z",Level.GOLD,100,40);
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		List<User> users0 =dao.getAll();
		assertThat(users0.size(), is(0));
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user3);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(1));
		checkSameUser(user1, users3.get(0));
		checkSameUser(user2, users3.get(2));
		
	}
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
	}
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[enum Level]':'[enum Level]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>enum Level</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public enum Level {
	======================================================
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	======================================================
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao(I)]':'[UserDao(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserService]':'[UserService]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserService</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public class UserService {
	
	UserDao userDao;
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	=========================================================
	public void upgradeLevels(){
		List<User> users = userDao.getAll();
		for(User user : users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}
	=========================================================
	private void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		
	}
	=========================================================
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= 50);
			case SILVER: return (user.getRecommend() >= 30);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	=========================================================
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}

}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserServiceTest]':'[UserServiceTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserServiceTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserDao userDao;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, 49, 0),
							  new User("bb","bb","p2",Level.BASIC,50,0),
							  new User("cc","cc","p3",Level.SILVER,60,29),
							  new User("dd","dd","p4",Level.SILVER,60,30),
							  new User("ee","ee","p5",Level.GOLD,100,100)
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels(){
		userDao.deleteAll();
		
		for(User user : users)userDao.add(user);
		
		userService.upgradeLevels();
		

		checkLevel(users.get(0), Level.BASIC);
		checkLevel(users.get(1), Level.SILVER);
		checkLevel(users.get(2), Level.SILVER);
		checkLevel(users.get(3), Level.GOLD);
		checkLevel(users.get(4), Level.GOLD);
		
	}
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">8.UserService - Test of User </h2>
<h3 style="color:#FCF9F9"># changed : UserServiceTest</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	
	
	public User(String id, String name, String password, Level level,
			int login, int recommend){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"은 업그레이드 불가능");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoJdbc]':'[UserDaoJdbc]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoJdbc</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend)value(?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ? where id = ?", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			return user;
		}
	};
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
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
	
	<bean id ="userService" class="toby.UserService">
		<property name="userDao" ref="userDao"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDaoJdbc">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>
</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0);
		this.user1 = new User("v","v","v",Level.SILVER,55,10);
		this.user2 = new User("z","z","z",Level.GOLD,100,40);
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		List<User> users0 =dao.getAll();
		assertThat(users0.size(), is(0));
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user3);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(1));
		checkSameUser(user1, users3.get(0));
		checkSameUser(user2, users3.get(2));
		
	}
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
	}
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[enum Level]':'[enum Level]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>enum Level</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao(I)]':'[UserDao(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserService]':'[UserService]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserService</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

public class UserService {
	
	UserDao userDao;
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	public void upgradeLevels(){
		List<User> users = userDao.getAll();
		for(User user : users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}
	private void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		
	}
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= 50);
			case SILVER: return (user.getRecommend() >= 30);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}

}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserServiceTest]':'[UserServiceTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserServiceTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, 49, 0),
							  new User("bb","bb","p2",Level.BASIC,50,0),
							  new User("cc","cc","p3",Level.SILVER,60,29),
							  new User("dd","dd","p4",Level.SILVER,60,30),
							  new User("ee","ee","p5",Level.GOLD,100,100)
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels(){
		userDao.deleteAll();
		
		for(User user : users)userDao.add(user);
		
		userService.upgradeLevels();
		

		checkLevel(users.get(0), Level.BASIC);
		checkLevel(users.get(1), Level.SILVER);
		checkLevel(users.get(2), Level.SILVER);
		checkLevel(users.get(3), Level.GOLD);
		checkLevel(users.get(4), Level.GOLD);
		
	}
	
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	===================================================================
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null) continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=IllegalStateException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	===================================================================
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	
}

</font>
</pre>
</div>

</body>
</html>

