package kr.or.ddit.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.club.vo.ClubMemberVO;
import kr.or.ddit.member.vo.MemberVO;
import lombok.Getter;

//CustomUser       = jsp의 principal
//CustomUser.member = jsp의 principal.member
public class CustomUser extends User{

   private static final long serialVersionUID = 1L;
   private MemberVO member;

   public CustomUser (String username, String password, Collection<? extends GrantedAuthority> authorities){
      super(username, password, authorities);
   }
   
   
   public CustomUser (MemberVO memberVO){
      super(memberVO.getEmpId(),memberVO.getEmpPw(),
           memberVO.getAuthorities().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
      this.member = memberVO;
   }


	public MemberVO getMember() {
		return member;
	}
	
	
	public void setMember(MemberVO member) {
		this.member = member;
	}
	
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public Object getDeptNo() {
		// TODO Auto-generated method stub
		return null;
	}





	   
	   
}