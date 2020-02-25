# 2월 26일 # 제4강 교재 4장과 5장을 합쳐서 진행
# 5장 2절의 dplyr함수가 가장 중요. 교재를 많이 읽고 이해하고 외우고 할 예정입니다. 
# 교재 99쪽 ~ 108쪽


# 절대 한줄씩 진행하지 말것!
# 전체적으로 설명하는 것이 낫다


#객체를 모두 지우기
rm(list = ls()) # 오른쪽 환경창의 객체들 지우기 작업
cat("\014") #콘솔(결과창) 지우기 작업
graphics.off()

#사용할 라이브러리
library(readxl) 
library(googledrive) 
library(quantmod)
library(ggplot2)

#install.packages("dplyr") #설치가 안된 경우 맨 왼쪽 # 지우고 ctrl + enter로 실행하여 설치
library(dplyr)


#매트릭스 객체 만들기
mt <- matrix(1:6, 3) # 뒤의 숫자가 가령 3이면 앞(1:6)의 원소로 3행짜리 행렬을 만들라는 의미
mt # 3 바이 2의 행렬이 만들어 짐

mt * 2
mt %*% t(mt) #행렬의 곱; 3 by 2 X 2 by 3 (2 x 2 처럼 같은 수만 곱셈 가능, 3 x 3 갯수만큼 자료 생김)

mt
apply(mt, 1, sum) #mt 객체, 1 =행별로, 합계(sum)을, 모두 구하시오 = apply)
############################
#제4장

#array 배열 만들기
ar <- array(1:60, c(3,4,5)) # 3 바이 4의 행렬 5개 만들어지는 배열 객체 (교재비교)
ar #행렬과 배열 객체는 다른 것

#배열의 인덱싱
ar[, , 5] # 3 by 4의 행렬이 5개 있는 배열이기 때문에 이런 식으로 인덱스
ar[1, , ]
ar[, 1, ]


class(ar)

# 교육용 엑셀 파일 불러오기

getwd() #현재 워킹 디렉토리
setwd("C:/Users/jinoj/OneDrive/My R/My R Book Project") #각자 설정 필요
list.files()

#주의: Excel file이 열려 있으면 열리지 않아요~

file <- "V1.R 교육용 Client 샘플데이터.xlsx"
#file <- file.choose() 
df<-as.data.frame(read_excel(file)) #불러옴과 동시에 df로 만듦

#p.99, dplyr package
#p.103쪽 ifelse
#mean split 개념

# dplyr 의 6가지 주요 기능
# 
# filter() 케이스 선택
# select() 변수 선택
# arrange() 소트
# group_by() 집단 변수로 구분
# mutate() 새로운 변수 생성
# summarise() 통계량 생성
# 




#
## subset이 필요한 상황
#매출이 가장 높은 케이스
#매출이 가장 높은 케이스별로 10개 데이터

head(df) #데이터 첫머리 몇개 케이스를 보여줌, 반대는 tail()
table(df$`멤버십 등급`) #frequency

myc <- c(4,5,7,8); myc #char 형식의 변인 위치
myn <- c(1,2,3,6,9); myn #char 형식의 변인 위치


for (i in myc){
  r <- table(df[, i])
  print(r)
}



#
# dplyr - 1 ; filter() = case의 선택 (행의 선택)

filter(df, df$`멤버십 등급`=="골드")

df_gold <- df %>% filter(df$`멤버십 등급` == "골드"); df_gold
df_ngold <- df %>% filter(df$`멤버십 등급` != "골드")
df_ngold <- df %>% filter(df$`멤버십 등급` != "골드" & df$성별=="M")

df %>% 
  filter(df$`멤버십 등급` != "골드" & df$성별=="F") 

df %>% 
  filter(df$`멤버십 등급` == "골드" | df$성별 == "F") 


#참고 매치함수
table(df$국적)
#table(df$국적 %in% "TAIWAN")

#"우리의 소원은 통일" %in% "우리의 소원은 통일"

grep("통일", "우리의 소원은 통일, 통일") # Row 1에 있다?
grep("F", df$성별)
grep("골드", df$`멤버십 등급`)


df_grep_g <- df[c(2,19,36,61,77), ]
df_grep_g

df.g1 <- df[which(df$`멤버십 등급` ==  "골드"), ]
df.g2 <- filter(df, df$`멤버십 등급` ==  "골드")

mean(df[, 2])


# dplyr - 2 ; select() = variable의 선택 (열의 선택)

df_core <- df %>% select(id, 매출)
df_minus <- df %>% select(-회원가입일) # $를 타입하면 변수명 목록이 제시됨



#교재 p107의 상관관계 분석을 dplyr 방식으로 표현하면 다음과 같아요~
df %>% 
  select(매출, 기대수익, 연령) %>% 
  cor() %>% 
  round(2)


# dplyr - 3 ; mutate() = variable의 생성

df <- df %>% 
  mutate(year = as.numeric(substr(df[,9], 1, 4))) %>% 
  mutate(yearC = ifelse(year < 2019, "2019-", "2019+"))


# dplyr - 4 ; arrange() = 정렬

df %>% 
  arrange(매출) %>% 
  head()

df %>% 
  arrange(매출, 기대수익) %>% 
  head()

df %>% 
  arrange(desc(매출)) %>% 
  head()

#filter(df, df$매출 == max(df$매출))
#arrange(df, desc(df$매출))



t.test(df$매출 ~ df$yearC) 




df %>% 
  mutate(year = as.numeric(substr(df[,9], 1, 4))) %>% 
  mutate(yearC = ifelse(year < 2019, "2019-", "2019+")) %>% 
  ggplot(aes(x=yearC, y=매출)) + 
  geom_col()

# dplyr - 5 ; group_by()
# dplyr - 6 ; summarise() 둘은 거의 같이 사용된다

df %>% 
  group_by(성별) %>% 
  summarise(count=n(), mean(매출), mean(기대수익))

df %>% 
  group_by(yearC) %>% 
  summarise(count=n(), mean(매출), mean(기대수익))


#ref. table class 결과물의 index
# 
# f1 <- table(df$`멤버십 등급`) #df가 있는 경우
# f2 <- table(df$`멤버십 등급`)
# class(f1)
# 
# f1/f2
# 
# a <- as.vector(f1); a
# b <- as.vector(f2); b
# 
# a / b
# 
# tab <- table(df$성별, df$호텔이용)
# str(tab)
# 
# class(tab)
# class(df)
# class(myn)
# 
# tab[, 1]
# untab <- as.vector(tab)
# untab
# str(untab)
# 
# df
# table(df$호텔이용, df$`멤버십 등급`)
# prop.table(table(df$호텔이용, df$`멤버십 등급`), 1)*100
# addmargins(prop.table(table(df$호텔이용, df$`멤버십 등급`), 2)*100)
# 


# 차트에 라벨을 붙여야 하는 경우는 summary tab을 먼저 만들고 차트를 그린다

tab <- df %>% 
  group_by(yearC) %>% 
  summarise(mean(매출))

tab
str(tab)
unclass(tab)

tabr <- round(tab[,2], 0)


#ggplot에서 데이터셋, x, y와 라벨만 고치면 항상 이런 유형의 막대 그래프가 생성 된다
ggplot(tab, aes(x = yearC, y = tab$`mean(매출)`)) + 
  geom_col(fill = 'skyblue') +
  scale_y_continuous(labels=function(x) format(x, big.mark = ",", scientific = FALSE)) +
  geom_text(aes(label = format(round(as.numeric(..y..), 0), big.mark=",")), color = "white", size = 4.5, position = position_stack(vjust = 0.5)) +
  xlab("가입 연도") +
  ylab("매출액") +
  ggtitle("[차트] 맴버십 가입 연도에 따른 매출액 비교")



########
#실전 예제 1
#0) df 오브젝트(객체)를 불러와서 1) 매출을 오름차순으로 정리하고 2)평균값을 기준으로 매출 상하 집단을 분리하여 3) 성별 빈도와 테이블 작성 4) 분리된 집단의 나이 평균을 구하시오

#실전 예제 2
#0) 퀀트모드 라이브러리를 이용하여 파라다이스 주가 데이터를 받아오고 1) 데이터 내 NA 존재 확인 있다면 2) NA 데이터를 뺀 정제된 데이터 셋을 dplyr를 활용하여 만드시오

#정답

# rm(list=ls(all=T))
# 
# library(quantmod)
# library(dplyr)
# 
# stock <- getSymbols("034230.KQ", env=NULL)
# str(stock)
# index(stock)
# 
# df <- as.data.frame(stock)
# str(df)
# rownames(df)
# dim(df)
# mean(df[,1]) # error 발생
# mean(df[,1], na.rm = TRUE)
# 
# c1 <- apply(df, 2, is.na)
# apply(c1, 2, sum)
# 
# !is.na(df[,1]) 
# table(!is.na(df[,1]))
# which(!is.na(df[,1]))
# 
# df <- df %>% 
#   filter(!is.na(df[,1]))
# 
# dim(df)
# mean(df[,1])
# 
# str(mtcars)
# str(trees)
# 
# # Built-in data 확인
# list <- data(package = .packages(all.available = TRUE))
# 
# data(sample_matrix)
# str(sample_matrix)
# 
# 
# 

df %>% 
  arrange(매출) %>% 
  ggplot(aes(x=as.numeric(rownames(df)), y=매출)) + geom_point()


ggplot(tab, aes(x=tab[,1], y=tab[,2])) + geom_col() +
  geom_text(position=position_stack(vjust=0.5) , col="white", aes(label=comma(round(..y.., 0), 0)))


