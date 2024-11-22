package com.sumin.just.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sumin.just.service.IdolService;
import com.sumin.just.vo.IdolVO;
import com.sumin.just.vo.Singer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController  //이걸 붙이면, ResponseBody를 붙인 것과 같다
@RequestMapping("/api")
public class IdolController {
   
   @Autowired
   private IdolService idolService;
   
   @Value("Angel")  // 
   private String myName;
   
   // 근데 정리는 처음부터 안해도 된다!
   @Value("${upload.savedir}")
   private String saveDir;
   
   @Value("${upload.webpath}")
   private String webBase;
   
   @GetMapping("/idols")  // return하는 데이터를 그대로 요청한 곳에 줌, ajax요청에 대응한다
   public List<IdolVO> getIdols(){
       // return 에 자동으로 jackson 라이브러리 동작 자바객체 => json문자열
       return idolService.getIdols();
   }
   
   @GetMapping("/idols/{idolId}")
   public IdolVO getIdol(@PathVariable int idolId) {
       IdolVO idol = new IdolVO();
       idol.setIdolId(idolId);
       return idolService.getIdol(idol);
   }

   @PostMapping("/idols2")  // 파일이 첨부되어 넘어올 때
   public int insIdol2(IdolVO idol) throws Exception {  // 골뱅이RequestBody를 붙이지 않는다.
       log.debug("체킁 9 {}", idol);
       // log.debug("원래이름 {}", idol.getIdolFile().getOriginalFilename());
       // log.debug("원래이름 {}", idol.getIdolFile().getSize());
       log.debug("원래이름 {}", idol.getIdolFiles());
       
       List<MultipartFile> mgFiles = idol.getIdolFiles();
       
       //파일 저장 무지 쉬움, 디렉토리에 저장
       // String saveDir = "C:/e7e/boot/jcupload/"; // 안에 저장할 거니까, 마지막에 /를 추가
       String savePath = "";
       for (MultipartFile mgFile : mgFiles) {
           savePath = saveDir + mgFile.getOriginalFilename();
           mgFile.transferTo(new File(savePath));
       }
       
       // DB에는 idolSajin 속성에 웹 경로를 저장할 것
       // DB가 수정되어야 하는데, 그냥 대표 파일 1개 경로만 DB에 저장하는 걸로..
       
       String webPath = webBase + mgFiles.get(0).getOriginalFilename();
       idol.setIdolSajin(webPath);
       
       int cnt = idolService.insIdol(idol);
       
       return idol.getIdolId();
   }

   @PostMapping("/idols")
   public int insIdol(@RequestBody IdolVO idol) {
       log.debug("체킁 {}", idol);
       return idolService.insIdol(idol);
   }

   @PostMapping("/shcomplex")  // 폼데이터가 넘어올 때
   public int shcomplex(IdolVO idol,
           @RequestPart("yjPlus") List<Map<String, String>> shData,
           @RequestPart("gjPlus") List<Singer> gjData) {
       log.debug("체킁 {}", idol);
       log.debug("체킁 2 {}", shData);
       log.debug("체킁 3 {}", gjData);
       return 337;
   }

   @PutMapping("/idols")
   public int updIdol(@RequestBody IdolVO idol) {
       return idolService.updIdol(idol);
   }

   @PutMapping("/idols2")
   public int updIdol2(IdolVO idol) throws Exception {  // 파일 업로드 처리 시에는 @RequestBody를 사용하지 말아야 함
       log.debug("put idol {}", idol);  // 이렇게 찍어보는 습관이 엄청 중요하다
       
       MultipartFile jyFile = null;
       String savePath = "";
       String webPath = "";
       if(idol.getIdolFiles() != null) {
           jyFile = idol.getIdolFiles().get(0);
           savePath = saveDir + jyFile.getOriginalFilename();
           jyFile.transferTo(new File(savePath));
           webPath = webBase + jyFile.getOriginalFilename();
           idol.setIdolSajin(webPath);
       } else {
           // 원래 파일 유지하도록... 숙제
           // 힌트 sql if문
           // mybatis if문..? 동적 sql
           idol.setIdolSajin(null);  // 여긴 일단 디폴트값
       }
       
       return idolService.updIdol(idol);
   }

   @DeleteMapping("/idols/{idolId}")
   public int delIdol(@PathVariable int idolId) {
       IdolVO idol = new IdolVO();
       idol.setIdolId(idolId);
       return idolService.delIdol(idol);
   }
   
   @DeleteMapping("/idols/multi")
   public Map<String, Object> delIdols(@RequestBody List<Integer> idolIds) {
       log.debug("값 확인 {}", idolIds);
       
       IdolVO idol = new IdolVO();
       int sum = 0;
       for (Integer idolId : idolIds) {
           idol.setIdolId(idolId);
           sum += idolService.delIdol(idol);
       }
       
       Map<String, Object> result = new HashMap<>();
       result.put("msg", "success");
       result.put("sum", sum);  //  result.put("sum", sum) 는 문자열이라 에러난다
       
       return result;
   }
}
