package kr.or.ddit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import jakarta.servlet.DispatcherType;
import kr.or.ddit.service.impl.UserDetailsServiceImpl;

//스프링한테 자바빈 등록해달라고 함
@Configuration
@EnableWebSecurity
public class WebSecurityConfig {
	
	@Autowired
	UserDetailsServiceImpl userDetailsServiceImpl;
	
	//1. 스프링 시큐리티 기능 비활성화(클라이언트 -> 요청 -> 시큐리티 필터 모두 통과 -> 서버)
	   /*
	    스프링 시큐리티의 모든 기능을 사용하지 않게 설정하는 코드. 즉, 인증, 인가 서비스를 모든 곳에 적용하지는 않음
	    일반적으로 정적 리소스(이미지, HTML 파일)에 설정함. 정적 리소스만 스프링 시큐리티 사용을 비활성화 하는 데
	    static 하위 경로에 있는 리소스를 대상으로 ignoring() 메서드를 사용함
	    */
	public WebSecurityCustomizer configure() {
		return (web)->web.ignoring()
						 .requestMatchers(new AntPathRequestMatcher("/static/**"));
	}
	
	//2. 특정 HTTP 요청에 대한 웹 기반 보안 구성
	   /*
	    이 메서드에서 인증/인가 및 로그인, 로그아웃 관련 설정을 할 수 있음
	    */
	@Bean
	   protected SecurityFilterChain filterChain (HttpSecurity http)throws Exception {
	      return http.csrf(csrf -> csrf.disable()).httpBasic(hbasic -> hbasic.disable())
	            .headers(config -> config.frameOptions(customizer -> customizer.sameOrigin()))
	            .authorizeHttpRequests(
	                  authz -> authz.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll() // forward                                                                                          // 허가
	                        .requestMatchers("/login","/signup","/user", "/error", "/adminlte/**","/js/**").permitAll()
	                        .requestMatchers("/ceo/**").hasRole("CEO")
	                        .requestMatchers("/manager/**").hasAnyRole("CEO","MANAGER")
	                        .anyRequest().authenticated())
	            .formLogin(formLogin->formLogin
	                  .loginPage("/login")
	                  .defaultSuccessUrl("/articles/list"))
	            .sessionManagement(session -> session.maximumSessions(1))
	            .logout(logout->logout
	                  .logoutSuccessUrl("/login")
	                  .invalidateHttpSession(true))
	            .build();
	   }
		//3. 인증, 인가 설정
	      /*
	       특정 경로에 대한 액세스 설정을 함
	       - requestMatchers() : 특정 요청과 일치하는 url에 대한 액세스를 설정함
	       - permitall() : 누구나 접근이 가능하게 설정함. 즉, "/login", "/signup", "/user"로 요청이 오면
	                      인증/인가 없이도 접근할 수 있음
	       - anyRequest() : 위에서 설정한 url 이외의 요청에 대해서 설정함
	       - authenticated() : 별도의 인가(권한)는 필요하지 않지만 인증(로그인)이 성공된 상태여야 접근할 수 있음
	       */
	      //   4. 폼 기반 로그인 설정
	      /*
	       - loginPage() : 로그인 페이지(login.jsp) 경로를 설정함
	       - defaultSuccessUrl() : 로그인이 완료되었을 때 이동할 경로를 설정함
	       */
	      //      5. 로그아웃 설정
	      /*
	       - logoutSuccessUrl() : 로그아웃이 완료되었을 때 이동할 경로를 설정함
	       - invalidateHttpSession() : 로그아웃 이후에 세션을 전체 삭제할지 여부를 설정함
	       */
	      //         6. csrf 비활성화
	      /*
	       CrossSite Request Forgery 공격을 방지하기 위해서는 활성화하는 게 좋지만 실습을 편리하게 하기 위해 비활성화해두자
	       */

	//7. 인증(Authentication, 로그인) 관리자 관련 설정
	   /*
	    사용자 정보를 가져올 서비스를 재정의하거나, 인증 방법, 예를들어 LDAP, JDBC 기반 인증 등을 설정할 때 사용함
	    */
	@Bean
	public AuthenticationManager authenticationManager(
			HttpSecurity http, BCryptPasswordEncoder bCryptPasswordEncoder,
			UserDetailsService userDetailsService) {
		//DB를 통한 인증 제공자
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
		//******** 인증 대상 검색 *********
		authProvider.setUserDetailsService(this.userDetailsServiceImpl);
		authProvider.setPasswordEncoder(bCryptPasswordEncoder);
		
		return new ProviderManager(authProvider);
	}
	//8. 사용자 정보 서비스 설정
	      /*
	       userDetailsService() : 사용자 정보를 가져올 서비스를 설정함.
	                          이때 설정하는 서비스클래스는 반드시 UserDetailsService를 상속받은 
	                          (UserDetailsServiceImpl implements UserDetailsService)
	                          클래스여야 함.
	       passwordEncoder() : 비밀번호를 암호화하기 위한 인코더를 설정
	       */


	//9. 패스워드 인코더로 사용할 빈 등록
	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
}




