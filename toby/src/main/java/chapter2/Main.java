package chapter2;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import org.junit.Test;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.RuntimeBeanReference;
import org.springframework.beans.factory.support.RootBeanDefinition;
import org.springframework.context.support.StaticApplicationContext;

public class Main {
	
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
	
	
	
	public static void main(String[]args){
		
		
	}
	
	
}
