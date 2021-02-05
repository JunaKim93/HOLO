package holo.holouser.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


public class AopAdvice {

	public Object sessionCheck(ProceedingJoinPoint jp) throws Throwable{

		RequestAttributes ra = RequestContextHolder.currentRequestAttributes();
		ServletRequestAttributes sra = (ServletRequestAttributes)ra;
		
		HttpServletRequest request = sra.getRequest();
		HttpSession session = request.getSession();
		
		
		Object view = "member/error";
		String sessionId = (String)session.getAttribute("sessionId");
		if(sessionId != null) {
			view = jp.proceed();
		}
		return view;
	}
	
	
	
	
}
