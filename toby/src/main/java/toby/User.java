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
