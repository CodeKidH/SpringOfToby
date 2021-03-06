package chapter2;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import org.junit.Test;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.RuntimeBeanReference;
import org.springframework.beans.factory.support.RootBeanDefinition;
import org.springframework.beans.factory.xml.XmlBeanDefinitionReader;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.context.support.StaticApplicationContext;
import org.springframework.util.ClassUtils;
import org.springframework.util.StringUtils;

//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = "/chapter2/applicationContext.xml")
public class Main {
	
	//@Autowired
	//ApplicationContext applicationContext;
	
	@Test
	public void registerBeanWithDependency(){
		
		StaticApplicationContext ac = new StaticApplicationContext();
		
		ac.registerBeanDefinition("printer", new RootBeanDefinition(StringPrinter.class));
		
		BeanDefinition helloDef = new RootBeanDefinition(Hello.class);
		helloDef.getPropertyValues().addPropertyValue("name","Spring");
		helloDef.getPropertyValues().addPropertyValue("printer",new RuntimeBeanReference("printer"));
		
		ac.registerBeanDefinition("hello",helloDef);
		
		Hello hello = ac.getBean("hello",Hello.class);
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	
	@Test
	public void bean1(){
		StaticApplicationContext ac = new StaticApplicationContext();
		//ioc 컨테이너 생성, 생성과 동시에 컨테이너로 동작
		ac.registerSingleton("hello2",Hello.class);
		//Hello 클래스를 hello2라는 이름의 싱글콘 컨테이너로 등록
		Hello hello2 = ac.getBean("hello2",Hello.class);
		//ioc 컨테이너가 등록한 빈을 생성했는지 확인하기 위해 빈을 요청
		assertThat(hello2,is(notNullValue()));
		
		
		//===============================================================
		
		BeanDefinition helloDef = new RootBeanDefinition(Hello.class);
		//빈 클래스 Hello 지정, 빈 메타정보를 담은 오브젝트를 만든다.
		helloDef.getPropertyValues().addPropertyValue("name","Spring");
		//빈의 name 프로터티에 들어갈 값지정
		ac.registerBeanDefinition("hello3", helloDef);
		//앞에 설정한 메타정보를 hello3이라는 이름을 가진 빈으로해서 등록
		Hello hello3 = ac.getBean("hello3",Hello.class);
		
		assertThat(hello3.sayHello(),is("HelloSpring"));
		assertThat(hello3,is(not(hello2)));
		assertThat(ac.getBeanFactory().getBeanDefinitionCount(), is(2));
		
	}
	
	@Test
	public void genericApplicationContext(){
		GenericApplicationContext ac = new GenericApplicationContext();
		XmlBeanDefinitionReader reader = new XmlBeanDefinitionReader(ac);
		reader.loadBeanDefinitions("chapter2/applicationContext.xml");
		//XmlBeanDefinitionReader는 기본적으로 클래스 패스로 정의된 리소스로부터 파일을 읽는다
		
		ac.refresh();
		//모든 메타정보가 등록이 완료됐으니 애플리케이션 컨테이너를 초기화하라는 명령이다.
		
		Hello hello = ac.getBean("hello",Hello.class);
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	
	@Test
	public void GenericXmlApplicationContext(){
		GenericApplicationContext ac =new GenericXmlApplicationContext(
				"chapter2/applicationContext.xml");
		
		Hello hello = ac.getBean("hello",Hello.class);
		
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	
	@Test
	public void treeOfContext(){
		String basePath = StringUtils.cleanPath(ClassUtils.classPackageAsResourcePath(getClass()))+"/";
		//현재 클래스의 패키지 정보를 클래스 패스형식으로 만들어서 미리저장
		
		ApplicationContext parent= new GenericXmlApplicationContext(basePath+"parentContext.xml");
		
		GenericApplicationContext child = new GenericApplicationContext(parent);
		
		XmlBeanDefinitionReader reader = new XmlBeanDefinitionReader(child);
		reader.loadBeanDefinitions(basePath + "childContext.xml");
		child.refresh(); // reader로 읽었으면 꼭 초기화 해야함
		
		Printer printer = child.getBean("printer",Printer.class); //childContext
		Printer printer1 = parent.getBean("printer",Printer.class);
		assertThat(printer, is(notNullValue()));
		//----------------------------------------------------------------------
		
		Hello hello = child.getBean("hello",Hello.class);
		assertThat(hello, is(notNullValue()));
		
		hello.print();
		assertThat(printer.toString(), is("Hellochild"));
		//-----------------------------------------------------------------------
		
		Hello hello1 = parent.getBean("hello",Hello.class);
		assertThat(hello1, is(notNullValue()));
		
		hello1.print();
		assertThat(printer1.toString(),is("HelloParent"));
		
		
		
	}
	
	public static void main(String[]args){
		
		
	}
	
	
}
