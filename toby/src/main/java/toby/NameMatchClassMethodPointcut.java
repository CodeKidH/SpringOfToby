package toby;

import org.springframework.aop.ClassFilter;
import org.springframework.aop.support.NameMatchMethodPointcut;
import org.springframework.util.PatternMatchUtils;

public class NameMatchClassMethodPointcut extends NameMatchMethodPointcut{
	
	public void setMappedClassName(String mappedClassName){
		this.setClassFilter(new SimpleClassFilter(mappedClassName)); //모든 클래스를 다 허용하던 디폴트 클래스 필터를 프로터티 받은 클래스이름을 이용해서 필터를 만들어 덮어씌운다
	}
	
	static class SimpleClassFilter implements ClassFilter{
		
		String mappedName;
		
		private SimpleClassFilter(String mappedName){
			this.mappedName = mappedName;
		}
		
		public boolean matches(Class<?> clazz){
			return PatternMatchUtils.simpleMatch(mappedName, clazz.getSimpleName());//와일드카드(*)가 들어간 문자열 비교를 지원하는 유틸 메소드
		}
	}
	
}
