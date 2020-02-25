# R 교육을 위한 예제 엑셀 파일을 github에서 불러오는 코드입니다.
#
# 아래 코드를 ctrl + a 로 전체 선택하고 ctrl + enter 로 실행하세요
# 샾은 주석으로 실행되지 않습니다. ctrl + shift + c
#
#
#RStudio 창 정리
rm(list = ls()) #메모리에 로드된 모든 객체 삭제
cat("\014") #모든 콘솔 내용 삭제
graphics.off() # 모든 차트 삭제

#사용할 라이브러리 불러오기, 패키지가 설치되어 있지 않은 경우, 자동 설치
if (!require("readxl")) install.packages("readxl"); library(readxl)
if (!require("ggplot2")) install.packages("ggplot2"); library(ggplot2)
if (!require("dplyr")) install.packages("dplyr"); library(dplyr)
if (!require("formattable")) install.packages("formattable"); library(formattable)

#github에 있는 예제용 학습파일 불러오기

#학습용 엑셀 url 주소
url <- "https://github.com/JinoJohn2012/R/raw/master/V1.data.xlsx"

#저장위치 및 확장자
k <- tempfile(fileext = ".xlsx"); k

#해당위치 파일을 저장위치에 다운로드
download.file(url, k, mode="wb")

#다운로드한 파일을 오픈하고 데이터프레임 형식 객체로 저장
df <- as.data.frame(read_excel(k, 1))

#임시 정보 - k, url 삭제
rm(k); rm(url)

#모든 콘솔 내용 삭제
file.edit('제4강 R 변수 조작 Temp.R')
cat("\014")
