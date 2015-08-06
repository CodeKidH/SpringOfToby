package toby;

import java.sql.SQLException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class UserDaoTest {
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		
		ApplicationContext context = new GenericXmlApplicationContext("toby/applicationContext.xml");
		UserDao dao = context.getBean("userDao",UserDao.class);
		
		User user = new User();
		user.setId("as2221");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
		
	}
}
