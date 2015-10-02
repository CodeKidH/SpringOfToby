package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.junit.Test;
import org.springframework.aop.ClassFilter;
import org.springframework.aop.Pointcut;
import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.aop.support.NameMatchMethodPointcut;

public class DynamicProxyTest {
	
	@Test
	public void simpleProxy(){
		Hello proxiedHello = (Hello)Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class[]{Hello.class},
				new UppercaseHandler(new HelloTarget()));
	}
	
	@Test
	public void proxyFactoryBean(){
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(new HelloTarget());
		pfBean.addAdvice(new UppercaseAdvice());
		
		Hello proxiedHello = (Hello)pfBean.getObject();
		assertThat(proxiedHello.sayHello("Toby"),is("HELLOTOBY"));
		assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
		
	}
	
	@Test
	public void pointcutAdvisor(){
		
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(new HelloTarget());
		
		NameMatchMethodPointcut pointcut = new NameMatchMethodPointcut();
		pointcut.setMappedName("sayH*");// 이름 비교조건설정, sayH로 시작하는 모든 메소드 선택
		
		pfBean.addAdvisor(new DefaultPointcutAdvisor(pointcut, new UppercaseAdvice()));
		//포인트컷과 어드바이스를 ADVISOR로 묶어서 한번에 추가
		Hello proxiedHello = (Hello)pfBean.getObject();
		
		assertThat(proxiedHello.sayHello("tOBY"),is("HELLOTOBY"));
		assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
		assertThat(proxiedHello.sayThankYou("Toby"),is("Thank YouToby"));
		//포인트컷이 적용안됨
		
		
	}
	
	@Test
	public void classNamePointcutAdvisor(){
		//포인트컷 준비 
		NameMatchMethodPointcut classMethodPointcut = new NameMatchMethodPointcut(){
			public ClassFilter getClassFilter(){
				return new ClassFilter(){
					public boolean matches(Class<?> clazz){
						return clazz.getSimpleName().startsWith("HelloT"); //클래스 이름 HelloT인것만 선정
					}
				};
			}
		};
		
		classMethodPointcut.setMappedName("sayH*");//sayH로 시작하는 메소드 이름을 가진메소드만 선정
		
		//테스트
		checkAdviced(new HelloTarget(), classMethodPointcut, true);//적용클래스다
		
		class HelloWorld extends HelloTarget{};
		checkAdviced(new HelloWorld(),classMethodPointcut, false); //적용클래스가 아니다
		
		class HelloToby extends HelloTarget{};
		checkAdviced(new HelloToby(), classMethodPointcut, true);//적용클래스다
	}
	
	private void checkAdviced(Object target, Pointcut pointcut, boolean adviced){//boolean은 적용대상인가를 체크
		
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(target);
		pfBean.addAdvisor(new DefaultPointcutAdvisor(pointcut, new UppercaseAdvice()));
		Hello proxiedHello = (Hello)pfBean.getObject();
		
		if(adviced){
			assertThat(proxiedHello.sayHello("Toby"),is("HELLOTOBY"));
			assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
			assertThat(proxiedHello.sayThankYou("Toby"),is("Thank YouToby"));
		}else{
			assertThat(proxiedHello.sayHello("Toby"),is("HelloToby"));
			assertThat(proxiedHello.sayHi("Toby"),is("HiToby"));
			assertThat(proxiedHello.sayThankYou("Toby"),is("Thank YouToby"));
		}
	}
	
	
	
	static class UppercaseAdvice implements MethodInterceptor{
		public Object invoke(MethodInvocation invacation)throws Throwable{
			String ret = (String)invacation.proceed();
			return ret.toUpperCase();
		}
	}
	
	static interface Hello{
		String sayHello(String name);
		String sayHi(String name);
		String sayThankYou(String name);
	}
	
	static class HelloTarget implements Hello{
		public String sayHello(String name){
			return "Hello" + name;
		}
		public String sayHi(String name){
			return "Hi" + name;
		}
		public String sayThankYou(String name){
			return "Thank You" + name;
		}
	}
	

    static class UppercaseHandler implements InvocationHandler{
		
		Object target;
		
		public UppercaseHandler(Object target){
			this.target = target;
		}
		
		public Object invoke(Object proxy, Method method, Object[] args)throws Throwable{
			Object ret = (String)method.invoke(target, args);
			if(ret instanceof String){
				return ((String)ret).toUpperCase();
			}else{
				return ret;
			}
		}
	}

	
}
