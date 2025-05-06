package kr.or.ddit.member.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.nio.file.Paths;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.upload.cotroller.UploadController;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/adminmain")
public class AdminProfile {

	@Autowired
	private MemberService memberService;
	@Autowired
	private UploadController uploadController;

	private static final String UPLOAD_DIRECTORY = "D:/resources/upload";

	private static final String DEFAULT_IMAGE_PATH = "path/to/default-profile.jpg";

	private static final URI UPLOAD_DIR = null;

	@GetMapping("/adminprofile") 
	public String adminProfilePage(Model model, MemberVO memberVO) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		MemberVO userInfo = new MemberVO();

		if (auth != null && auth.getPrincipal() instanceof UserDetails) {
			String empId = ((UserDetails) auth.getPrincipal()).getUsername();
			userInfo.setEmpId(empId);
		}

		userInfo = memberService.read(userInfo);
		log.info("Fetched MemberVO: {}", userInfo);

		if (userInfo != null) {
			model.addAttribute("userInfo", userInfo);
		} else {
			log.warn("User not found");
			model.addAttribute("error", "User not found");
		}

		return "adminprofile";
	}

	@PostMapping("/adminprofile/edit")
	public String adminEditProfile(@ModelAttribute MemberVO memberVO,
			@RequestParam(value = "profileImage", required = false) MultipartFile profileImage,
			@RequestParam("currentProfileImage") String currentProfileImage, RedirectAttributes redirectAttributes) {
		// 현재 로그인된 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && auth.getPrincipal() instanceof UserDetails) {
			String empId = ((UserDetails) auth.getPrincipal()).getUsername();
			memberVO.setEmpId(empId);
		}

		log.debug("수정 요청 정보: {}", memberVO);

		// 프로필 이미지 처리
		if (profileImage != null && !profileImage.isEmpty()) {
			try {
				// 파일 저장 경로 생성
				String fileExtension = getFileExtension(profileImage.getOriginalFilename());
				String newFileName = UUID.randomUUID().toString() + "_" + memberVO.getEmpId() + "." + fileExtension;
				String savePath = Paths.get(UPLOAD_DIRECTORY, newFileName).toString();

				// 파일 저장
				File saveDir = new File(UPLOAD_DIRECTORY);
				if (!saveDir.exists()) {
					saveDir.mkdirs();
				}
				profileImage.transferTo(new File(savePath));

				// 데이터베이스에 저장할 경로 설정
				memberVO.setEmpProfile("/resources/upload/" + newFileName);
				log.debug("새 프로필 이미지 저장 경로: {}", memberVO.getEmpProfile());
			} catch (IOException e) {
				log.error("프로필 이미지 저장 중 오류 발생", e);
				redirectAttributes.addFlashAttribute("error", "이미지 업로드 중 문제가 발생했습니다.");
				return "redirect:/adminmain/adminprofile";
			}
		} else {
			// 이미지 업로드가 없는 경우 기존 이미지 유지
			memberVO.setEmpProfile(currentProfileImage);
			log.debug("기존 프로필 이미지 유지: {}", currentProfileImage);
		}

		// 사용자 정보 업데이트
		try {
			int updatedRows = memberService.update(memberVO);
			if (updatedRows > 0) {
				redirectAttributes.addFlashAttribute("success", "정보가 성공적으로 업데이트되었습니다.");
				log.info("업데이트 성공: {}", memberVO);
			} else {
				redirectAttributes.addFlashAttribute("error", "업데이트에 실패했습니다.");
				log.warn("업데이트 실패: {}", memberVO);
			}
		} catch (Exception e) {
			log.error("사용자 정보 업데이트 중 오류 발생", e);
			redirectAttributes.addFlashAttribute("error", "업데이트 처리 중 문제가 발생했습니다.");
		}

		return "redirect:/adminmain/adminprofile";
	}

	// 파일 확장자 추출 메서드
	private String getFileExtension(String filename) {
		if (filename != null && filename.contains(".")) {
			return filename.substring(filename.lastIndexOf(".") + 1);
		}
		return "";
	}

	@GetMapping("/adminprofileImage")
	@ResponseBody
	public byte[] getAdminProfileImage(@RequestParam("empId") String empId) {
		String imagePath = memberService.getProfileImage(empId);
		if (imagePath == null || imagePath.isEmpty()) {
			try (InputStream in = new FileInputStream("D:/resources/default-profile.jpg")) {
				return in.readAllBytes();
			} catch (IOException e) {
				log.error("기본 이미지 로드 실패", e);
				return new byte[0];
			}
		}
		try (InputStream in = new FileInputStream("D:/resources" + imagePath)) {
			return in.readAllBytes();
		} catch (IOException e) {
			log.error("프로필 이미지 로드 실패", e);
			return new byte[0];
		}
	}
	
	
	
}
