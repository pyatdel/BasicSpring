package com.example.justice.sample;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SuminVO {
   private String sender;
   private String receiver;
   private String kind;
   private String msg;
}
