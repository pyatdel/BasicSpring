package kr.or.ddit.cash.controller;

import com.itextpdf.kernel.pdf.*;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.*;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.ByteArrayOutputStream;

@RestController
@RequestMapping("/cash")
public class PdfController {

    @GetMapping("/download")
    public ResponseEntity<byte[]> downloadPdf() {
        try {
            // PDF 문서를 메모리에 저장할 ByteArrayOutputStream 생성
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PdfWriter writer = new PdfWriter(baos);
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            // 제목 추가
            document.add(new Paragraph("지출 신청 내역").setBold().setFontSize(18));

            // 테이블 생성 (4열)
            Table table = new Table(4);
            table.addCell(new Cell().add(new Paragraph("번호").setBold()));
            table.addCell(new Cell().add(new Paragraph("항목").setBold()));
            table.addCell(new Cell().add(new Paragraph("금액").setBold()));
            table.addCell(new Cell().add(new Paragraph("날짜").setBold()));

            // 샘플 데이터 추가
            table.addCell("1");
            table.addCell("사무용품");
            table.addCell("50,000원");
            table.addCell("2025-01-20");

            table.addCell("2");
            table.addCell("회의비");
            table.addCell("100,000원");
            table.addCell("2025-01-18");

            document.add(table);
            document.close();

            // PDF를 바이트 배열로 변환
            byte[] pdfBytes = baos.toByteArray();

            // HTTP 응답 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Disposition", "attachment; filename=expense_report.pdf");
            headers.add("Content-Type", "application/pdf");

            return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
    
}
