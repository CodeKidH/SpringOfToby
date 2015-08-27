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
	private MailSender mailSender;
	
	public void setMailSender(MailSender mailSender){
		this.mailSender = mailSender;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels()throws Exception{
		
		TransactionStatus status =
				this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			List<User> users = userDao.getAll();
			for(User user: users){
				if(canUpgradeLevel(user)){
					upgradeLevel(user);
				}
			}
			this.transactionManager.commit(status);
		}catch (RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
	}
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		sendUpgradeEMail(user);
		
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
	
	private void sendUpgradeEMail(User user){
		
		
		SimpleMailMessage mailMessage = new SimpleMailMessage();
		mailMessage.setTo(user.getEmail());
		mailMessage.setFrom("soul2ndlife@naver.com");
		mailMessage.setSubject("upgrade");
		mailMessage.setText("u r level"+user.getLevel().name());
		
		this.mailSender.send(mailMessage);
		
	}
	
}
