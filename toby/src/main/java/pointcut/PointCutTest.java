package pointcut;

import org.junit.Test;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;

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

public class PointCutTest {
	
	public static void main(String[]args) throws NoSuchMethodException, SecurityException{
		System.out.println(Target.class.getMethod("minus", int.class, int.class));
	}
	
	
	@Test
	public void methodSignaturePointcut()throws SecurityException, NoSuchMethodException{
		AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();
		pointcut.setExpression("execution(public int" +" pointcut.Target.minus(int,int)"+"throws java.lang.RuntimeException)");
		//Target클래스 minus()메소드 시그니처
		
		
		//Target.minus()
		assertThat(pointcut.getClassFilter().matches(Target.class)&&//클래스필터와 메소드 매처를 가져와 각각비교한다.
				pointcut.getMethodMatcher().matches(
						Target.class.getMethod("minus", int.class, int.class),null),is(true));//포인트컷 통과
		
		//Target.plus()
		assertThat(pointcut.getClassFilter().matches(Target.class)&&
				pointcut.getMethodMatcher().matches(
						Target.class.getMethod("plus", int.class, int.class), null),is(false)); //매소드 매처 실패
		
		//Bean.method()
		assertThat(pointcut.getClassFilter().matches(Target.class)&&
				pointcut.getMethodMatcher().matches(
						Target.class.getMethod("method"), null),is(false)); //클래스 필터에서 실패
	}
}
