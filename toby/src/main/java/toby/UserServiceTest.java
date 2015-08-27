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


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
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
