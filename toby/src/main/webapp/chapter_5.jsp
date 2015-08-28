<%@include file="include.jsp"%>
<html>
<body style="background:#3E5968">
<h1 style="color:#FCF9F9">Chapter5 - AOP</h1>

<h2 style="color:#FCF9F9">1.separate Method - segregate business logic and transaction in service</h2>
<h3 style="color:#FCF9F9"># changed : UserService</h3>
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
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
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
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
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
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
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
			user.setEmail(rs.getString("email"));
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

(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	(bean id ="userService" class="toby.UserService")
		(property name="userDao" ref="userDao"/)
		(property name="transactionManager" ref="transactionManager"/)
	(/bean)
	
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	
(/beans)
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
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
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
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
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

import javax.sql.DataSource;

import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
public class UserService {
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	========================================================================
	public void upgradeLevels()throws Exception{
		
		TransactionStatus status =
				this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			upgradeLevelsInternal();
			this.transactionManager.commit(status);
		}catch (RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
	}
	
	private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}
	========================================================================
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
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
import static org.junit.Assert.fail;
import static toby.UserService.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserService.MIN_RECCOMEND_FOR_GOLD;

import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE)
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		userDao.deleteAll();
		
		for(User user : users)userDao.add(user);
		
		userService.upgradeLevels();
		
		
		checkLevelUpgraded(users.get(0), false);
		checkLevelUpgraded(users.get(1),  true);
		checkLevelUpgraded(users.get(2),  false);
		checkLevelUpgraded(users.get(3),  true);
		checkLevelUpgraded(users.get(4),  false);
		
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
	
	@Test
	public void upgradeAllofNothing() throws Exception{
		
		UserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			testUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		checkLevelUpgraded(users.get(1), false);
	}
	
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	static class TestUserService extends UserService {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
	
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">2.separate Method - seprate class from the UserService and change UserService </h2>
<h3 style="color:#FCF9F9"># changed : UserService, UserServiceTest, UserServiceImpl, UserServiceTx,applicataionContext.xml</h3>
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
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
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
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
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
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
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
			user.setEmail(rs.getString("email"));
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
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	======================================================================
	(bean id ="userService" class="toby.UserServiceTx")
		(property name="transactionManager" ref="transactionManager"/)
		(property name="userService" ref="userServiceImpl"/)
	(/bean)
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	======================================================================
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)

(/beans)
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
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
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
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
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

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserService(I)]':'[UserService(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserService(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
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
import static org.junit.Assert.fail;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	==========================================================================
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	==========================================================================
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		userDao.deleteAll();
		
		for(User user : users)userDao.add(user);
		
		userService.upgradeLevels();
		

		checkLevelUpgraded(users.get(0), false);
		checkLevelUpgraded(users.get(1),  true);
		checkLevelUpgraded(users.get(2),  false);
		checkLevelUpgraded(users.get(3),  true);
		checkLevelUpgraded(users.get(4),  false);
		
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
	==========================================================================
	@Test
	public void upgradeAllofNothing() throws Exception{
		
		TestUserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
			
		UserServiceTx txUserService = new UserServiceTx();
		txUserService.setTransactionManager(transactionManager);
		txUserService.setUserService(testUserService);
		
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			txUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		checkLevelUpgraded(users.get(1), false);
	}
	==========================================================================
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	==========================================================================
	static class TestUserService extends UserServiceImpl {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
	==========================================================================
	
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserServiceImpl]':'[UserServiceImpl]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserServiceImpl</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
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

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserServiceTx]':'[UserServiceTx]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserServiceTx</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">3.separate Method - Unit test </h2>
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
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
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
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
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
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
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
			user.setEmail(rs.getString("email"));
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
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	(bean id ="userService" class="toby.UserServiceTx")
		(property name="transactionManager" ref="transactionManager"/)
		(property name="userService" ref="userServiceImpl"/)
	(/bean)
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)

(/beans)
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
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
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
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
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

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserService(I)]':'[UserService(I)]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserService(I)</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
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
import static org.junit.Assert.fail;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	====================================================================
	@Test
	public void upgradeLevels() throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		MockUserDao mockUserDao = new MockUserDao(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		
		userServiceImpl.upgradeLevels();
		
		List<User> updated = mockUserDao.getUpdated();
		assertThat(updated.size(),is(2));
		checkUserAndLevel(updated.get(0),"bb",Level.SILVER);
		checkUserAndLevel(updated.get(1),"dd",Level.GOLD);
		
		
	}
	
	private void checkUserAndLevel(User updated, String expectedId, Level expectedLevel){
		assertThat(updated.getId(), is(expectedId));
		assertThat(updated.getLevel(), is(expectedLevel));
	}
	====================================================================
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
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null)continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=NullPointerException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	
	@Test
	public void upgradeAllofNothing() throws Exception{
		
		TestUserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
			
		UserServiceTx txUserService = new UserServiceTx();
		txUserService.setTransactionManager(transactionManager);
		txUserService.setUserService(testUserService);
		
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			txUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		checkLevelUpgraded(users.get(1), false);
	}
	
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	==========================================================
	static class MockUserDao implements UserDao{
		
		private List<User> users;
		private List<User> updated = new ArrayList();
		
		private MockUserDao(List<User> users){
			this.users = users;
		}
		
		public List<User> getUpdated(){
			return this.updated;
		}
		
		public List<User> getAll(){
			return this.users;
		}
		
		public void update(User user){
			updated.add(user);
		}
		
		public void add(User user){ throw new UnsupportedOperationException();}
		public void deleteAll(){ throw new UnsupportedOperationException();}
		public User get(String id){ throw new UnsupportedOperationException();}
		public int getCount(){ throw new UnsupportedOperationException();}
		
		
	}
	==========================================================
	static class TestUserService extends UserServiceImpl {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
	
	
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserServiceImpl]':'[UserServiceImpl]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserServiceImpl</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
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

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserServiceTx]':'[UserServiceTx]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserServiceTx</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</font>
</pre>
</div>

</body>
</html>

