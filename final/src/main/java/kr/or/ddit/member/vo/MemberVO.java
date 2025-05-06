package kr.or.ddit.member.vo;

import java.util.List;

import kr.or.ddit.personnel.vo.DepartmentVO;
import kr.or.ddit.personnel.vo.PositionVO;
import lombok.Data;

@Data
public class MemberVO{
	private int empNo;
	private boolean enabled; // ENABLED에 매핑
	private String empId; // EMP_ID에 매핑
	private String empPw; // EMP_PW에 매핑
	private String empName;
	private String empEmail;
	private String empPhone;
	private String empZip; //우편번호
	private String empStreet; //도로명 주소
	private String empDetail; // 상세 주소
	private String empSign;
	private int empAnnual;
	private String empIn;
	private String empOut;
	private int deptNo;
	private int postNo; // POST_N
	private String empProfile;
	private String defaultType;
	
	private String postName;
	private String deptName;
	
	//EMPLOYEE : POSITION = 1 : 1
	private List<PositionVO> authorities;
	
	public int getEmpNo() {
		return empNo;
	}

	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpPw() {
		return empPw;
	}

	public void setEmpPw(String empPw) {
		this.empPw = empPw;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmpEmail() {
		return empEmail;
	}

	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}

	public String getEmpPhone() {
		return empPhone;
	}

	public void setEmpPhone(String empPhone) {
		this.empPhone = empPhone;
	}

	public String getEmpZip() {
		return empZip;
	}

	public void setEmpZip(String empZip) {
		this.empZip = empZip;
	}

	public String getEmpStreet() {
		return empStreet;
	}

	public void setEmpStreet(String empStreet) {
		this.empStreet = empStreet;
	}

	public String getEmpDetail() {
		return empDetail;
	}

	public void setEmpDetail(String empDetail) {
		this.empDetail = empDetail;
	}

	public String getEmpSign() {
		return empSign;
	}

	public void setEmpSign(String empSign) {
		this.empSign = empSign;
	}

	public int getEmpAnnual() {
		return empAnnual;
	}

	public void setEmpAnnual(int empAnnual) {
		this.empAnnual = empAnnual;
	}

	public String getEmpIn() {
		return empIn;
	}

	public void setEmpIn(String empIn) {
		this.empIn = empIn;
	}

	public String getEmpOut() {
		return empOut;
	}

	public void setEmpOut(String empOut) {
		this.empOut = empOut;
	}

	public int getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getEmpProfile() {
		return empProfile;
	}

	public void setEmpProfile(String empProfile) {
		this.empProfile = empProfile;
	}

	public String getDefaultType() {
		return defaultType;
	}

	public void setDefaultType(String defaultType) {
		this.defaultType = defaultType;
	}

	public List<PositionVO> getAuthorities() {
		return authorities;
	}

	public void setAuthorities(List<PositionVO> authorities) {
		this.authorities = authorities;
	}

	@Override
	public String toString() {
		return "MemberVO [empNo=" + empNo + ", enabled=" + enabled + ", empId=" + empId + ", empPw=" + empPw
				+ ", empName=" + empName + ", empEmail=" + empEmail + ", empPhone=" + empPhone + ", empZip=" + empZip
				+ ", empStreet=" + empStreet + ", empDetail=" + empDetail + ", empSign=" + empSign + ", empAnnual="
				+ empAnnual + ", empIn=" + empIn + ", empOut=" + empOut + ", deptNo=" + deptNo + ", postNo=" + postNo
				+ ", empProfile=" + empProfile + ", defaultType=" + defaultType + ", authorities=" + authorities + "]";
	}


//	private Collection<? extends GrantedAuthority> authorities; // 권한 목록

	

//	@Override
//	public String toString() {
//		return "MemberVO [empName=" + empName + ", empProfile=" + empProfile + "]";
//	}

	// UserDetails 인터페이스 메서드 구현
//	@Override
//	public Collection<? extends GrantedAuthority> getAuthorities() {
		// 필드에 저장된 authorities를 반환
//		return authorities;
//	}
	

//	@Override
//	public String getPassword() {
//		return empPw;
//	}
//
//	@Override
//	public String getUsername() {
//		return empId;
//	}

//	@Override
//	public boolean isAccountNonExpired() {
//		return true;
//	}

//	@Override
//	public boolean isAccountNonLocked() {
//		return true;
//	}

//	@Override
//	public boolean isCredentialsNonExpired() {
//		return true;
//	}

//	@Override
//	public boolean isEnabled() {
//		return enabled;
//	}

//	public String getEmpProfile() {
//		return empProfile;
//	}

//	public void setEmpProfile(String empProfile) {
//		this.empProfile = empProfile;
//	}
//	private String memId;
//	private String memName;
//	private String memPw;
//	private boolean memEnable;
//	private String memRegdate;
//	private Long fileGroupNo;// 파일 그룹 번호
//	private String fileSaveLocate; // 파일 웹 경로
//
//	private String memPass;
//	private String memRegno1;
//	private String memRegno2;
//	// 2024-11-27(문자타입)->pattern->날짜타입
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
//	private Date memBir;
//	private String memBirStr;
//	private String memZip;
//	private String memAdd1;
//	private String memAdd2;
//	private String memHometel;
//	private String memComtel;
//	private String memHp;
//	private String memMail;
//	private String memJob;
//	private String memLike;
//	private String memMemorial;
//	private Date memMemorialday;
//	private int memMileage;
//	private String memDelete;

//	request{memId=t001, memPass=0506, memName=성원태2,
// 			memZip=306-702, 
//			memAdd1=대전광역시 중구 유천동, memAdd2=한사랑아파트 302동 504호,
//			memBir=2024-11-27,uploadFiles=파일객체}

//	private int rnum;// 행번호
//
//	// MEMBER : FILE_GROUP = 1 : 1
//	private FileGroupVO fileGroupVO;
//
//	// 이미지 파일들
//	private MultipartFile[] uploadFiles;
//
//	private List<AuthVO> authList;
}
