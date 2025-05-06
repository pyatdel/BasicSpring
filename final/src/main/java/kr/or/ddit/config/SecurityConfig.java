package kr.or.ddit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import jakarta.servlet.DispatcherType;
import kr.or.ddit.service.impl.UserDetailServiceImpl;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

   @Autowired
   UserDetailServiceImpl userServiceImpl;
   
   

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http, PasswordEncoder passwordEncoder, UserDetailsService userDetailsService) throws Exception {

        // AuthenticationManager 설정
        AuthenticationManager authManager = http.getSharedObject(AuthenticationManagerBuilder.class)
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder)
                .and()
                .build();
        

        // SecurityFilterChain 설정
        return http
              .securityMatcher("/**") //적용할 URL패턴
                .csrf(csrf -> csrf.disable())
                .httpBasic(hbasic -> hbasic.disable())
                .headers(headers -> headers.frameOptions(frame -> frame.sameOrigin()))
                .authorizeHttpRequests(authz -> authz
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll() // FORWARD 요청 허용
                        .requestMatchers(HttpMethod.OPTIONS, "/**").permitAll() // OPTIONS 요청 허용
                        .requestMatchers(
                                "/login", "/signup", "/user", "/error", "/adminlte/**", "/js/**",
                                "/ckeditor/**", "/css/**", "/images/**", "/upload/**", "/resources/**",                             
                                "/error/**", "/email/**","/api/**","/schedule/**","att/**","attSchedule/**","/gantt/**" ,"/ws/alarm/**","/alarm/**","/cash/**", "/chat/**", "/ws-chat/**","/organizationChart/**", "/business/**","/memberSign/**","/alarmList/**").permitAll() // 요청 경로 허용
                        .requestMatchers("/admin/**","/adminmain/**","/personnel/**","/manageratt/**","/system/**").hasRole("ADMIN") // ADMIN 권한 필요
                        .requestMatchers("/user/**").hasAnyRole("ADMIN", "USER") // ADMIN 또는 USER 권한 필요
                        .anyRequest().authenticated() // 그 외 요청은 인증 필요
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .defaultSuccessUrl("/loginSuccess", true) // 로그인 성공 시 이동 경로
                        .failureUrl("/login?error=true")
                )
                
                .sessionManagement(session -> session                       
                        .maximumSessions(1) // 세션 최대 개수 설정
                        .maxSessionsPreventsLogin(false) // 추가 로그인을 허용할지 여부
                        .expiredUrl("/login?expired=true") // 세션 만료 시 이동할 경로
                )
                .rememberMe(remember -> remember
                       .key("uniqueAndSecret") // 고유 키 설정
                       .tokenValiditySeconds(1209600) // 2주 (14일) 동안 유지
                       .rememberMeParameter("remember-me") // 클라이언트 요청의 매개변수 이름
                   )
                .exceptionHandling(ex -> ex
                        .accessDeniedHandler(customAccessDeniedHandler()) // 커스텀 접근 거부 핸들러
                )
                .logout(logout -> logout
                        .logoutSuccessUrl("/login") // 로그아웃 성공 시 이동 경로
                        .invalidateHttpSession(true) // 세션 무효화
                )
                .authenticationManager(authManager) // AuthenticationManager 설정
                .build();
    }

    @Bean
    public AuthenticationManager authManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    public String getLoggedInUserId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            return ((UserDetails) principal).getUsername(); // 로그인된 사용자 아이디 반환
        } else {
            return principal.toString();
        }
    }

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http,
                                                       BCryptPasswordEncoder bCryptPasswordEncoder,
                                                       UserDetailsService userDetailService) throws Exception {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailService);
        authProvider.setPasswordEncoder(bCryptPasswordEncoder);
        return new ProviderManager(authProvider);
    }

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AccessDeniedHandler customAccessDeniedHandler() {
        return (request, response, accessDeniedException) -> {
            response.sendRedirect("/access-denied");
        };
    }
    
    
    public CorsConfigurationSource corsConfigurationSource() {
       CorsConfiguration configuration = new CorsConfiguration(); 
       configuration.addAllowedOrigin("http://localhost:7921"); // 허용할 Origin
       configuration.addAllowedMethod("*"); // 모든 메서드허용
       configuration.addAllowedHeader("*"); // 모든 헤더 허용
       configuration.setAllowCredentials(true); // 인증정보 포함 허용
       
       UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
       source.registerCorsConfiguration("/**", configuration);  // 모든 경로에 대해 설정 적용
       return source;
    }
    
    
    
    
    
}
