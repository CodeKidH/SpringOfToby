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
		//ioc �����̳� ����, ������ ���ÿ� �����̳ʷ� ����
		ac.registerSingleton("hello2",Hello.class);
		//Hello Ŭ������ hello2��� �̸��� �̱��� �����̳ʷ� ���
		Hello hello2 = ac.getBean("hello2",Hello.class);
		//ioc �����̳ʰ� ����� ���� �����ߴ��� Ȯ���ϱ� ���� ���� ��û
		assertThat(hello2,is(notNullValue()));
		
		
		//===============================================================
		
		BeanDefinition helloDef = new RootBeanDefinition(Hello.class);
		//�� Ŭ���� Hello ����, �� ��Ÿ������ ���� ������Ʈ�� �����.
		helloDef.getPropertyValues().addPropertyValue("name","Spring");
		//���� name ������Ƽ�� �� ������
		ac.registerBeanDefinition("hello3", helloDef);
		//�տ� ������ ��Ÿ������ hello3�̶�� �̸��� ���� �������ؼ� ���
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
		//XmlBeanDefinitionReader�� �⺻������ Ŭ���� �н��� ���ǵ� ���ҽ��κ��� ������ �д´�
		
		ac.refresh();
		//��� ��Ÿ������ ����� �Ϸ������ ���ø����̼� �����̳ʸ� �ʱ�ȭ�϶�� ����̴�.
		
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
		//���� Ŭ������ ��Ű�� ������ Ŭ���� �н��������� ���� �̸�����
		
		ApplicationContext parent= new GenericXmlApplicationContext(basePath+"parentContext.xml");
		
		GenericApplicationContext child = new GenericApplicationContext(parent);
		
		XmlBeanDefinitionReader reader = new XmlBeanDefinitionReader(child);
		reader.loadBeanDefinitions(basePath + "childContext.xml");
		child.refresh(); // reader�� �о����� �� �ʱ�ȭ �ؾ���
		
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
