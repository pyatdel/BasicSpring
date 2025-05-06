package kr.or.ddit.websocket;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import lombok.extern.slf4j.Slf4j;

//쪽지를 조회할 RestController를 만들어준다. JSON 형식의 응답을 반환한다.
@Slf4j
@Controller
@RequestMapping("/admessage")
public class AdminMessageController {
	
	@Autowired
	private MessageService messageService;

	

	@GetMapping("/adsend/adform")
	public String getSendMessageForm() {
		return "adsendMessage"; // JSP 파일로 이동
	}

	// @AuthenticationPrincipal 사용 시 Authentication 객체의 getPrincipal() 메소드를 통해 반환되는
	// 객체를 받는다.
	@PostMapping("/adsendSync")
	public String sendMessageSync(MessageDto messageDto, @AuthenticationPrincipal UserDetails userDetails) {
		log.info("sendMessage->messageDto : " + messageDto);
		log.info("sendMessage->messageDto : " + userDetails);
		MessageDto sentMessage = messageService.SendMessage(messageDto, userDetails);
		return "adsendMessage";
	}

	// @AuthenticationPrincipal 사용 시 Authentication 객체의 getPrincipal() 메소드를 통해 반환되는
	// 객체를 받는다.
	@ResponseBody
	@PostMapping("/adsend")
	public String sendMessage(MessageDto messageDto, @AuthenticationPrincipal UserDetails userDetails, Model model) {
	    try {
	        messageService.SendMessage(messageDto, userDetails);
	        model.addAttribute("successMessage", "메시지가 성공적으로 전송되었습니다.");
	        return "redirect:/adaddress"; // 성공 페이지로 이동
	    } catch (Exception e) {
	        model.addAttribute("errorMessage", "메시지 전송 중 오류가 발생했습니다.");
	        return "error"; // 실패 페이지로 이동
	    }
    }

	@ResponseBody
	@PostMapping("/adlist")
	public ResponseEntity<MessageDto> listMessage(@RequestBody MessageDto messageDto,
			@AuthenticationPrincipal UserDetails userDetails) {
		log.info("receiveMessage->messageDto : " + messageDto);
		MessageDto receiveMessage = messageService.SendMessage(messageDto, userDetails);
		return ResponseEntity.status(HttpStatus.CREATED).body(receiveMessage);
	}

	@GetMapping("/adlist/adinbox")
	public String getInboxMessages(Model model, @AuthenticationPrincipal UserDetails userDetails) {
		try {
			// 현재 로그인한 사용자의 ID 가져오기
			String empId = userDetails.getUsername();

			// 받은 쪽지 목록 조회
			List<MessageDto> messages = messageService.ReadAllMessage(empId, userDetails);

			// 조회된 쪽지 데이터를 모델에 추가
			model.addAttribute("messages", messages);

			return "admessage_inbox"; // JSP 파일의 경로
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "쪽지 목록을 불러오는 중 오류가 발생했습니다.");
			return "error"; // 에러 페이지 경로
		}
	}
	
	 @PostMapping("/delete")
	    public String deleteMessage(@RequestParam("messageId") int messageId, Model model) {
	        try {
	            log.debug("Deleting message with ID: " + messageId);
	            boolean isDeleted = messageService.deleteMessage(messageId);
	            if (!isDeleted) {
	                model.addAttribute("error", "해당 메시지를 찾을 수 없습니다.");
	            }
	        } catch (Exception e) {
	            log.error("Error deleting message: ", e);
	            model.addAttribute("error", "삭제 중 문제가 발생했습니다.");
	        }
	        return "redirect:/admessage/adlist/adinbox";
	    }
	 
	 @GetMapping("/message/view")
	 public String viewMessage(@RequestParam("messageId") int messageId, Model model) {
	     try {
	         // 메시지 조회
	         MessageDto message = messageService.getMessageById(messageId);
	         model.addAttribute("message", message);
	         return "message_view"; // JSP 파일 경로
	     } catch (Exception e) {
	         e.printStackTrace();
	         model.addAttribute("error", "메시지를 불러오는 중 문제가 발생했습니다.");
	         return "error"; // 에러 페이지
	     }
	 }
	 
//	 @ResponseBody
//	 @GetMapping("/view")
//	 public ResponseEntity<?> viewMessage(@RequestParam("messageId") Long messageId) {
//	     if (messageId == null) {
//	         return ResponseEntity.badRequest().body("messageId가 비어 있습니다.");
//	     }
//
//	     try {
//	         MessageDto message = messageService.getMessageById(messageId);
//	         if (message == null) {
//	             return ResponseEntity.status(HttpStatus.NOT_FOUND).body("메시지를 찾을 수 없습니다.");
//	         }
//	         return ResponseEntity.ok(message);
//	     } catch (Exception e) {
//	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메시지를 불러오는 중 문제가 발생했습니다.");
//	     }
//	 }
	 @GetMapping("/view")
	 public ResponseEntity<MessageDto> viewMessage(@RequestParam("messageId") Long messageId) {
	     try {
	         MessageDto message = messageService.getMessageById(messageId);
	         if (message == null) {
	             return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	         }

	         // 읽음 상태 업데이트
	         messageService.updateReadStatus(messageId);

	         return ResponseEntity.ok(message);
	     } catch (Exception e) {
	         e.printStackTrace();
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	     }
	 }
	 
	 @PostMapping("/updateReadStatus")
	 @ResponseBody
	 public ResponseEntity<String> updateReadStatus(@RequestParam("messageId") Long messageId) {
	     try {
	         messageService.updateReadStatus(messageId); // 읽음 상태 변경
	         return ResponseEntity.ok("읽음 상태 업데이트 성공");
	     } catch (Exception e) {
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("읽음 상태 업데이트 실패");
	     }
	 }
}
